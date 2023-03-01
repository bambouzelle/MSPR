import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateReservationPage extends StatefulWidget {
  const CreateReservationPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreateReservationPageState createState() => _CreateReservationPageState();
}

class _CreateReservationPageState extends State<CreateReservationPage> {
  final _formKey = GlobalKey<FormState>();
  final _beginDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _pricingController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _roserController = TextEditingController();

  String _selectedType = 'OH';

  final List<String> _typeOptions = ['OH', 'RH'];

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // ignore: unused_local_variable
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/reservation/create/'),
        body: {
          'type': _selectedType,
          'begin_date': _beginDateController.text,
          'end_date': _endDateController.text,
          'pricing': _pricingController.text,
          'title': _titleController.text,
          'description': _descriptionController.text,
          'roser': _roserController.text,
        },
      );
      // Handle the response from the server.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer une réservation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedType,
                onChanged: (String? value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
                items: _typeOptions
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                decoration: const InputDecoration(
                  labelText: 'Type de réservation',
                ),
              ),
              TextFormField(
                controller: _beginDateController,
                decoration: const InputDecoration(
                  labelText: 'Date de début',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une date de début';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _endDateController,
                decoration: const InputDecoration(
                  labelText: 'Date de fin',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une date de fin';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pricingController,
                decoration: const InputDecoration(
                  labelText: 'Prix',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un prix';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titre',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _roserController,
                decoration: const InputDecoration(
                  labelText: 'Nom de la personne réservant',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nom de la personne réservant';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Créer la réservation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
