import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_pt_pari_app/model/item_model.dart';
import 'dart:convert';

class ItemViewModel extends ChangeNotifier {
  final String baseUrl = 'https://api.restful-api.dev/objects';

  List<ItemModels> items = [];
  ItemModels? selectedItem;

  Future<void> fetchItems() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        items = data.map((json) => ItemModels.fromJson(json)).toList();
      } else {
        print('Failed to load items: ${response.statusCode}');
        items = [];
      }
    } catch (e) {
      print('Error fetching items: $e');
      items = [];
    }
    notifyListeners();
  }

  Future<void> fetchItemById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      selectedItem = ItemModels.fromJson(json.decode(response.body));
      notifyListeners();
    }
  }

  Future<void> createItem(ItemModels item) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      fetchItems();
    }
  }

  Future<void> updateItem(String id, ItemModels item) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(item.toJson()),
    );
    if (response.statusCode == 200) {
      fetchItems();
    }
  }

  Future<void> deleteItem(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      fetchItems();
    }
  }
}
