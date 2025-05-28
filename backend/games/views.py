from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import status
from .models import Game
from .serializers import GameSerializer
from django.utils import timezone
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from users.models import Child
from achievements.models import Achievement
# Create your views here.

@api_view(['GET'])
def get_game_by_level(request, level):
    try:
        game = Game.objects.get(level=level)
        serializer = GameSerializer(game)
        return Response(serializer.data)
    except Game.DoesNotExist:
        return Response(
            {'error': f'Game with level {level} not found'},
            status=status.HTTP_404_NOT_FOUND
        )
        
        


from .models import QuestionAttempt  # Add this import
import logging
logger = logging.getLogger(__name__)
MAX_LEVEL = 100  # Set your maximum level here

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def submit_answers(request):
    """
    Submit quiz answers and calculate results
    Expected POST data:
    {
        "child_id": 1,
        "level": 1,
        "answers": [
            {"question_id": 123, "correct": true},
            {"question_id": 456, "correct": false},
            ...
        ]
    }
    """
    try:
        child_id = request.data.get('child_id')
        level = request.data.get('level')
        answers = request.data.get('answers', [])
        
        # Validate input
        if None in [child_id, level] or len(answers) != 5:
            return Response(
                {'error': 'Invalid request data: expected 5 answers'},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # Get objects
        child = Child.objects.get(user_id=child_id)
        game_level = Game.objects.get(level=level)
        
        # Verify ownership
        if child.parent.user != request.user:
            return Response(
                {'error': 'You can only submit answers for your own children'},
                status=status.HTTP_403_FORBIDDEN
            )
        
        # Verify child is attempting current level
        if child.current_level != level:
            return Response(
                {'error': f'Child should be attempting level {child.current_level}'},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # Check if retry is allowed
        if not child.can_retry_level():
            time_remaining = 7200 - (timezone.now() - child.last_attempt_time).total_seconds()
            return Response(
                {
                    'error': 'Retry not allowed yet',
                    'retry_available_in': time_remaining
                },
                status=status.HTTP_403_FORBIDDEN
            )
        
        # Record attempts and count correct answers
        correct_answers = 0
        for answer in answers:
            question_id = answer.get('question_id')
            is_correct = answer.get('correct', False)
            
            if is_correct:
                correct_answers += 1
            
            # Record the attempt
            QuestionAttempt.objects.create(
                child=child,
                question_id=question_id,
                was_correct=is_correct,
                level=level
            )
        
        # Calculate results
        is_retry = child.last_attempt_time is not None
        level_passed = correct_answers >= game_level.required_score
        
        # Award points and achievements
        points_awarded = 0
        medal_awarded = None
        
        if level_passed:
            if not is_retry:
                # First attempt rewards
                if correct_answers == 3:
                    points_awarded = 20
                    medal_awarded = 'bronze'
                elif correct_answers == 4:
                    points_awarded = 30
                    medal_awarded = 'silver'
                elif correct_answers == 5:
                    points_awarded = 40
                    medal_awarded = 'gold'
                
                # Level up
                if child.current_level < MAX_LEVEL:
                    child.current_level += 1
            else:
                # Retry attempt rewards (50% points)
                if correct_answers == 3:
                    points_awarded = 10
                elif correct_answers == 4:
                    points_awarded = 15
                elif correct_answers == 5:
                    points_awarded = 20
        
        # Update child
        child.points += points_awarded
        if medal_awarded:
            achievement, _ = Achievement.objects.get_or_create(child=child)
            achievement.add_medal(medal_awarded)
        child.last_attempt_time = timezone.now()
        child.save()
        
        return Response({
            'level_passed': level_passed,
            'is_retry': is_retry,
            'points_awarded': points_awarded,
            'total_points': child.points,
            'medal_awarded': medal_awarded,
            'new_level': child.current_level if level_passed else level,
            'can_retry_after': 7200 if not level_passed else None
        })
        
    except Child.DoesNotExist:
        return Response(
            {'error': 'Child not found'},
            status=status.HTTP_404_NOT_FOUND
        )
    except Game.DoesNotExist:
        return Response(
            {'error': 'Game level not found'},
            status=status.HTTP_404_NOT_FOUND
        )
    except Exception as e:
        logger.error(f"Error in submit_answers: {str(e)}")
        return Response(
            {'error': 'Internal server error'},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )
        
        
from django.db.models import Count, Q, F
from django.db.models.functions import Cast
from django.db.models import FloatField
from .models import Question

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def category_statistics(request, child_id):
    """
    Get percentage of correct answers per category for a child
    Response format:
    [
        {
            "category": "MATH",
            "total_questions": 30,
            "correct_answers": 28,
            "percentage": 93.33
        },
        ...
    ]
    """
    try:
        child = Child.objects.get(user_id=child_id)
        
        # Verify ownership
        if child.parent.user != request.user:
            return Response(
                {'error': 'You can only view statistics for your own children'},
                status=status.HTTP_403_FORBIDDEN
            )
        
        # Get all attempts for this child
        attempts = QuestionAttempt.objects.filter(child=child)
        
        # Calculate statistics per category
        categories = [cat[0] for cat in Question.CATEGORY_CHOICES]
        stats = []
        
        for category in categories:
            # Get all attempts in this category
            cat_attempts = attempts.filter(question__category=category)
            
            # Count total questions and correct answers
            total_questions = cat_attempts.count()
            correct_answers = cat_attempts.filter(was_correct=True).count()
            
            # Calculate percentage
            percentage = 0.0
            if total_questions > 0:
                percentage = (correct_answers / total_questions) * 100
            
            stats.append({
                'category': category,
                'category_display': dict(Question.CATEGORY_CHOICES)[category],
                'total_questions': total_questions,
                'correct_answers': correct_answers,
                'percentage': round(percentage, 2)
            })
        
        return Response(stats)
    
    except Child.DoesNotExist:
        return Response(
            {'error': 'Child not found'},
            status=status.HTTP_404_NOT_FOUND
        )
    except Exception as e:
        logger.error(f"Error in category_statistics: {str(e)}")
        return Response(
            {'error': 'Internal server error'},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )