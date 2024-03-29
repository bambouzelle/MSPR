// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'screens/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'A\'rosa-je';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: Login(),
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

Future<List<Plant>> fetchPlant(int id) async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/plant/owner/$id/'));

  if (response.statusCode == 200) {
    List<Plant> listPlant = [];
    for (var i = 0; i < (jsonDecode(response.body) as List).length; i++) {
      listPlant.add(Plant.fromJson(jsonDecode(response.body)[i]));
    }
    return listPlant;
  } else {
    throw Exception('Failed to load Plantes');
  }
}

Future<void> deletePlant(int id) async {
  final url = Uri.parse('http://127.0.0.1:8000/persons/delete/$id/');
  final response = await http.delete(url);

  if (response.statusCode == 200) {
    // ignore: avoid_print
    print('La plante a été supprimée avec succès.');
  } else {
    throw Exception('Impossible de supprimer la plante.');
  }
}

class Plant {
  final int id;
  final String name;
  final String location;
  final String description;
  final String picture;
  final bool sharing;
  final int owner;

  const Plant({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.picture,
    required this.sharing,
    required this.owner,
  });
  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      picture: json['picture'],
      sharing: json['sharing'],
      owner: json['owner'],
    );
  }
}

Future<List<Data>> fetchData() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/person/'));

  if (response.statusCode == 200) {
    List<Data> listData = [];
    for (var i = 0; i < jsonDecode(response.body).length; i++) {
      listData.add(Data.fromJson(jsonDecode(response.body)[i]));
    }
    return listData;
  } else {
    throw Exception('Failed to load Reservations');
  }
}

class Data {
  final int id;
  final String nickname;
  final String mail;
  final String password;

  const Data({
    required this.id,
    required this.nickname,
    required this.mail,
    required this.password,
  });
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      nickname: json['nickname'],
      mail: json['mail'],
      password: json['password'],
    );
  }
}
