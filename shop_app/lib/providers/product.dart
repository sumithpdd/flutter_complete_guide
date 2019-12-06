import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../app_setting.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite = false;
//named arguments
  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      bool isFavorite});

  Future<void> toggleFavoriteStatus() async {
    final oldstatus = isFavorite;
    isFavorite = !isFavorite;

    final url = AppSettings.fbUrl + 'products/$id.json';
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );
      if (response.statusCode >= 400) {
        isFavorite = oldstatus;
      }
      notifyListeners();
    } catch (error) {
      isFavorite = oldstatus;
      notifyListeners();
    }
  }
}
