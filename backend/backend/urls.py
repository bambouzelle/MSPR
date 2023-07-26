"""backend URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import include,path
from django.contrib import auth
from django.contrib.auth.views import LoginView, LogoutView
from backendapp import views

urlpatterns = [
    path('admin/', admin.site.urls),
    ##path('account/', include('django.contrib.auth.urls')),
    path('login/', views.login, name='login'),
    path('logout/', LogoutView.as_view(), name='logout'),
    path('model/', views.get_plant_family, name='get_plant_family'),
    path('persons/', views.get_all_persons, name='get_all_persons'),
    path('persons/<int:id>/', views.get_person_by_id, name='get_person_by_id'),
    path('persons/<str:name>/', views.get_person_by_name, name='get_person_by_name'),
    path('persons/create/', views.create_person, name='create_person'),
    path('persons/update/<int:id>/', views.update_person, name='update_person'),
    path('persons/delete/<int:id>/', views.delete_person, name='delete_person'),
    path('plant/', views.get_all_plants, name='get_all_plants'),
    path('plant/<int:id>/', views.get_plant_by_id, name='get_plant_by_id'),
    path('plant/create/', views.create_plant, name='create_plant'),
    path('plant/update/<int:id>/', views.update_plant, name='update_plant'),
    path('plant/delete/<int:id>/', views.delete_plant, name='delete_plant'),
    path('message/', views.get_all_messages, name='get_all_message'),
    path('message/<int:id>/', views.get_message_by_id, name='get_message_by_id'),
    path('message/create/', views.create_message, name='create_message'),
    path('message/update/<int:id>/', views.update_message, name='update_message'),
    path('message/delete/<int:id>/', views.delete_message, name='delete_message'),
    path('plant_reservation/', views.get_all_plant_reservations, name='get_all_plant_reservation'),
    path('plant_reservation/<int:id>/', views.get_plant_reservation_by_id, name='get_plant_reservation_by_id'),
    path('plant_reservation/create/', views.create_plant_reservation, name='create_plant_reservation'),
    path('plant_reservation/update/<int:id>/', views.update_plant_reservation, name='update_plant_reservation'),
    path('reservation/', views.get_all_reservations, name='get_all_reservation'),
    path('reservation/<int:id>/', views.get_reservation_by_id, name='get_reservation_by_id'),
    path('reservation/create/', views.create_reservation, name='create_reservation'),
    path('reservation/update/<int:id>/', views.update_reservation, name='update_reservation'),
]


