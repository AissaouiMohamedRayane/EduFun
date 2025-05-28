from django.urls import path
from .views import get_child_achievements

urlpatterns = [
    path('children/<int:id>/achievements', get_child_achievements, name='child-achievements'),
]