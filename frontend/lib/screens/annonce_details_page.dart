import 'package:flutter/material.dart';
import '../main.dart';
import 'package:frontend/styles/styles.dart';

class AnnonceDetailPage extends StatelessWidget {
  final Annonces annonce;

  const AnnonceDetailPage({Key? key, required this.annonce}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text('Détails de l\'annonce'),
        toolbarHeight: 80,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              annonce.title,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(
              annonce.description,
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Prix : ${annonce.pricing} €',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Date de publication : ${annonce.begin_date}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Date de fin : ${annonce.end_date}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 50.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //Navigator.push(
                  //context,
                  //MaterialPageRoute(
                  //builder: (context) => const MyPlants(),
                  //),
                  //);
                },
                style: elevatedButtonStyle(),
                child: const Text('Réserver'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
