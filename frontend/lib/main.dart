import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF97be79),
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: const Text("A'rosa-je"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: const Color(0XFF5b8f3b),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Scaffold(
              body: Container(
            decoration: const BoxDecoration(
              color: Color(0XFF97be79),
            ),
            child: const Center(
              child: Text(
                'Hello 1',
                style: TextStyle(fontSize: 24, color: Color(0XFF303430)),
              ),
            ),
          )),
          Scaffold(
            backgroundColor: const Color(0XFF97be79),
            body: Center(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    height: 60,
                    margin: const EdgeInsets.only(
                        left: 80, right: 80, top: 20, bottom: 20),
                    decoration: const BoxDecoration(
                      color: Color(0XFF5b8f3b),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Mes données',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0XFFcfcbcf),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.only(
                        left: 80, right: 80, top: 20, bottom: 20),
                    decoration: const BoxDecoration(
                      color: Color(0XFF5b8f3b),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Mes plantes',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0XFFcfcbcf),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.only(
                        left: 80, right: 80, top: 20, bottom: 20),
                    decoration: const BoxDecoration(
                      color: Color(0XFF5b8f3b),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Mes annonces',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0XFFcfcbcf),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.only(
                        left: 80, right: 80, top: 20, bottom: 20),
                    decoration: const BoxDecoration(
                      color: Color(0XFF5b8f3b),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Mes réservations',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0XFFcfcbcf),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    margin: const EdgeInsets.only(
                        left: 80, right: 80, top: 20, bottom: 20),
                    decoration: const BoxDecoration(
                      color: Color(0XFF5b8f3b),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Mes avis',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0XFFcfcbcf),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
          height: 80,
          color: const Color(0XFF97be79),
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
