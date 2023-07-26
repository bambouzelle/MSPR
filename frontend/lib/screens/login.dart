import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:frontend/screens/home_page.dart';
import 'package:frontend/styles/styles.dart';
import 'register.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int idConnected = 1;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<bool> login(mail, password) async {
    final body = {'mail': mail, 'password': password};
    final jsonString = json.encode(body);
    final response = await http.post(Uri.parse('http://127.0.0.1:8000/login/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonString);
    if (response.statusCode == 200) {
      print('You are connected');
      var idConnected = jsonDecode(response.body)['id'];
      print("dans login");
      print(idConnected);
      this.idConnected = idConnected;
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appBar("Login"),
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
                  controller: emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Email :"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email non saisis !';
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
                      return 'Mot de passe non saisis';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: InkWell(
                    child:
                        const Text('Pas encore de compte ? Créez-en un ici !'),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()),
                      )
                    },
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        login(emailController.text, passwordController.text)
                            .then((result) {
                          print(result);
                          if (result) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const MyStatefulWidget(),
                                  settings:
                                      RouteSettings(arguments: idConnected),
                                ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Login et mot de passe inconnus')),
                            );
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Merci de renseigner les champs')),
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
                    child: const Text('Soumettre'),
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
