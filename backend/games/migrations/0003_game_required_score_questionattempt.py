# Generated by Django 5.2.1 on 2025-05-28 19:03

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('games', '0002_question_hint'),
        ('users', '0004_child_current_level_child_last_attempt_time'),
    ]

    operations = [
        migrations.AddField(
            model_name='game',
            name='required_score',
            field=models.PositiveIntegerField(default=3),
        ),
        migrations.CreateModel(
            name='QuestionAttempt',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('was_correct', models.BooleanField()),
                ('timestamp', models.DateTimeField(auto_now_add=True)),
                ('level', models.PositiveIntegerField()),
                ('child', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='attempts', to='users.child')),
                ('question', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='games.question')),
            ],
            options={
                'indexes': [models.Index(fields=['child', 'question'], name='games_quest_child_i_f2b2dc_idx')],
            },
        ),
    ]
