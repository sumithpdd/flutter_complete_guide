import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;

  const FavoritesScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    if(favouriteMeals.isEmpty)
    {
    return Center(
      child: Text('You have no favorites yet!'),
    );  
    }
    return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favouriteMeals[index].id,
            title: favouriteMeals[index].title,
            imageUrl: favouriteMeals[index].imageUrl,
            duration: favouriteMeals[index].duration,
            affordability: favouriteMeals[index].affordability,
            complexity: favouriteMeals[index].complexity, 
          );
        },
        itemCount: favouriteMeals.length,
      );
  }
}
