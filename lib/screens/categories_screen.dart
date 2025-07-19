import 'package:flutter/material.dart';
import 'package:meals_app/models/category_blueprint.dart';
import 'package:meals_app/models/meal_blueprint.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/data/dummy_data.dart';

class CategoriesScreen extends StatefulWidget {
  final List<MealBlueprint> availableFilteredMeals;

  const CategoriesScreen({super.key, required this.availableFilteredMeals});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  // Class variables.
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, CategoryBlueprint category) {
    final List<MealBlueprint> filteredCategoryMeals = widget.availableFilteredMeals.where((eachMealItem) {
      return eachMealItem.categories.contains(category.id);
    }).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return MealsScreen(title: category.title, meals: filteredCategoryMeals);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      builder: (context, child) {
        return SlideTransition(
          // In here child refers to the "GridView"
          // Bcz, it has been passed as a child of the AnimatedBuilder.
          position: Tween(
              begin: Offset(0, 0.3),
              end: Offset(0, 0)
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              )
            ),
          child: child,
        );
      },
    );
  }
}
