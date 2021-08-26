import 'package:flutter/material.dart';

import './category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;

  const CategoryItem({Key? key, required this.title, required this.color})
      : super(key: key);

  void selectCategory(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return CategoryMealsScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(15);
    return InkWell(
      borderRadius: borderRadius,
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
