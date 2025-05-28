from django.contrib import admin
from rest_framework.authtoken.models import Token
from .models import User, Parent, Child

# Make User searchable for autocomplete
class UserAdmin(admin.ModelAdmin):
    search_fields = ['username', 'first_name', 'last_name']

# Allow adding Child from Parent admin
class ChildInline(admin.StackedInline):
    model = Child
    extra = 1
    fields = ('user', 'dob', 'avatar')
    autocomplete_fields = ['user']  # Will now work, since UserAdmin has search_fields

class ParentAdmin(admin.ModelAdmin):
    list_display = ('get_username', 'email', 'family_code', 'get_token')
    readonly_fields = ('get_username', 'family_code', 'get_token')
    inlines = [ChildInline]

    def get_username(self, obj):
        return obj.user.username

    def get_token(self, obj):
        try:
            return Token.objects.get(user=obj.user).key
        except Token.DoesNotExist:
            return 'No token'

    get_username.short_description = 'Username'
    get_token.short_description = 'Token'

# Register models
admin.site.register(User, UserAdmin)
admin.site.register(Parent, ParentAdmin)
admin.site.register(Child)
