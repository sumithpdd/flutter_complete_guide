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
    final newProduct = Product(
        id: DateTime.now().toString(),
        title: product.title,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl);
    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.lastIndexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('product doesnot exit for id : $id');
    }
  }
  void deleteProduct(String id){
_items.removeWhere((prod)=>prod.id==id);
notifyListeners();
  }
}
