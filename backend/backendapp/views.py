from django.shortcuts import render
from django.shortcuts import render, get_object_or_404
from django.http import JsonResponse
from .models import Person,Plant,Comment,Plant_reservation,Reservation
from rest_framework.decorators import api_view
from .serializers import PersonSerializer,PlantSerializer,CommentSerializer,PlantReservationSerializer,ReservationSerializer

@api_view(['GET'])
def get_all_persons(request):
    persons = Person.objects.all()
    serializer = PersonSerializer(persons, many=True)
    return JsonResponse(serializer.data, safe=False)

@api_view(['GET'])
def get_person_by_id(request, id):
    person = get_object_or_404(Person, id=id)
    serializer = PersonSerializer(person)
    return JsonResponse(serializer.data)

@api_view(['POST'])
def create_person(request):
    serializer = PersonSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return JsonResponse(serializer.data, status=201)
    return JsonResponse(serializer.errors, status=400)

@api_view(['PUT'])
def update_person(request, id):
    person = get_object_or_404(Person, id=id)
    serializer = PersonSerializer(person, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return JsonResponse(serializer.data)
    return JsonResponse(serializer.errors, status=400)

@api_view(['DELETE'])
def delete_person(request, id):
    try:
        person = get_object_or_404(Person, pk=id)
        person.delete()
        return JsonResponse({'message': f'Person {id} has been deleted'})
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)


@api_view(['GET'])
def get_all_plants(request):
    plants = Plant.objects.all()
    serializer = PlantSerializer(plants, many=True)
    return JsonResponse(serializer.data, safe=False)

@api_view(['GET'])
def get_plant_by_id(request, id):
    plant = get_object_or_404(Plant, id=id)
    serializer = PlantSerializer(plant)
    return JsonResponse(serializer.data)

@api_view(['POST'])
def create_plant(request):
    serializer = PlantSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return JsonResponse(serializer.data, status=201)
    return JsonResponse(serializer.errors, status=400)

@api_view(['PUT'])
def update_plant(request, id):
    try:
        plant = Plant.objects.get(id=id)
    except Plant.DoesNotExist:
        return JsonResponse(status=status.HTTP_404_NOT_FOUND)

    serializer = PlantSerializer(plant, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return JsonResponse(serializer.data)
    return JsonResponse(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['DELETE'])
def delete_plant(request, id):
    try:
        plant = get_object_or_404(Plant, pk=id)
        plant.delete()
        return JsonResponse({'message': f'Plant {id} has been deleted'})
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

@api_view(['GET'])
def get_all_comments(request):
    comments = Comment.objects.all()
    serializer = CommentSerializer(comments, many=True)
    return JsonResponse(serializer.data, safe=False)

@api_view(['GET'])
def get_comment_by_id(request, id):
    comment = get_object_or_404(Comment, id=id)
    serializer = CommentSerializer(comment)
    return JsonResponse(serializer.data)

@api_view(['POST'])
def create_comment(request):
    serializer = CommentSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return JsonResponse(serializer.data, status=201)
    return JsonResponse(serializer.errors, status=400)

@api_view(['PUT'])
def update_comment(request, id):
    comment = get_object_or_404(Comment, id=id)
    serializer = CommentSerializer(comment, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return JsonResponse(serializer.data)
    return JsonResponse(serializer.errors, status=400)

@api_view(['DELETE'])
def delete_comment(request, id):
    try:
        comment = get_object_or_404(Comment, pk=id)
        comment.delete()
        return JsonResponse({'message': f'Comment {id} has been deleted'})
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)

@api_view(['GET'])
def get_all_reservations(request):
    reservations = Reservation.objects.all()
    serializer = ReservationSerializer(reservations, many=True)
    return JsonResponse(serializer.data, safe=False)

@api_view(['GET'])
def get_reservation_by_id(request, id):
    reservation = get_object_or_404(Reservation, id=id)
    serializer = ReservationSerializer(reservation)
    return JsonResponse(serializer.data)

@api_view(['POST'])
def create_reservation(request):
    serializer = ReservationSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return JsonResponse(serializer.data, status=201)
    return JsonResponse(serializer.errors, status=400)

@api_view(['PUT'])
def update_reservation(request, id):
    reservation = get_object_or_404(Reservation, id=id)
    serializer = ReservationSerializer(reservation, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return JsonResponse(serializer.data)
    return JsonResponse(serializer.errors, status=400)

@api_view(['GET'])
def get_all_plant_reservations(request):
    plant_reservations = Plant_reservation.objects.all()
    serializer = PlantReservationSerializer(plant_reservations, many=True)
    return JsonResponse(serializer.data, safe=False)

@api_view(['GET'])
def get_plant_reservation_by_id(request, id):
    plant_reservation = get_object_or_404(Plant_reservation, id=id)
    serializer = PlantReservationSerializer(plant_reservation)
    return JsonResponse(serializer.data)

@api_view(['POST'])
def create_plant_reservation(request):
    serializer = PlantReservationSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return JsonResponse(serializer.data, status=201)
    return JsonResponse(serializer.errors, status=400)

@api_view(['PUT'])
def update_plant_reservation(request, id):
    plant_reservation = get_object_or_404(Plant_reservation, id=id)
    serializer = PlantReservationSerializer(plant_reservation, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return JsonResponse(serializer.data)
    return JsonResponse(serializer.errors, status=400)
