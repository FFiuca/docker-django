# Generated by Django 4.1.7 on 2023-10-15 16:11

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('store', '0009_useritem_store'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='itemstore',
            name='created_at',
        ),
        migrations.AlterField(
            model_name='itemstore',
            name='item',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='pivot_item_store', to='store.useritem'),
        ),
        migrations.AlterField(
            model_name='itemstore',
            name='store',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='pivot_store_item', to='store.userstore'),
        ),
    ]
