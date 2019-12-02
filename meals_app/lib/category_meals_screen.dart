import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  // final String categoryId;
  // final String categoryTitle;

  // const CategoryMealsScreen(this.categoryId, this.categoryTitle);

  @override
  Widget build(BuildContext context) {
    final routeAgs = ModalRoute.of(context).settings.arguments as Map<String,String>;
    final categoryId= routeAgs['id'];
    final categoryTitle= routeAgs['title'];
    
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Center(
        child: Text('The Recipies for the category'),
      ),
    );
  }
}
