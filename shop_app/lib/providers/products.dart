import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import '../dummy_data.dart';

class Products with ChangeNotifier {
  List<Product> _items = DummyData.loadedProduct;

//Getter to return private list of products
  List<Product> get items {
    return _items;
  }

  List<Product> get favouriteItems {
    return _items.where((p) => p.isFavorite).toList();
  }

//Logic seperated from the widget
  Product findById(String id) {
    return _items.firstWhere((p) => p.id == id);
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
