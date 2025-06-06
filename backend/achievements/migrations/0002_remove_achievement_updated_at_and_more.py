# Generated by Django 5.2.1 on 2025-05-28 19:03

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('achievements', '0001_initial'),
        ('users', '0004_child_current_level_child_last_attempt_time'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='achievement',
            name='updated_at',
        ),
        migrations.AlterField(
            model_name='achievement',
            name='bronze',
            field=models.PositiveIntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='achievement',
            name='child',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, related_name='achievements', serialize=False, to='users.child'),
        ),
        migrations.AlterField(
            model_name='achievement',
            name='gold',
            field=models.PositiveIntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='achievement',
            name='silver',
            field=models.PositiveIntegerField(default=0),
        ),
    ]
