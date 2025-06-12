import 'package:flutter/material.dart';

class AddPetPage extends StatefulWidget {
  final String category;

  const AddPetPage({super.key, required this.category});

  @override
  State<AddPetPage> createState() => _AddPetPageState();
}

class _AddPetPageState extends State<AddPetPage> {
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String gender = "";
  String age = "";
  String weight = "";
  String description = "";
  String ownerName = "";
  String contact = "";
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Pet")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField("Pet Name", (val) => name = val),
              _buildTextField("Gender", (val) => gender = val),
              _buildTextField("Age", (val) => age = val),
              _buildTextField("Weight", (val) => weight = val),
              _buildTextField("Description", (val) => description = val),
              _buildTextField("Owner Name", (val) => ownerName = val),
              _buildTextField("Contact Details", (val) => contact = val),
              _buildTextField("Image URL", (val) => imageUrl = val),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(
                      context,
                      {
                        "name": name,
                        "gender": gender,
                        "age": age,
                        "weight": weight,
                        "description": description,
                        "ownerName": ownerName,
                        "contact": contact,
                        "image": imageUrl,
                      },
                    );
                  }
                },
                child: const Text("Add Pet"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onSaved) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: TextFormField(
        decoration: InputDecoration(labelText: label),
        validator: (value) => (value == null || value.isEmpty) ? "Enter $label" : null,
        onSaved: (value) => onSaved(value!),
      ),
    );
  }
}
