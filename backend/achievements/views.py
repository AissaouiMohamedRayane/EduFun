from django.shortcuts import render
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from .models import Achievement
from users.models import Child, Parent

# Create your views here.

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def get_child_achievements(request, id):
    """
    Get medals (gold, silver, bronze) for a specific child.
    Only the parent of the child can access this endpoint.
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
        
        # Find the child by ID
        try:
            child = Child.objects.get(user_id=id)
            # Check if this child belongs to the authenticated parent
            if child.parent.user_id != request.user.id:
                return Response(
                    {'error': 'You can only access achievements of your own children'},
                    status=status.HTTP_403_FORBIDDEN
                )
        except Child.DoesNotExist:
            return Response(
                {'error': 'Child not found'},
                status=status.HTTP_404_NOT_FOUND
            )
        
        # Get or create achievements for the child
        achievement, created = Achievement.objects.get_or_create(child=child)
        
        # Manually construct the response
        return Response(
            {
                'gold': achievement.gold,
                'silver': achievement.silver,
                'bronze': achievement.bronze
            },
            status=status.HTTP_200_OK
        )
    
    except Exception as e:
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )