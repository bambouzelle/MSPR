from rest_framework import serializers
from .models import Person, Plant, Comment, Reservation, Plant_reservation, Person_salt

class PersonSerializer(serializers.ModelSerializer):
    class Meta:
        model = Person
        fields = '__all__'

class PlantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Plant
        fields = '__all__'

class MessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message
        fields = '__all__'

class ReservationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Reservation
        fields = '__all__'

class PlantReservationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Plant_reservation
        fields = '__all__'

class PersonSaltSerializer(serializers.ModelSerializer):
    class Meta:
        model = Person_salt
        fields = '__all__'