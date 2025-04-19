import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier{
  final List<Map<String, dynamic>> cart = [];

  void addProduct(Map<String, dynamic> product) {
    cart.add(product);
    notifyListeners(); // Notify listeners to update the UI
  }

  void removeProduct(Map<String, dynamic> product) {
    cart.remove(product);
    notifyListeners(); // Notify listeners to update the UI
  }
}