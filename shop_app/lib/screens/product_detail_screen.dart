import 'package:flutter/material.dart';
import 'package:shop_app/dummy_data.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // ProductDetailScreen(this.title);

  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final product = DummyData.loadedProduct.firstWhere((p)=> p.id == id);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
