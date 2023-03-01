import 'package:flutter/material.dart';

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
