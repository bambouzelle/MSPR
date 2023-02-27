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
from . import views

urlpatterns = [
    path('admin/', admin.site.urls),
    ##path('account/', include('django.contrib.auth.urls')),
    path('login/', LoginView.as_view(), name='login'),
    path('logout/', LogoutView.as_view(), name='logout'),
    path('persons/', views.get_all_persons, name='get_all_persons'),
    path('persons/<int:id>/', views.get_person_by_id, name='get_person_by_id'),
    path('persons/create/', views.create_person, name='create_person'),
    path('persons/update/<int:id>/', views.update_person, name='update_person'),
    path('plant/', views.get_all_plants, name='get_all_plants'),
    path('plant/<int:id>/', views.get_plant_by_id, name='get_plant_by_id'),
    path('plant/create/', views.create_plant, name='create_plant'),
    path('plant/update/<int:id>/', views.update_plant, name='update_plant'),
    path('comment/', views.get_all_plants, name='get_all_comment'),
    path('comment/<int:id>/', views.get_plant_by_id, name='get_comment_by_id'),
    path('comment/create/', views.create_plant, name='create_comment'),
    path('comment/update/<int:id>/', views.update_plant, name='update_comment'),
    path('plant_reservation/', views.get_all_plants, name='get_all_plant_reservation'),
    path('plant_reservation/<int:id>/', views.get_plant_by_id, name='get_plant_reservation_by_id'),
    path('plant_reservation/create/', views.create_plant, name='create_plant_reservation'),
    path('plant_reservation/update/<int:id>/', views.update_plant, name='update_plant_reservation'),
    path('reservation/', views.get_all_plants, name='get_all_reservation'),
    path('reservation/<int:id>/', views.get_plant_by_id, name='get_reservation_by_id'),
    path('reservation/create/', views.create_plant, name='create_reservation'),
    path('reservation/update/<int:id>/', views.update_plant, name='update_reservation'),
]


