import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_app/app_setting.dart';
import 'package:shop_app/models/http_exceptions.dart';
import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final String authToken;
  final String userId;
  Products(this.authToken, this.userId, this._items);

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

  Future<void> fetchAndSetProducts([bool filterByUser =false]) async {
    final filterString = filterByUser? '&orderBy="creatorId"&equalTo="$userId"':'';
    var url = AppSettings.fbUrl + 'products.json' + '?auth=$authToken'+
    filterString;
    try {
      final response = await http.get(url);
      final List<Product> loadeProducts = [];

      print(response.body);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          AppSettings.fbUrl + 'userFavorites/$userId.json' + '?auth=$authToken';

      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);

      extractedData.forEach((prodId, prodData) {
        loadeProducts.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite:
                favoriteData == null ? false : favoriteData[prodId] ?? false,
            imageUrl: prodData['imageUrl']));
      });
      _items = loadeProducts.toList();
    } catch (error) {
      throw error;
    }
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final url = AppSettings.fbUrl + 'products.json' + '?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'creatorId': userId,
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
      final url = AppSettings.fbUrl + 'products/$id.json' + '?auth=$authToken';
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
    final url = AppSettings.fbUrl + 'products/$id.json' + '?auth=$authToken';
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
