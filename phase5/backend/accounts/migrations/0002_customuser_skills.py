# Generated by Django 4.2.2 on 2023-06-27 13:48

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('jobs', '0002_job_address_job_benefit_job_is_remote_and_more'),
        ('accounts', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='customuser',
            name='skills',
            field=models.ManyToManyField(blank=True, to='jobs.skill'),
        ),
    ]
