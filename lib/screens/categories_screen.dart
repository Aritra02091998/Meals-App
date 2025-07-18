import 'package:flutter/material.dart';
import 'package:meals_app/models/category_blueprint.dart';
import 'package:meals_app/models/meal_blueprint.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {

  final void Function(MealBlueprint) addOrRemoveFromFavourites;
  final List<MealBlueprint> availableFilteredMeals;

  const CategoriesScreen({
    super.key,
    required this.addOrRemoveFromFavourites,
    required this.availableFilteredMeals,
  });

  void _selectCategory(BuildContext context, CategoryBlueprint category) {
    final List<MealBlueprint> filteredCategoryMeals = 
    availableFilteredMeals.where((eachMealItem) {
      return eachMealItem.categories.contains(category.id);
    }).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return MealsScreen(
            title: category.title, 
            meals: filteredCategoryMeals,
            addOrRemoveFromFavourites: addOrRemoveFromFavourites,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),

      // Grid Configurations
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),

      // Grid Childs.
      children: [
        for (var eachCategory in availableCategories)
          CategoryGridItem(
            category: eachCategory,
            onSelectCategory: () {
              _selectCategory(context, eachCategory);
            },
          ),
      ],
    );
  }
}
