from django.db import models

class Person(models.Model):
    id = models.AutoField(primary_key=True)
    nickname = models.CharField(max_length=20)
    mail = models.CharField(max_length=255)
    password = models.CharField(max_length=255)

    class Meta:
        app_label = 'backendapp'

class Plant(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    location = models.CharField(max_length=255)
    description = models.CharField(max_length=255)
    picture = models.CharField(max_length=800000)
    sharing = models.BooleanField()
    owner = models.ForeignKey(Person, on_delete=models.CASCADE, related_name='plants')

    class Meta:
        app_label = 'backendapp'

class Comment(models.Model):
    id = models.AutoField(primary_key=True)
    description = models.CharField(max_length=255)
    rating = models.SmallIntegerField()
    owner = models.ForeignKey(Person, on_delete=models.CASCADE, related_name='comments_received')
    roser = models.ForeignKey(Person, on_delete=models.CASCADE, related_name='comments_written')

    class Meta:
        app_label = 'backendapp'

class Reservation(models.Model):
    id = models.AutoField(primary_key=True)
    types = [
        ('OH', 'Owner house'),
        ('RH', 'Roser house'),
    ]
    type = models.CharField(max_length=2, choices=types)
    begin_date = models.CharField(max_length=255)
    end_date = models.CharField(max_length=255)
    pricing = models.IntegerField()
    title = models.CharField(max_length=255)
    description = models.CharField(max_length=2000)
    roser = models.ForeignKey(Person, on_delete=models.CASCADE, related_name='reservations_made')
    creation_date = models.CharField(max_length=255)

    class Meta:
        app_label = 'backendapp'

class Plant_reservation(models.Model):
    plant = models.ForeignKey(Plant, on_delete=models.CASCADE)
    reservation = models.ForeignKey(Reservation, on_delete=models.CASCADE)

    class Meta:
        app_label = 'backendapp'
