
import json
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework import status
from rest_framework.authtoken.models import Token
from rest_framework.authentication import TokenAuthentication
from django.contrib.auth.hashers import make_password
from .models import User, Parent, Child
from store.models import PowerUp, Inventory





@api_view(['GET'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def validate_token(request):
    return Response({'message': 'Token is valid'}, status=200)

@api_view(['POST'])
def registerParent(request):
    try:
        data = request.data
        
        # Validate required fields
        required_fields = ['username', 'email', 'first_name', 'last_name', 'password', 'gender', 'avatar']
        for field in required_fields:
            if field not in data:
                return Response(
                    {'error': f'Missing required field: {field}'},
                    status=status.HTTP_400_BAD_REQUEST
                )
        
        # Check if username exists (since email is on Parent)
        if User.objects.filter(username=data['username']).exists():
            return Response(
                {'error': 'Username already registered'},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # Check if email exists in Parent records
        if Parent.objects.filter(email=data['email']).exists():
            return Response(
                {'error': 'Email already registered'},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # Create User
        user = User.objects.create(
            username=data['username'],
            first_name=data['first_name'],
            last_name=data['last_name'],
            gender=data['gender'],
            password=make_password(data['password']),
            is_active=True
        )
        
        # Create Parent profile
        parent = Parent.objects.create(
            user=user,
            email=data['email'],
            avatar=data['avatar']
        )
        token,created=Token.objects.get_or_create(user=user)
        
        return Response(
            {
                'message': 'Parent registered successfully',
                'family_code': parent.family_code,
                'email': parent.email,  # Changed from user.email to parent.email
                'first_name': user.first_name,
                'token': token.key
            },
            status=status.HTTP_201_CREATED
        )
        
    except Exception as e:
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )
      
@api_view(['POST'])
def registerChild(request):
    try:
        data = request.data
        
        # Validate required fields (without password for child)
        required_fields = ['username', 'first_name', 'last_name', 'family_code', 'dob', 'avatar']
        for field in required_fields:
            if field not in data:
                return Response(
                    {'error': f'Missing required field: {field}'},
                    status=status.HTTP_400_BAD_REQUEST
                )
        
        # Check if username exists
        if User.objects.filter(username=data['username']).exists():
            return Response(
                {'error': 'Username already registered'},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # Check if family code exists
        try:
            parent = Parent.objects.get(family_code=data['family_code'])
        except Parent.DoesNotExist:
            return Response(
                {'error': 'Family code does not exist'},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # Create User for the child (without password)
        user = User.objects.create(
            username=data['username'],
            first_name=data['first_name'],
            last_name=data['last_name'],
            is_active=True
        )

        # Create Child profile and link it to the Parent
        child = Child.objects.create(
            user=user,
            parent=parent,  # Link to the parent
            dob=data['dob'],
            avatar=data['avatar']
        )
        PowerUp.initialize_powerups()
        hint_powerup = PowerUp.objects.get(powerup_type='HINT')
        fifty_powerup = PowerUp.objects.get(powerup_type='FIFTY_FIFTY')
    
        Inventory.objects.create(child=child, powerup=hint_powerup, quantity=3)
        Inventory.objects.create(child=child, powerup=fifty_powerup, quantity=2)
            

        # Generate the token for the child
        token, created = Token.objects.get_or_create(user=user)
        
        return Response(
            {
                'message': 'Child registered successfully',
                'family_code': parent.family_code,
                'first_name': user.first_name,
                'token': token.key
            },
            status=status.HTTP_201_CREATED
        )

    except KeyError as e:
        return Response(
            {'error': f'Missing required field: {str(e)}'},
            status=status.HTTP_400_BAD_REQUEST
        )    
   
@api_view(['POST'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def logout(request):
    try:
        # Get and delete the user's token
        token = Token.objects.get(user=request.user)
        token.delete()
        return Response(
            {'message': 'Logged out successfully'},
            status=status.HTTP_200_OK
        )
    except Token.DoesNotExist:
        # Token already doesn't exist, consider it a successful logout
        return Response(
            {'message': 'Already logged out'},
            status=status.HTTP_200_OK
        )
    except Exception as e:
        return Response(
            {'error': 'An unexpected error occurred'},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )
 
        
        
@api_view(['GET'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def get_children(request):
    try:
        try:
            parent = Parent.objects.get(user=request.user)
        except Parent.DoesNotExist:
            return Response(
                {'error': 'Only parents can access this endpoint'},
                status=status.HTTP_403_FORBIDDEN
            )
        
        children = Child.objects.filter(parent=parent)
        
        children_data = []
        for child in children:
            children_data.append({
                'id': child.user.id,
                'username': child.user.username,
                'first_name': child.user.first_name,
                'last_name': child.user.last_name,
                'avatar': child.avatar,
                'points': child.points,  # NEW
                'hints_available': child.hints_available,  # NEW
                'fifty_fifty_available': child.fifty_fifty_available,  # NEW
                'dob': child.dob  # Consider formatting this if needed
            })
        
        return Response(children_data, status=status.HTTP_200_OK)
    
    except Exception as e:
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )
        
        
@api_view(['POST'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def add_child(request):
    """
    Add a new child for the logged-in parent.
    The child is automatically linked to the authenticated parent.
    """
    try:
        data = request.data
        
        # Check if the logged-in user is a parent
        try:
            parent = Parent.objects.get(user=request.user)
        except Parent.DoesNotExist:
            return Response(
                {'error': 'Only parents can add children'},
                status=status.HTTP_403_FORBIDDEN
            )
        
        # Validate required fields
        required_fields = ['username', 'first_name', 'last_name', 'avatar', 'dob']
        for field in required_fields:
            if field not in data:
                return Response(
                    {'error': f'Missing required field: {field}'},
                    status=status.HTTP_400_BAD_REQUEST
                )
        
        # Check if username already exists
        if User.objects.filter(username=data['username']).exists():
            return Response(
                {'error': 'Username already registered'},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # Create User object (required by your model structure)
        user = User.objects.create(
            username=data['username'],
            first_name=data['first_name'],
            last_name=data['last_name'],
            is_active=True
        )
        
        # Create Child profile
        child = Child.objects.create(
            user=user,
            parent=parent,
            avatar=data['avatar'],
            dob=data['dob']
        )
        
        return Response(
            {
                'message': 'Child added successfully',
                'id': child.user.pk,
                'name': f"{user.first_name} {user.last_name}",
                'avatar_number': child.avatar
            },
            status=status.HTTP_201_CREATED
        )
        
    except Exception as e:
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )
        
        
        
@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def edit_child(request, id):
    try:
        try:
            parent = Parent.objects.get(user=request.user)
        except Parent.DoesNotExist:
            return Response(
                {'error': 'Only parents can edit child information'},
                status=status.HTTP_403_FORBIDDEN
            )
        
        try:
            child = Child.objects.get(user_id=id)
            if child.parent.user_id != request.user.id:
                return Response(
                    {'error': 'You can only edit your own children'},
                    status=status.HTTP_403_FORBIDDEN
                )
            user = child.user
        except Child.DoesNotExist:
            return Response(
                {'error': 'Child not found'},
                status=status.HTTP_404_NOT_FOUND
            )
        
        data = request.data
        
        # Update user fields
        if 'first_name' in data:
            user.first_name = data['first_name']
        if 'last_name' in data:
            user.last_name = data['last_name']
        if 'username' in data:
            if User.objects.filter(username=data['username']).exists() and user.username != data['username']:
                return Response(
                    {'error': 'Username already exists'},
                    status=status.HTTP_400_BAD_REQUEST
                )
            user.username = data['username']
        user.save()
        
        # Update child fields
        if 'avatar' in data:
            child.avatar = data['avatar']
        if 'dob' in data:
            child.dob = data['dob']
        # NEW: Update points and powerups if provided
        if 'points' in data:
            child.points = data['points']
        if 'hints_available' in data:
            child.hints_available = data['hints_available']
        if 'fifty_fifty_available' in data:
            child.fifty_fifty_available = data['fifty_fifty_available']
        child.save()
        
        return Response(
            {
                'message': 'Child information updated successfully',
                'id': child.user.id,
                'name': f"{user.first_name} {user.last_name}",
                'avatar_number': child.avatar,
                'points': child.points,  # NEW
                'hints_available': child.hints_available,  # NEW
                'fifty_fifty_available': child.fifty_fifty_available  # NEW
            },
            status=status.HTTP_200_OK
        )
        
    except Exception as e:
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )
        
        
        
        
@api_view(['GET'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def get_parent_info(request):
    """
    Get all information of the currently logged-in parent.
    Requires authentication.
    """
    try:
        # Check if the logged-in user is a parent
        try:
            parent = Parent.objects.get(user=request.user)
        except Parent.DoesNotExist:
            return Response(
                {'error': 'Only parents can access this endpoint'},
                status=status.HTTP_403_FORBIDDEN
            )
        
        # Get the user object for the parent
        user = parent.user
        
        # Prepare the response with all relevant parent information
        parent_data = {
            'id': user.id,
            'username': user.username,
            'first_name': user.first_name,
            'last_name': user.last_name,
            'full_name': f"{user.first_name} {user.last_name}",
            'email': parent.email,
            'family_code': parent.family_code,
            'avatar': parent.avatar,
            'gender': user.gender,
            'date_joined': user.date_joined,
            'is_active': user.is_active
        }
        
        return Response(parent_data, status=status.HTTP_200_OK)
    
    except Exception as e:
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )
        
@api_view(['GET'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def get_child_info(request):
    """
    Get all information of the currently logged-in child.
    Requires authentication.
    """
    try:
        # Check if the logged-in user is a child
        try:
            child = Child.objects.get(user=request.user)
        except Child.DoesNotExist:
            return Response(
                {'error': 'Only children can access this endpoint'},
                status=status.HTTP_403_FORBIDDEN
            )
        
        user = child.user
        parent = child.parent
        
        child_data = {
            'id': user.id,
            'username': user.username,
            'first_name': user.first_name,
            'last_name': user.last_name,
            'avatar': child.avatar,
            'points': child.points,
            'hints_available': child.hints_available,
            'fifty_fifty_available': child.fifty_fifty_available,
            'level': child.current_level,
            
        }
        
        return Response(child_data, status=status.HTTP_200_OK)

    except Exception as e:
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )
@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def edit_parent(request):
    """
    Edit one or more fields of the parent profile.
    Requires authentication.
    """
    try:
        # Check if the logged-in user is a parent
        try:
            parent = Parent.objects.get(user=request.user)
        except Parent.DoesNotExist:
            return Response(
                {'error': 'Only parents can access this endpoint'},
                status=status.HTTP_403_FORBIDDEN
            )
        
        data = request.data
        user = request.user
        
        # Update user fields if provided
        if 'first_name' in data:
            user.first_name = data['first_name']
        
        if 'last_name' in data:
            user.last_name = data['last_name']
            
        if 'username' in data and data['username'] != user.username:
            # Check if the new username already exists
            if User.objects.filter(username=data['username']).exists():
                return Response(
                    {'error': 'Username already exists'},
                    status=status.HTTP_400_BAD_REQUEST
                )
            user.username = data['username']
            
        if 'gender' in data:
            user.gender = data['gender']
        
        # Save user changes
        user.save()
        
        # Update parent fields if provided
        if 'email' in data and data['email'] != parent.email:
            # Check if the new email already exists
            if Parent.objects.filter(email=data['email']).exclude(user=user).exists():
                return Response(
                    {'error': 'Email already registered'},
                    status=status.HTTP_400_BAD_REQUEST
                )
            parent.email = data['email']
            
        if 'avatar' in data:
            parent.avatar = data['avatar']
            
        # Save parent changes
        parent.save()
        
        # Prepare the response with updated parent information
        parent_data = {
            'id': user.id,
            'username': user.username,
            'first_name': user.first_name,
            'last_name': user.last_name,
            'full_name': f"{user.first_name} {user.last_name}",
            'email': parent.email,
            'family_code': parent.family_code,
            'avatar': parent.avatar,
            'gender': user.gender,
            'date_joined': user.date_joined,
            'is_active': user.is_active
        }
        
        return Response({
            'message': 'Parent profile updated successfully',
            'parent': parent_data
        }, status=status.HTTP_200_OK)
    
    except Exception as e:
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )
        
def delete_child(request, id):
    """
    Delete a specific child.
    Only the parent of the child can delete their information.
    """
    try:
        # Check if the logged-in user is a parent
        try:
            parent = Parent.objects.get(user=request.user)
        except Parent.DoesNotExist:
            return Response(
                {'error': 'Only parents can delete children'},
                status=status.HTTP_403_FORBIDDEN
            )
        
        # Find the child by ID
        try:
            child = Child.objects.get(user_id=id)
            
            # Check if this child belongs to the authenticated parent
            if child.parent.user_id != request.user.id:
                return Response(
                    {'error': 'You can only delete your own children'},
                    status=status.HTTP_403_FORBIDDEN
                )
                
            # Get the associated user object
            user = child.user
            
        except Child.DoesNotExist:
            return Response(
                {'error': 'Child not found'},
                status=status.HTTP_404_NOT_FOUND
            )
        
        # Delete the child and associated user
        user.delete()
        child.delete()
        
        return Response(
            {
                'message': 'Child deleted successfully',
                'id': id
            },
            status=status.HTTP_200_OK
        )
        
    except Exception as e:
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        ),
        
        #child login
        
@api_view(['POST'])
def login_child(request):
    try:
        data = request.data
        username = data.get('username')
        family_code = data.get('family_code')

        if not username or not family_code:
            return Response(
                {'error': 'Username and family code are required'},
                status=status.HTTP_400_BAD_REQUEST
            )

        # Look up user
        try:
            user = User.objects.get(username=username)
            child = Child.objects.get(user=user)
        except (User.DoesNotExist, Child.DoesNotExist):
            return Response(
                {'error': 'Invalid username or child not found'},
                status=status.HTTP_404_NOT_FOUND
            )

        # Check parent’s family code
        if child.parent.family_code != family_code:
            return Response(
                {'error': 'Invalid family code'},
                status=status.HTTP_403_FORBIDDEN
            )

        # Issue token
        token, created = Token.objects.get_or_create(user=user)

        return Response({
            'message': 'Login successful',
            'token': token.key,
            'child_name': f"{user.first_name} {user.last_name}",
            'avatar': child.avatar
        }, status=status.HTTP_200_OK)

    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    



@api_view(['GET'])
def check_username(request):
    """
    Check if a username exists in the database
    Parameters:
    - username (query parameter): The username to check
    Returns:
    - JSON response with exists: true/false
    """
    username = request.query_params.get('username', None)
    
    if not username:
        return Response(
            {'error': 'Username parameter is required'},
            status=status.HTTP_400_BAD_REQUEST
        )
    
    exists = User.objects.filter(username__iexact=username).exists()
    
    return Response(
        {'exists': exists},
        status=status.HTTP_200_OK
    )
