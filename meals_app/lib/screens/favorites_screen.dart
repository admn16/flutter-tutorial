import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoritesScreen({
    Key? key,
    required this.favoriteMeals,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Container(
        child: Center(
          child: Text(
            'You have no favorites yet - start adding some!',
          ),
        ),
      );
    }
    return ListView.builder(
      itemBuilder: (ctx, index) {
        final meal = favoriteMeals[index];
        return MealItem(
          id: meal.id,
          title: meal.title,
          imageUrl: meal.imageUrl,
          duration: meal.duration,
          complexity: meal.complexity,
          affordability: meal.affordability,
        );
      },
      itemCount: favoriteMeals.length,
    );
  }
}
