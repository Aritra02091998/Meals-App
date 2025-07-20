import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal_blueprint.dart';
import 'package:meals_app/providers/favourites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  // Class variable.
  final MealBlueprint meal;

  const MealDetailsScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Local variables.
    final addOrRemoveFromFavourites = ref.read(favouriteMealsProvider.notifier).addOrRemoveFromFavourites;

    final List<MealBlueprint> favouriteMeals = ref.watch(favouriteMealsProvider);
    final bool isThisMealFavourite = favouriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              bool isMealAddedToFav = addOrRemoveFromFavourites(meal);

              // Display Snack Message.
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isMealAddedToFav ? 'Meal Added to Favourites' : 'Meal Removed from Favourites'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(turns: Tween(begin: 0.8, end: 1.0).animate(animation), child: child);
              },
              child: Icon(isThisMealFavourite ? Icons.star : Icons.star_border, key: ValueKey(isThisMealFavourite)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Image
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                width: double.infinity, 
                height: 280, 
                fit: BoxFit.cover
              ),
            ),

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
