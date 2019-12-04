import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';

import '../dummy_data.dart';

class Products with ChangeNotifier {
  List<Product> _items = DummyData.loadedProduct;

//Getter to return private list of products
  List<Product> get items {
    return _items;
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
