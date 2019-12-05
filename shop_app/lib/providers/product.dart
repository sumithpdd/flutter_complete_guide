import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite =false;
//named arguments
  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      bool isFavorite});

  void toggleFavouriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
