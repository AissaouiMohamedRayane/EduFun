# Generated by Django 5.2 on 2025-04-24 16:04

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='user',
            name='email',
        ),
        migrations.AddField(
            model_name='parent',
            name='email',
            field=models.EmailField(blank=True, max_length=254, unique=True, verbose_name='email address'),
        ),
    ]
