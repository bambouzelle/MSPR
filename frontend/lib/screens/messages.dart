import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Message {
  String message;
  String id_plant;
  String id_roser;
  String date_envoie;

  Message(
      {required this.message,
      required this.id_plant,
      required this.id_roser,
      required this.date_envoie});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      id_plant: json['id_plant'],
      id_roser: json['id_roser'],
      date_envoie: json['date_envoie'],
    );
  }
}

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/message'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Message> fetchedMessages =
          data.map((json) => Message.fromJson(json)).toList();
      setState(() {
        messages = fetchedMessages;
      });
    } else {
      // Gérer l'erreur
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Messages')),
        body: ListView.builder(
            itemCount: messages.length,
            itemBuilder: (context, index) {
              Message message = messages[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MessageDetailScreen(message: message),
                    ),
                  );
                },
                leading: Text(message.id_roser),
                title: Text(message.message[0]),
              );
            }));
  }
}

class MessageDetailScreen extends StatelessWidget {
  final Message message;

  MessageDetailScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Détails du message')),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Expéditeur: ${message.id_roser}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Sujet: ${message.message}',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ])));
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Messagerie',
    home: MessageScreen(),
  ));
}
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);

//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }

// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return const MyMessages();
//   }
// }

// class MyMessages extends StatefulWidget {
//   const MyMessages({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _MyMessagesState createState() => _MyMessagesState();
// }

// class _MyMessagesState extends State<MyMessages>
//     with SingleTickerProviderStateMixin {
//   late Future<List> futurePlant;

//   @override
//   void initState() {
//     super.initState();
//     futureMessages = fetchMessages();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       appBar: appBar("Mes Messages"),
//       body: Container(
//         decoration: const BoxDecoration(
//           color: primaryColor,
//         ),
//         child: Center(
//           child: FutureBuilder<List<Plant>>(
//               future: futurePlant as Future<List<Plant>>,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return Column(
//                     children: [
//                       Expanded(
//                         child: ListView.builder(
//                           itemCount: snapshot.data!.length,
//                           itemBuilder: (_, index) => ListTile(
//                             title: Text(snapshot.data![index].name),
//                             subtitle: Text(snapshot.data![index].description),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => PlantDetailPage(
//                                       plant: snapshot.data![index]),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 16.0),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) =>
//                                       const CreatePlantPage()),
//                             );
//                           },
//                           style: elevatedButtonStyle(),
//                           child: const Text('Ajouter une plante'),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                     ],
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text("${snapshot.error}");
//                 }
//                 return const CircularProgressIndicator();
//               }),
//         ),
//       ),
//     );
//   }
// }

// class PlantDetailPage extends StatelessWidget {
//   final Plant plant;

//   const PlantDetailPage({Key? key, required this.plant}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primaryColor,
//       appBar: appBar('Détails de la plante'),
//       body: Center(
//         child: Column(children: [
//           const SizedBox(height: 16.0),
//           Text(
//             plant.name,
//             style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 16.0),
//           Text(
//             plant.description,
//             style: const TextStyle(fontSize: 18.0),
//           ),
//           const SizedBox(height: 50.0),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16.0),
//             child: ElevatedButton(
//               onPressed: () {
//                 deletePlant(plant.id);
//               },
//               style: elevatedButtonStyle(),
//               child: const Text('Supprimer la plante'),
//             ),
//           ),
//           const SizedBox(height: 30),
//         ]),
//       ),
//     );
//   }
// }
