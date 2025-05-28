# store/urls.py
from django.urls import path
from .views import powerup_list , purchase_powerup

urlpatterns = [
    path('powerups/', powerup_list, name='powerup-list'),
    path('purchase/', purchase_powerup, name='purchase-powerup'),
]