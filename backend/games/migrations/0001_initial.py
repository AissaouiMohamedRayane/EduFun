# Generated by Django 5.2 on 2025-05-28 07:13

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Question',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('text', models.TextField()),
                ('answer', models.CharField(max_length=255)),
                ('choices', models.JSONField()),
                ('category', models.CharField(choices=[('MATH', 'Math'), ('SCIENCE', 'Science'), ('GEOGRAPHY', 'Geography'), ('HISTORY', 'History'), ('ISLAMIC', 'Islamic')], max_length=10)),
                ('difficulty', models.PositiveIntegerField(default=1)),
            ],
        ),
        migrations.CreateModel(
            name='Game',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('level', models.PositiveIntegerField(unique=True)),
                ('geography_question', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='geography_games', to='games.question')),
                ('history_question', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='history_games', to='games.question')),
                ('islamic_question', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='islamic_games', to='games.question')),
                ('math_question', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='math_games', to='games.question')),
                ('science_question', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='science_games', to='games.question')),
            ],
        ),
    ]
