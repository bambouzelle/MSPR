import 'package:flutter/material.dart';
import 'package:frontend/screens/create_plant_page.dart';
import '../main.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return const MyPlants();
  }
}

class MyPlants extends StatefulWidget {
  const MyPlants({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyPlantsState createState() => _MyPlantsState();
}

class _MyPlantsState extends State<MyPlants>
    with SingleTickerProviderStateMixin {
  late Future<List> futurePlant;

  @override
  void initState() {
    super.initState();
    futurePlant = fetchPlant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF97be79),
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text("Mes plantes"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: const Color(0XFF5b8f3b),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0XFF97be79),
        ),
        child: Center(
          child: FutureBuilder<List<Plant>>(
              future: futurePlant as Future<List<Plant>>,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => ListTile(
                            title: Text(snapshot.data![index].name),
                            subtitle: Text(snapshot.data![index].description),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlantDetailPage(
                                      plant: snapshot.data![index]),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CreatePlantPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 20, color: Colors.white),
                            backgroundColor: const Color(0XFF5b8f3b),
                            minimumSize: const Size(250, 70),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Text('Ajouter une plante'),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}

class PlantDetailPage extends StatelessWidget {
  final Plant plant;

  const PlantDetailPage({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF97be79),
      appBar: AppBar(
        title: const Text('Détails de la plante'),
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
          const SizedBox(height: 50.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                deletePlant(plant.id);
              },
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20, color: Colors.white),
                backgroundColor: const Color(0XFF5b8f3b),
                minimumSize: const Size(250, 70),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text('Supprimer la plante'),
            ),
          ),
          const SizedBox(height: 30),
        ]),
      ),
    );
  }
}
