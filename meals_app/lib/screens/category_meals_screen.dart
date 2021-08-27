import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = '/category-meals';
  // final String categoryId;
  // final String categoryTitle;

  // const CategoryMealsScreen({
  //   Key? key,
  //   required this.categoryId,
  //   required this.categoryTitle,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs = ModalRoute.of(context)?.settings.arguments as Map;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    final categoryMeals = DUMMY_MEALS
        .where((meal) => meal.categories.contains(categoryId))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          final meal = categoryMeals[index];
          return MealItem(
            title: meal.title,
            imageUrl: meal.imageUrl,
            duration: meal.duration,
            complexity: meal.complexity,
            affordability: meal.affordability,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
