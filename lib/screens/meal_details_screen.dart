import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_blueprint.dart';

class MealDetailsScreen extends StatelessWidget {
  final MealBlueprint meal;
  final void Function(MealBlueprint) addOrRemoveFromFavourites;

  const MealDetailsScreen({
    super.key, 
    required this.meal, 
    required this.addOrRemoveFromFavourites
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              addOrRemoveFromFavourites(meal);
            },
            icon: const Icon(Icons.star_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image
            Image.network(meal.imageUrl, width: double.infinity, height: 280, fit: BoxFit.cover),

            const SizedBox(height: 14),

            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            for (var eachIngredient in meal.ingredients)
              Text(
                eachIngredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),

            const SizedBox(height: 14),

            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            for (var eachStep in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  eachStep,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
