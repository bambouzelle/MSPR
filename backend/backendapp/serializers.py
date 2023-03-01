from rest_framework import serializers
from .models import Person, Plant, Comment, Reservation, Plant_reservation

class PersonSerializer(serializers.ModelSerializer):
    class Meta:
        model = Person
        fields = '__all__'

class PlantSerializer(serializers.ModelSerializer):
    class Meta:
        model = Plant
        fields = '__all__'

class CommentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Comment
        fields = '__all__'

class ReservationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Reservation
        fields = '__all__'

class PlantReservationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Plant_reservation
        fields = '__all__'
