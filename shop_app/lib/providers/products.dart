import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_app/app_setting.dart';
import 'package:shop_app/models/http_exceptions.dart';
import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = []; //= DummyData.loadedProduct;

//Getter to return private list of products
  List<Product> get items {
    return _items;
  }

  List<Product> get favoriteItems {
    return _items.where((p) => p.isFavorite).toList();
  }

//Logic seperated from the widget
  Product findById(String id) {
    return _items.firstWhere((p) => p.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    final url = AppSettings.fbUrl + 'products.json';
    try {
      final response = await http.get(url);
      print(response.body);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((prodId, prodData) {
        _items.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite'],
            imageUrl: prodData['imageUrl']));
      });
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final url = AppSettings.fbUrl + 'products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite
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
    } catch (error) {
      print(error);
      throw error;
    }

    // }).catchError((error){
    //   print(error);
    //   throw error;
    // });
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.lastIndexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = AppSettings.fbUrl + 'products/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('product doesnot exit for id : $id');
    }
  }

  void deleteProduct(String id) {
    final url = AppSettings.fbUrl + 'products/$id.json';
    final prodIndex = _items.lastIndexWhere((prod) => prod.id == id);

    var existingProduct = _items[prodIndex];
    _items.removeAt(prodIndex);

    http.delete(url).then((response) {
      print(response.statusCode);
      if (response.statusCode >= 400) {
        print('Could not delete product.');
        throw HttpException('Could not delete product.');
      }
      existingProduct = null;
    }).catchError((_) {
      _items.insert(prodIndex, existingProduct);
    });
    notifyListeners();
  }
}
