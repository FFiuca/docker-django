# Generated by Django 4.1.7 on 2023-10-15 15:45

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('master', '0027_alter_status_created_at_alter_usertype_created_at'),
    ]

    operations = [
        migrations.AlterField(
            model_name='status',
            name='created_at',
            field=models.DateTimeField(default=datetime.datetime(2023, 10, 15, 15, 45, 16, 869701, tzinfo=datetime.timezone.utc)),
        ),
        migrations.AlterField(
            model_name='usertype',
            name='created_at',
            field=models.DateTimeField(default=datetime.datetime(2023, 10, 15, 15, 45, 16, 869701, tzinfo=datetime.timezone.utc)),
        ),
    ]
