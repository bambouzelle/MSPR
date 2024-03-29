from django.db import models

class Person(models.Model):
    id = models.AutoField(primary_key=True)
    nickname = models.CharField(max_length=20)
    mail = models.CharField(max_length=255)
    password = models.CharField(max_length=255)

    def get_id(self):
        return self.id
    class Meta:
        app_label = 'backendapp'

class Plant(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    location = models.CharField(max_length=255)
    description = models.CharField(max_length=255)
    picture = models.TextField()
    sharing = models.BooleanField()
    owner_id = models.ForeignKey(Person, on_delete=models.CASCADE, related_name='plants')

    class Meta:
        app_label = 'backendapp'

class Message(models.Model):
    id = models.AutoField(primary_key=True)
    message = models.CharField(max_length=255)
    date_envoie = models.CharField(max_length=255)
    id_plant = models.ForeignKey(Plant, on_delete=models.CASCADE, related_name='messages_received')
    id_roser = models.ForeignKey(Person, on_delete=models.CASCADE, related_name='messages_written')

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

class Person_salt(models.Model):
    id = models.AutoField(primary_key=True)
    person_id = models.ForeignKey(Person, on_delete=models.CASCADE)
    salt = models.CharField(max_length=255)

    class Meta:
        app_label = 'backendapp'