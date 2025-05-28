from django.urls import path
from .views import get_game_by_level, submit_answers, category_statistics

urlpatterns = [
    path('level/<int:level>/', get_game_by_level, name='get-game-by-level'),
    path('submit/', submit_answers, name='submit_answers'),
    path('stats/<int:child_id>/', category_statistics, name='category_statistics'),
]