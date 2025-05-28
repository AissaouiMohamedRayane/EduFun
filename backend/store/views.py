# store/views.py
# store/views.py
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication
from users.models import Child
from .models import PowerUp, Inventory

@api_view(['GET'])
def powerup_list(request):
    try:
        powerups = PowerUp.objects.filter(powerup_type__in=['HINT', 'FIFTY_FIFTY'])
        
        data = []
        for p in powerups:
            # Handle image URL properly
            image_url = None
            if p.image_url:
                # If it's a FileField/ImageField
                if hasattr(p.image_url, 'url'):
                    image_url = request.build_absolute_uri(p.image_url.url)
                # If it's a string path
                else:
                    image_url = request.build_absolute_uri(p.image_url)
            
            data.append({
                'id': p.id,
                'name': p.name,
                'price': p.price,
                'image_url': image_url,
                'type': p.powerup_type
            })
        
        return Response(data, status=status.HTTP_200_OK)
        
    except Exception:
        return Response(
            {'error': 'Failed to retrieve powerups'},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )
        

@api_view(['POST'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def purchase_powerup(request):
    try:
        # Get child profile
        child = request.user.child_profile
        
        # Validate request data
        powerup_id = request.data.get('powerup_id')
        quantity = int(request.data.get('quantity', 1))
        
        if not powerup_id or quantity < 1:
            return Response({'error': 'Invalid request data'}, status=status.HTTP_400_BAD_REQUEST)
            
        # Get powerup
        try:
            powerup = PowerUp.objects.get(id=powerup_id)
        except PowerUp.DoesNotExist:
            return Response({'error': 'Powerup not found'}, status=status.HTTP_404_NOT_FOUND)
            
        # Calculate total cost
        total_cost = powerup.price * quantity
        
        # Check if child has enough points
        if child.points < total_cost:
            return Response({'error': 'Not enough points'}, status=status.HTTP_400_BAD_REQUEST)
            
        # Deduct points
        child.points -= total_cost
        child.save()
        
        # Update inventory
        inventory_item, created = Inventory.objects.get_or_create(
            child=child,
            powerup=powerup,
            defaults={'quantity': quantity}
        )
        
        if not created:
            inventory_item.quantity += quantity
            inventory_item.save()
        
        return Response({
            'message': 'Purchase successful',
            'new_balance': child.points,
            'powerup': powerup.name,
            'quantity': inventory_item.quantity
        }, status=status.HTTP_200_OK)
        
    except Exception as e:
        return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
