from django.contrib import admin
from .models import Question, Game
# Register your models here.
class QuestionAdmin(admin.ModelAdmin):
    list_display = ('id', 'text', 'category', 'difficulty', 'answer','hint')
    list_filter = ('category', 'difficulty')
    search_fields = ('text', 'answer', 'hint')
    ordering = ('category', 'difficulty')

class GameAdmin(admin.ModelAdmin):
    list_display = ('level', 'math_question', 'science_question', 
                   'geography_question', 'history_question', 'islamic_question')
    list_filter = ('level',)
    search_fields = ('level',)
    raw_id_fields = ('math_question', 'science_question', 
                    'geography_question', 'history_question', 'islamic_question')

admin.site.register(Question, QuestionAdmin)
admin.site.register(Game, GameAdmin)