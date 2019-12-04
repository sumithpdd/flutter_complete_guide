import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/widgets/product_item.dart';

import '../dummy_data.dart';

class ProductOverviewScreen extends StatelessWidget {
  final List<Product> loadedProduct = DummyData.loadedProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MyShop')),
      body: GridView.builder(
        //Add const for performance
        padding: const EdgeInsets.all(10.0),
        itemCount: loadedProduct.length,
        itemBuilder: (ctx, i) => ProductItem(
          loadedProduct[i].id,
          loadedProduct[i].title,
          loadedProduct[i].imageUrl,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
      ),
    );
  }
}
