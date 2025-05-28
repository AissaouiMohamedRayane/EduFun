from django.db import models
from django.db import models
from users.models import Child
# Create your models here.

class Achievement(models.Model):
    child = models.OneToOneField(
        Child,
        on_delete=models.CASCADE,
        primary_key=True,
        related_name='achievements'
    )
    gold = models.PositiveIntegerField(default=0)
    silver = models.PositiveIntegerField(default=0)
    bronze = models.PositiveIntegerField(default=0)
    
    def add_medal(self, medal_type):
        if medal_type == 'gold':
            self.gold += 1
        elif medal_type == 'silver':
            self.silver += 1
        elif medal_type == 'bronze':
            self.bronze += 1
        self.save()
    
    class Meta:
        verbose_name = "Achievement"
        verbose_name_plural = "Achievements"

    def __str__(self):
        return f"Achievements for {self.child.user.username}"

    

