from django.shortcuts import render, get_object_or_404
from django.http import JsonResponse
from .models import Person,Plant,Comment
from rest_framework.decorators import api_view

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


@api_view(['GET'])
def get_all_plants(request):
    plants = Plant.objects.all()
    serializer = PlantSerializer(plants, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def get_plant_by_id(request, id):
    try:
        plant = Plant.objects.get(id=id)
    except Plant.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    serializer = PlantSerializer(plant)
    return Response(serializer.data)

@api_view(['POST'])
def create_plant(request):
    serializer = PlantSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['PUT'])
def update_plant(request, id):
    try:
        plant = Plant.objects.get(id=id)
    except Plant.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    serializer = PlantSerializer(plant, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['DELETE'])
def delete_plant(request, id):
    try:
        plant = Plant.objects.get(id=id)
    except Plant.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    plant.delete()
    return Response(status=status.HTTP_204_NO_CONTENT)

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
    comment = get_object_or_404(Comment, id=id)
    comment.delete()
    return JsonResponse({'message': 'Comment deleted successfully!'}, status=204)

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