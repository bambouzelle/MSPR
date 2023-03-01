import 'package:flutter/material.dart';
import 'package:frontend/screens/CreatePlantPage.dart';
import '../main.dart';

class PlantDetailPage extends StatelessWidget {
  final Plant plant;

  const PlantDetailPage({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF97be79),
      appBar: AppBar(
        title: const Text('Détails de l\'annonce'),
        toolbarHeight: 80,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: const Color(0XFF5b8f3b),
      ),
      body: Center(
        child: Column(children: [
          const SizedBox(height: 16.0),
          Text(
            plant.name,
            style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Text(
            plant.description,
            style: const TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 16.0),
          const SizedBox(height: 50.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreatePlantPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                backgroundColor: const Color(0XFF5b8f3b),
                minimumSize: const Size(250, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Text('Réserver'),
            ),
          ),
        ]),
      ),
    );
  }
}
