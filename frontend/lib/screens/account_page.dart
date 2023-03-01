import 'package:flutter/material.dart';
import 'plant_details_page.dart';
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

class MyData extends StatelessWidget {
  const MyData({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF97be79),
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text("Mes Données"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: const Color(0XFF5b8f3b),
      ),
      body: const Center(
        child: Text('This is My Data'),
      ),
    );
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
                  return ListView.builder(
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
                          ));
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

class Page3 extends StatelessWidget {
  const Page3({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF97be79),
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text("Mes annonces"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: const Color(0XFF5b8f3b),
      ),
      body: const Center(
        child: Text('This is Page 3'),
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF97be79),
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text("Mes réservations"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: const Color(0XFF5b8f3b),
      ),
      body: const Center(
        child: Text('This is Page 4'),
      ),
    );
  }
}

class Page5 extends StatelessWidget {
  const Page5({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF97be79),
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text("Mes avis"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: const Color(0XFF5b8f3b),
      ),
      body: const Center(
        child: Text('This is Page 5'),
      ),
    );
  }
}
