from django.db import models

class Person(models.Model):
    id = models.AutoField(primary_key=True)
    nickname = models.CharField(max_length = 20)
    mail = models.CharField(max_length = 255)
    password =  models.CharField(max_length = 255)
  
class Plant(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length = 255)
    location = models.CharField(max_length = 255)
    description =  models.CharField(max_length = 255)
    picture = models.CharField(max_length = 2000)
    sharing = models.BooleanField()
    id_owner = models.ForeignKey(Person, on_delete=models.CASCADE)

class Comment(models.Model):
    id = models.AutoField(primary_key=True)
    description = models.CharField(max_length = 255)
    rating = models.SmallIntegerField()
    id_owner =  models.ForeignKey(Person, on_delete=models.CASCADE)

class Reservation(models.Model):
    id = models.AutoField(primary_key=True)
    types = [
    ('OH', 'Owner house'),
    ('RH', 'Roser house')
    ]
    type = models.CharField(max_length=2, choices=types)
    begin_date = models.CharField(max_length = 255)
    end_date = models.CharField(max_length = 255)
    pricing = models.IntegerField()
    title = models.CharField(max_length = 255)
    description = models.CharField(max_length = 2000)
    id_roser = models.ForeignKey(Person, on_delete=models.CASCADE)
    creation_date = models.CharField(max_length = 255)


class Plant_reservation(models.Model):
    id_plant = models.ForeignKey(Plant, on_delete=models.CASCADE)
    id_reservation = models.ForeignKey(Reservation, on_delete=models.CASCADE)
