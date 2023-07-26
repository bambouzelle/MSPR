import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../styles/styles.dart';

class Message {
  String message;
  int idPlant;
  int idRoser;
  String dateEnvoie;

  Message(
      {required this.message,
      required this.idPlant,
      required this.idRoser,
      required this.dateEnvoie});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      idPlant: json['id_plant'],
      idRoser: json['id_roser'],
      dateEnvoie: json['date_envoie'],
    );
  }
}

class PersonName {
  int id;
  String name;

  PersonName({
    required this.id,
    required this.name,
  });

  factory PersonName.fromJson(Map<String, dynamic> json) {
    return PersonName(
      id: json['id'],
      name: json['nickname'],
    );
  }
}

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<Message> messages = [];
  Map<int, String> personsNames = {};

  @override
  void initState() {
    super.initState();
  }

  //messages recus
  Future<void> fetchMessages(id) async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/message/$id'));
    if (response.statusCode == 200) {
      //print(response.body);
      List<dynamic> data = json.decode(response.body);
      List<Message> fetchedMessages =
          data.map((element) => Message.fromJson(element)).toList();
      Map<int, String> listeNoms = {};
      for (var i = 0; i < fetchedMessages.length; i++) {
        String nickname = await getPersonName(fetchedMessages[i].idRoser);
        listeNoms[i] = nickname;
      }
      messages = fetchedMessages;
      personsNames = listeNoms;
    } else {
      print('error');
    }
  }

  Future<String> getPersonName(id) async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/persons/${id.toString()}'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      //print(data);
      PersonName person = PersonName.fromJson(data);
      return person.name;
    } else {
      return ('${id.toString()} not find');
    }
  }

  @override
  Widget build(BuildContext context) {
    int idConnected = ModalRoute.of(context)!.settings.arguments as int;
    print("dans messages");
    print(idConnected);
    fetchMessages(idConnected);
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appBar('Messages'),
      body: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            Message message = messages[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessageDetailScreen(
                        message: message,
                        name: personsNames[index] ?? 'no name found'),
                  ),
                );
              },
              leading: Text(personsNames[index] ?? 'no name found'),
              title: Text(message.message),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SendMessageScreen(),
              settings: RouteSettings(arguments: [personsNames, idConnected]),
            ),
          );
        },
        backgroundColor: secondaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MessageDetailScreen extends StatelessWidget {
  final Message message;
  final String name;

  const MessageDetailScreen(
      {super.key, required this.message, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: appBar('Détails du message'),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Expéditeur: $name',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Sujet: ${message.message}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ])));
  }
}

class SendMessageScreen extends StatefulWidget {
  const SendMessageScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SendMessageScreenState createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _userController = TextEditingController();

  /*@override
  void dispose() {
    _messageController.dispose();
    _userController.dispose();
    super.dispose();
  }*/

  Future<int> getPersonId(name) async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/persons/${name.toString()}'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      //print(data);
      PersonName person = PersonName.fromJson(data);
      return person.id;
    } else {
      return (0);
    }
  }

  Future<Null> _createMessage(
      Map<int, String> personsNames, int idConnected) async {
    String message = _messageController.text.trim();
    String user = _userController.text.trim();
    int receiverId = 0;

    if (message.isEmpty || user.isEmpty) {
      print('rien');
      return;
    } else {
      DateTime nowDate = DateTime.now();
      DateFormat dateFormat =
          DateFormat("yyyy-MM-dd H:m:s"); // how you want it to be formatted
      String now = dateFormat.format(nowDate);
      print(now);
      if (personsNames.isEmpty) {
        receiverId = await getPersonId(user);
      } else {
        receiverId = personsNames.keys
            .firstWhere((name) => personsNames[name] == user, orElse: () => 0);
        if (receiverId == 0) {
          receiverId = await getPersonId(user);
        }
      }
      print(receiverId);

      Map<String, dynamic> body = {
        'message': message,
        'date_envoie': now,
        'id_plant': 1,
        'id_roser': receiverId,
      };
      String jsonString = jsonEncode(body); // encode map to json
      final response =
          await http.post(Uri.parse('http://127.0.0.1:8000/message/create/'),
              headers: <String, String>{
                'Content-Type': 'application/json',
              },
              body: jsonString);

      if (response.statusCode == 201) {
        print('Message envoyé');
      } else {
        throw Exception('Failed to create message');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<int, String> personsNames = (ModalRoute.of(context)!.settings.arguments
        as List)[0] as Map<int, String>;
    int idConnected =
        (ModalRoute.of(context)!.settings.arguments as List)[1] as int;
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: appBar('Envoyer un message'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _messageController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entre un message';
                }
                return null;
              },
              decoration:
                  const InputDecoration(labelText: 'Contenu du message'),
            ),
            TextFormField(
              controller: _userController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir un destinataire';
                }
                return null;
              },
              decoration:
                  const InputDecoration(labelText: 'Utilisateur destinataire'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _createMessage(personsNames, idConnected);
              },
              child: const Text('Envoyer'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Messagerie',
    home: MessageScreen(),
  ));
}
