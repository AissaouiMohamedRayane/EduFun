from django.db import models
import random
import string
from django.utils.translation import gettext_lazy as _
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin, BaseUserManager
from django.utils import timezone

class CustomAccountManager(BaseUserManager):
    def create_user(self, username, password=None, **other_fields):
        if not username:
            raise ValueError(_("You must provide an username address"))
        user = self.model(username=username, **other_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user
    
    def create_superuser(self, username, password=None, **other_fields):
        other_fields.setdefault('is_staff', True)
        other_fields.setdefault('is_superuser', True)
        other_fields.setdefault('is_active', True)
        
        return self.create_user(username, password, **other_fields)

class User(AbstractBaseUser, PermissionsMixin):
    username = models.CharField(max_length=30, unique=True)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)
    gender = models.BooleanField(default=True)  # True = male
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    date_joined = models.DateTimeField(default=timezone.now)
    
    USERNAME_FIELD = 'username'
    
    objects = CustomAccountManager()
    
    def __str__(self):
        return self.username

class Parent(models.Model):
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        primary_key=True,
        related_name='parent_profile'
    
        
    )
    email = models.EmailField(
        _("email address"),  # Translation string for admin
        max_length=254,      # Standard max length for email fields
        unique=True,         # Ensures no duplicate emails
        blank=True,         # Field cannot be blank
    )
    family_code = models.CharField(max_length=8, unique=True, editable=False)
    avatar = models.IntegerField()
    
    def save(self, *args, **kwargs):
        if not self.family_code:
            self.family_code = self.generate_family_code()
        super().save(*args, **kwargs)
    
    @staticmethod
    def generate_family_code():
        """Generate a random 8-character alphanumeric family code"""
        while True:
            code = ''.join(random.choices(string.ascii_uppercase + string.digits, k=8))
            if not Parent.objects.filter(family_code=code).exists():
                return code
            
    def __str__(self):
        return self.user.username        

class Child(models.Model):
    user = models.OneToOneField(
        User,
        on_delete=models.CASCADE,
        primary_key=True,
        related_name='child_profile',

    )
    parent = models.ForeignKey(Parent, on_delete=models.CASCADE)
    dob = models.DateField()
    avatar = models.IntegerField()
    points = models.PositiveIntegerField(default=90)
    hints_available = models.PositiveIntegerField(default=3)
    fifty_fifty_available = models.PositiveIntegerField(default=2)
    current_level = models.PositiveIntegerField(default=1)
    last_attempt_time = models.DateTimeField(null=True, blank=True)
    
    def can_retry_level(self):
        if not self.last_attempt_time:
            return True
        return (timezone.now() - self.last_attempt_time).total_seconds() >= 7200  # 2 hours
    
    def __str__(self):
        return self.user.username
    class Meta:
        unique_together = ('parent', 'user')