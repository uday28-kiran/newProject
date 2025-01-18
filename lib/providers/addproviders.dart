import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ItemProvider with ChangeNotifier {
  List<Map<String, String>> _items = [];

  List<Map<String, String>> get items => _items;

  ItemProvider() {
    _loadItems();
  }

  void addItem(item) {
    _items.add(item);
    _saveItems();
    notifyListeners();
  }

  void editItem(int index, item) {
    _items[index] = item;
    _saveItems();
    notifyListeners();
  }

  void deleteItem(int index) {
    _items.removeAt(index);
    _saveItems();
    notifyListeners();
  }

  void _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('items', jsonEncode(_items));
  }

  void _loadItems() async {
  final prefs = await SharedPreferences.getInstance();
  final itemsString = prefs.getString('items');
  if (itemsString != null) {
    List<dynamic> decodedItems = jsonDecode(itemsString);
    _items = decodedItems.map((item) {
      return Map<String, String>.from(item);
    }).toList();

    notifyListeners();
  }
}

}
