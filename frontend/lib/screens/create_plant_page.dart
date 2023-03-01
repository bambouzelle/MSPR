import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreatePlantPage extends StatefulWidget {
  const CreatePlantPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CreatePlantPageState createState() => _CreatePlantPageState();
}

class _CreatePlantPageState extends State<CreatePlantPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pictureController = TextEditingController();
  final _sharingController = TextEditingController();
  final _ownerController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // ignore: unused_local_variable
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/plant/create/'),
        body: {
          'name': _nameController.text,
          'location': _locationController.text,
          'description': _descriptionController.text,
          'picture': _pictureController.text,
          'sharing': _sharingController.text,
          'owner': _ownerController.text
        },
      );
      // Handle the response from the server.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une location';
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
                controller: _pictureController,
                decoration: const InputDecoration(
                  labelText: 'Image',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une image';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sharingController,
                decoration: const InputDecoration(
                  labelText: 'Partage',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une valeur de partage';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ownerController,
                decoration: const InputDecoration(
                  labelText: 'Owner',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une id owner';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Créer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
