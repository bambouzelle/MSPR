import 'package:flutter/material.dart';
import 'package:frontend/screens/create_plant_page.dart';
import '../main.dart';
import 'package:frontend/styles/styles.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    int idConnected = ModalRoute.of(context)!.settings.arguments as int;
    print('dans plant');
    print(idConnected);
    futurePlant = fetchPlant(idConnected);
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appBar("Mes plantes"),
      body: Container(
        decoration: const BoxDecoration(
          color: primaryColor,
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
                          style: elevatedButtonStyle(),
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
      backgroundColor: primaryColor,
      appBar: appBar('Détails de la plante'),
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
              style: elevatedButtonStyle(),
              child: const Text('Supprimer la plante'),
            ),
          ),
          const SizedBox(height: 30),
        ]),
      ),
    );
  }
}
