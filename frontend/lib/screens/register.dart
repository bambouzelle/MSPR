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
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();

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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyStatefulWidget()),
                        );
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
