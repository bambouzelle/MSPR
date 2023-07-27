import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:frontend/screens/home_page.dart';
import 'package:frontend/styles/styles.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int idConnected = 0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  TextEditingController nicknameController = TextEditingController();

  Future<Null> createPerson(nickname, mail, password) async {
    Map<String, dynamic> body = {
      'nickname': nickname,
      'mail': mail,
      'password': password
    };
    String jsonString = jsonEncode(body);
    final response =
        await http.post(Uri.parse('http://127.0.0.1:8000/persons/create/'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonString);

    if (response.statusCode == 201) {
      print('Person ' + nickname + ' is created');
      idConnected = jsonDecode(response.body)['id'];
    } else {
      throw Exception('Failed to create person');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appBar("S'inscrire"),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: nicknameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Nickname"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nickname non saisis';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email non saisis';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Mot de passe :"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Merci de saisir un mot de passe !';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: passwordConfirm,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Confirmation du mot de passe :"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Merci de saisir un mot de passe !';
                    }
                    if (value != passwordController.text) {
                      return 'Les mots de passe ne correspondent pas !';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: InkWell(
                    child: const Text('Déjà un compte ? Connectez-vous ici !'),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      )
                    },
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        createPerson(nicknameController.text,
                                emailController.text, passwordController.text)
                            .then((result) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyStatefulWidget(),
                                settings: RouteSettings(arguments: idConnected),
                              ));
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Des champs ne sont pas remplis !')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                      backgroundColor: secondaryColor,
                      minimumSize: const Size(250, 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: const Text('S\'enregistrer'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
