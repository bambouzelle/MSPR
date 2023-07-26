from django.shortcuts import render
from django.shortcuts import render, get_object_or_404
from django.http import JsonResponse
from .models import Person,Plant,Message,Plant_reservation,Reservation,Person_salt
from rest_framework.decorators import api_view
from .serializers import PersonSaltSerializer,PersonSerializer,PlantSerializer,MessageSerializer,PlantReservationSerializer,ReservationSerializer
from backendapp.apps import BackendappConfig
import json

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

@api_view(['GET'])
def get_person_by_name(request, name):
    person = get_object_or_404(Person, nickname=name)
    serializer = PersonSerializer(person)
    return JsonResponse(serializer.data)

@api_view(['POST'])
def create_person(request):
    salt = BackendappConfig.get_salt()
    password = BackendappConfig.encode_password(request.data["password"], salt)
    request.data["password"] = password
    serializer = PersonSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        p = Person.objects.filter(mail=request.data["mail"])[0]
        pId = p.id
        PSdata = {'person_id' : pId,'salt': salt}
        personSaltSerializer = PersonSaltSerializer(data=PSdata)
        if personSaltSerializer.is_valid():
            personSaltSerializer.save()
            return JsonResponse(serializer.data, status=201)
        else: print("pb")
    return JsonResponse(serializer.errors, status=400)

@api_view(['PUT'])
def update_person(request, id):
    person = get_object_or_404(Person, id=id)
    serializer = PersonSerializer(person, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return JsonResponse(serializer.data)
    return JsonResponse(serializer.errors, status=400)

@api_view(['POST'])
def login(request):
    print('login')
    print(request.data)
    person = Person.objects.filter(mail=request.data["mail"])[0]
    print(person)
    if (person.nickname != ""):
        print('personne retrouvée')
        print(person.id)
        salt = Person_salt.objects.filter(person_id=person.id)[0]
        print(salt.salt)
        encodedPassword = BackendappConfig.encode_password(request.data["password"], salt.salt)
        print(encodedPassword)
        print(person.password)
        if(person.password == encodedPassword):
            print('good password')
            #response = HttpResponse('authentified')
            #response.set_cookie('cookie', 'MY COOKIE VALUE')
            return JsonResponse({"authentified" : True, 'id':person.id}, status=200)
        return JsonResponse({"authentified" : False}, status=403)

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
    print(request)
    try:
        image_blob = request.data['picture']
        BackendappConfig.decode_image(image_blob)    
        predictions = BackendappConfig.prediction_plant("image.png")
        request.data["name"] = str(predictions[0])
    except(Exception(e)):
        print(e)
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
def get_all_messages(request):
    messages = Message.objects.all()
    serializer = MessageSerializer(messages, many=True)
    return JsonResponse(serializer.data,safe=False)

@api_view(['GET'])
def get_message_by_id(request, id):
    message = Message.objects.filter(id_roser_id=id)
    serializer = MessageSerializer(message, many=True)
    return JsonResponse(serializer.data,safe=False)

@api_view(['POST'])
def create_message(request):
    serializer = MessageSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return JsonResponse(serializer.data, status=201)
    return JsonResponse(serializer.errors, status=400)

@api_view(['PUT'])
def update_message(request, id):
    message = get_object_or_404(Message, id=id)
    serializer = MessageSerializer(message, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return JsonResponse(serializer.data)
    return JsonResponse(serializer.errors, status=400)

@api_view(['DELETE'])
def delete_message(request, id):
    try:
        message = get_object_or_404(Message, pk=id)
        message.delete()
        return Response({'message': f'Message {id} has been deleted'})
    except Exception as e:
        return Response({'error': str(e)}, status=500)

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

@api_view(['GET'])
def get_plant_family(request):
    if request.method == 'GET':
        
        # sentence is the query we want to get the prediction for
        params =  request.GET.get('image')
        
        # predict method used to get the prediction
        prediction = BackendappConfig.prediction_plant(params)
        
        # returning JSON response
        return JsonResponse(prediction, safe=False)
