# Generated by Django 4.1.6 on 2023-07-26 14:42

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('backendapp', '0008_alter_person_salt_id'),
    ]

    operations = [
        migrations.RenameField(
            model_name='plant',
            old_name='owner',
            new_name='owner_id',
        ),
    ]