// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'screens/home_page.dart';

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

Future<List<Annonces>> fetchAnnonces() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/reservation/'));

  if (response.statusCode == 200) {
    List<Annonces> listAnnonces = [];
    for (var i = 0; i < jsonDecode(response.body).length; i++) {
      listAnnonces.add(Annonces.fromJson(jsonDecode(response.body)[i]));
    }
    return listAnnonces;
  } else {
    throw Exception('Failed to load Reservations');
  }
}

class Annonces {
  final int id;
  final String type;
  final String begin_date;
  final String end_date;
  final int pricing;
  final String title;
  final String description;
  final int roser;
  final String creation_date;

  const Annonces({
    required this.id,
    required this.type,
    required this.begin_date,
    required this.end_date,
    required this.pricing,
    required this.title,
    required this.description,
    required this.roser,
    required this.creation_date,
  });

  factory Annonces.fromJson(Map<String, dynamic> json) {
    return Annonces(
      id: json['id'],
      type: json['title'],
      begin_date: json['begin_date'],
      end_date: json['end_date'],
      pricing: json['pricing'],
      title: json['title'],
      description: json['description'],
      roser: json['roser'],
      creation_date: json['creation_date'],
    );
  }
}
