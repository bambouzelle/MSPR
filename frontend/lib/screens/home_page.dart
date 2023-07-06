import 'package:flutter/material.dart';
import 'package:frontend/screens/create_reservation_page.dart';
import '../main.dart';
import 'my_plant.dart';
import 'annonce_details_page.dart';
import 'package:frontend/styles/styles.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with SingleTickerProviderStateMixin {
  late Future<List> futureAnnonces;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    futureAnnonces = fetchAnnonces();
  }

  void afficherDetailsAnnonce(int id) {
    Navigator.pushNamed(context, '/details', arguments: id);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appBar("A'rosa-je"),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                color: primaryColor,
              ),
              child: Center(
                child: FutureBuilder<List<Annonces>>(
                    future: futureAnnonces as Future<List<Annonces>>,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (_, index) => ListTile(
                                  title: Text(snapshot.data![index].title),
                                  subtitle:
                                      Text(snapshot.data![index].description),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AnnonceDetailPage(
                                            annonce: snapshot.data![index]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CreateReservationPage()),
                                  );
                                },
                                style: elevatedButtonStyle(),
                                child: const Text('Ajouter une annonce'),
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
          ),
          Scaffold(
            body: Center(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: primaryColor,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          //Navigator.push(
                          //context,
                          //MaterialPageRoute(
                          //builder: (context) => const MyData()),
                          //);
                        },
                        style: elevatedButtonStyle(),
                        child: const Text('Mes données'),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyPlants()),
                          );
                        },
                        style: elevatedButtonStyle(),
                        child: const Text('Mes plantes'),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          //Navigator.push(
                          //context,
                          //MaterialPageRoute(
                          //builder: (context) => const Page3()),
                          //);
                        },
                        style: elevatedButtonStyle(),
                        child: const Text('Mes annonces'),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          //Navigator.push(
                          //context,
                          //MaterialPageRoute(
                          //builder: (context) => const Page4()),
                          //);
                        },
                        style: elevatedButtonStyle(),
                        child: const Text('Mes réservations'),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          //Navigator.push(
                          //context,
                          //MaterialPageRoute(
                          //builder: (context) => const Page5()),
                          //);
                        },
                        style: elevatedButtonStyle(),
                        child: const Text('Mes avis'),
                      ),
                      const SizedBox(height: 0),
                    ]),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
          height: 80,
          color: primaryColor,
          child: TabBar(
            indicator: const BoxDecoration(
                color: Color(0XFF9f6152),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            tabs: <Widget>[
              Tab(
                  child: Column(
                children: const <Widget>[
                  Icon(Icons.home, color: Colors.black, size: 30),
                  Text("Annonces", style: TextStyle(color: Colors.black)),
                ],
              )),
              Tab(
                  child: Column(
                children: const <Widget>[
                  Icon(Icons.account_circle, color: Colors.black, size: 30),
                  Text(
                    "Compte",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )),
            ],
            controller: _tabController,
          ),
        ),
      ),
    );
  }
}
