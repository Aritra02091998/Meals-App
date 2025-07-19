import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_item.dart';
import 'package:meals_app/models/meal_blueprint.dart';
import 'package:meals_app/screens/meal_details_screen.dart';

class MealsScreen extends StatelessWidget {

  final String? title;
  final List<MealBlueprint> meals;

  const MealsScreen({
    super.key, 
    this.title, 
    required this.meals,
  });

  void onSelectMealNavigate(BuildContext context, MealBlueprint meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return MealDetailsScreen(
            meal: meal,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainBodyContent = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) {
        return MealItem(
          meal: meals[index],
          onSelectMealNavigate: (meal) {
            onSelectMealNavigate(context, meal);
          },
        );
      },
    );

    if (meals.isEmpty) {
      mainBodyContent = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Uh oh... nothing here!',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),

            const SizedBox(height: 16),

            Text(
              'Try selecting a different category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
      );
    }

    // Handles both the case:
    // 1. When Meal Screen is switched directly from the tabs.
    // 2. When Meal Screnn is switched from thr Categories Screen.
    if (title == null) {
      return mainBodyContent;
    } 
    else {
      return Scaffold(
        appBar: AppBar(title: Text(title!)),
        body: mainBodyContent,
      );
    }
  }
}
