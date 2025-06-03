from django.db import models

# store/models.py


class PowerUp(models.Model):
    POWERUP_TYPES = [
        ('HINT', 'Hint'),
        ('FIFTY_FIFTY', '50:50'),
    ]
    
    powerup_type = models.CharField(max_length=20, choices=POWERUP_TYPES, unique=True)
    name = models.CharField(max_length=50)
    price = models.PositiveIntegerField()
    image_url = models.URLField(blank=True)
    description = models.TextField(blank=True)

    @classmethod
    def initialize_powerups(cls):
        cls.objects.get_or_create(
            powerup_type='HINT',
            defaults={'name':'Hint', 'price':100, 'image_url':'/images/hint.png'}
        )
        cls.objects.get_or_create(
            powerup_type='FIFTY_FIFTY',
            defaults={'name':'50:50', 'price':200, 'image_url':'/images/fifty-fifty.png'}
        )
    def save(self, *args, **kwargs):
        if not self.image_url:
            if self.powerup_type == 'HINT':
                self.image_url = '/images/hint.png'
            elif self.powerup_type == 'FIFTY_FIFTY':
                self.image_url = '/images/fifty-fifty.png'
        super().save(*args, **kwargs)

        
class Inventory(models.Model):
    child = models.ForeignKey('users.Child', on_delete=models.CASCADE)
    powerup = models.ForeignKey(PowerUp, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=0)

    class Meta:
        unique_together = ('child', 'powerup')
        
        
        