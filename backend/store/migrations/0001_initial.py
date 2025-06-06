# Generated by Django 5.2 on 2025-05-27 16:16

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='PowerUp',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('powerup_type', models.CharField(choices=[('HINT', 'Hint'), ('FIFTY_FIFTY', '50:50')], max_length=20, unique=True)),
                ('name', models.CharField(max_length=50)),
                ('price', models.PositiveIntegerField()),
                ('image_url', models.URLField()),
                ('description', models.TextField(blank=True)),
            ],
        ),
    ]
