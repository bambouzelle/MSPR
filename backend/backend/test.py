from django.contrib.auth.models import User
from django.test import RequestFactory, TestCase



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