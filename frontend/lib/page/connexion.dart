import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Page de connexion',
    home: ConnexionRoute(),
  ));
}

class ConnexionRoute extends StatelessWidget {
  const ConnexionRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}