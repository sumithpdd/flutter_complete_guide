import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_app/app_setting.dart';
import 'package:shop_app/providers/product.dart';
import '../dummy_data.dart';
import 'package:http/http.dart' as http;

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

  Future<void> addProduct(Product product) async {
    final url = AppSettings.fbUrl + 'products.json';
    try{
 final response = await http.post(
      url,
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isFavourite': product.isFavorite
      }),
    );

    final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl);
    _items.add(newProduct);
    notifyListeners();
    }catch(error){
         print(error);
      throw error;
    }
   
    // }).catchError((error){
    //   print(error);
    //   throw error;
    // });
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

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
