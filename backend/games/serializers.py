from rest_framework import serializers
from .models import Game, Question

class QuestionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Question
        fields = ['id', 'text','hint', 'answer', 'choices', 'category', 'difficulty']

class GameSerializer(serializers.ModelSerializer):
    math_question = QuestionSerializer()
    science_question = QuestionSerializer()
    geography_question = QuestionSerializer()
    history_question = QuestionSerializer()
    islamic_question = QuestionSerializer()
    
    class Meta:
        model = Game
        fields = ['level', 'math_question', 'science_question', 
                 'geography_question', 'history_question', 'islamic_question']