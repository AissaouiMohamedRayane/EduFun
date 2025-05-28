from django.db import models
from users.models import Child

class Question(models.Model):
    CATEGORY_CHOICES = [
        ('MATH', 'Math'),
        ('SCIENCE', 'Science'),
        ('GEOGRAPHY', 'Geography'),
        ('HISTORY', 'History'),
        ('ISLAMIC', 'Islamic'),
    ]
    
    text = models.TextField()
    answer = models.CharField(max_length=255)
    hint = models.CharField(max_length=255 , default='')
    choices = models.JSONField()  # Stores list of choices as JSON
    category = models.CharField(max_length=10, choices=CATEGORY_CHOICES)
    difficulty = models.PositiveIntegerField(default=1)  # 1-5 for example

    def __str__(self):
        return f"{self.category} - {self.text[:50]}..."

class Game(models.Model):
    level = models.PositiveIntegerField(unique=True)
    math_question = models.ForeignKey(Question, on_delete=models.CASCADE, related_name='math_games')
    science_question = models.ForeignKey(Question, on_delete=models.CASCADE, related_name='science_games')
    geography_question = models.ForeignKey(Question, on_delete=models.CASCADE, related_name='geography_games')
    history_question = models.ForeignKey(Question, on_delete=models.CASCADE, related_name='history_games')
    islamic_question = models.ForeignKey(Question, on_delete=models.CASCADE, related_name='islamic_games')
    required_score = models.PositiveIntegerField(default=3)  # Minimum correct answers to pass
    
    def __str__(self):
        return f"Level {self.level} (Need {self.required_score}/5 to pass)"

    def __str__(self):
        return f"Game Level {self.level}"
    
from .models import Question

class QuestionAttempt(models.Model):
    child = models.ForeignKey(Child, on_delete=models.CASCADE, related_name='attempts')
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    was_correct = models.BooleanField()
    timestamp = models.DateTimeField(auto_now_add=True)
    level = models.PositiveIntegerField()

    class Meta:
        indexes = [
            models.Index(fields=['child', 'question']),
        ]

    def __str__(self):
        return f"{self.child.user.username} - {self.question.text[:20]}"

