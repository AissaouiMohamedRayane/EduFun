# store/admin.py
from django.contrib import admin
from .models import PowerUp

@admin.register(PowerUp)
class PowerUpAdmin(admin.ModelAdmin):
    list_display = ('name', 'powerup_type', 'price', 'image_url')
    list_editable = ('price', 'image_url')  # Allows direct editing
    list_filter = ('powerup_type',)
    search_fields = ('name',)
    fieldsets = (
        (None, {
            'fields': ('powerup_type', 'name')
        }),
        ('Details', {
            'fields': ('price', 'image_url', 'description')
        }),
    )