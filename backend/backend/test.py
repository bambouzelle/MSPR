from django.contrib.auth.models import User
from django.test import RequestFactory, TestCase
from PIL import Image
import os


class LoginTest(TestCase):

    def setUp(self):
        
        #création utilisateur de test
        self.user = User.objects.create_user(username='username',password='password')
        self.factory = RequestFactory()

    def test_login(self):

        #crée une requête pour la view login
        request = self.factory.post ('/login/', {'username': 'username', 'password': 'password'})
        response = LoginView.as_view()(request)

        # test que la réponse a été redirigée vers la page d'accueil
        self.assertEqual(response.status_code, 302)
        self.assertEqual(response.url, '/')

        # test que l'utilisateur est bien connectée
        self.assertTrue(request.user.is_authenticated)
        self.assertEqual(request.user.username, 'username')

class testresize(TestCase):
    def test_resize_image(self):
        im = Image.open("")# dossier test

        self.assertNotEqual(im.size, (128, 128))
        im_resized = im.resize((128, 128))
        self.assertEqual(im_resized.size, (128, 128))
    
    def changeformattojpg(self):
        im = Image.open("") #ouvrir l'image en PNG 

        self.assertNotEqual(im.format, "JPEG")
        im.save("", format="JPEG")

        im_resaved = Image.open("") #ouvrir l'image en JPG 
        self.assertEqual(im_resaved.format, "JPEG")