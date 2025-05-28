from . import views
from django.urls import path
from rest_framework.authtoken.views import obtain_auth_token 
from .views import login_child
from users.views import check_username



urlpatterns = [
    path('validate-token/', views.validate_token),

    
    path('registerParent/', views.registerParent, name='registerParent'),
    path('registerChild/', views.registerChild, name='registerChild'),
    
    path('loginParent/',obtain_auth_token , name='login'),
    path('logout/', views.logout, name='logout'),
    path('loginChild/', login_child, name='login-child'),

    
    path('getchildren/', views.get_children, name='get-children'),
    path('addchild/', views.add_child, name='add-child'),
    path('children/<int:id>/', views.edit_child, name='edit-child'),

    
    path('parent/', views.get_parent_info, name='get-parent-info'),
    path('editParent/', views.edit_parent, name='edit-parent'), 
    path('parent/<int:id>/', views.delete_child, name='delete-child'), 
    
    path('check-username/', check_username, name='check_username'),

]