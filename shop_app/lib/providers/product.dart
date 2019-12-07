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

  Future<void> toggleFavoriteStatus(String authToken,String userId) async {
    final oldstatus = isFavorite;
    isFavorite = !isFavorite;
      notifyListeners();
    final url = AppSettings.fbUrl + 'userFavorites/$userId/$id.json' +'?auth=$authToken';
    try {
      final response = await http.put(
        url,
        body: json.encode(
           isFavorite,
        ),
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
