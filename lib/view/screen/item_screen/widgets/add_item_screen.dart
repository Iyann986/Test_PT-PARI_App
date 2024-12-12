import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pt_pari_app/model/item_model.dart';
import 'package:test_pt_pari_app/view_model/item_view_model.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Item',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dataController,
                decoration: const InputDecoration(
                  labelText: 'Data (JSON)',
                  hintText:
                      '{"year": 2019, "price": 1849.99, "CPU model": "Intel Core i9", "Hard disk size": "1 TB"}',
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter data';
                  }
                  try {
                    jsonDecode(value);
                  } catch (e) {
                    return 'Invalid JSON format';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createItem,
                child: const Text('Create Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createItem() async {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text;
      Map<String, dynamic>? data;

      if (_dataController.text.isNotEmpty) {
        try {
          data = jsonDecode(_dataController.text);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid JSON in Data field')),
          );
          return;
        }
      }

      final newItem = ItemModels(name: name, data: data);
      final itemViewModel = Provider.of<ItemViewModel>(context, listen: false);
      await itemViewModel.createItem(newItem);
      Navigator.pop(context);
    }
  }
}
