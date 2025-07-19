import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal_blueprint.dart';

class FavouriteMealsNotifier extends StateNotifier<List<MealBlueprint>> {
  FavouriteMealsNotifier() : super([]);

  // State property (variable) holds our data.
  // And, this data isn't editable.
  // To edit, everytime a new copy has to be made.
  bool addOrRemoveFromFavourites(MealBlueprint meal) {
    final isThisMealFavourite = state.contains(meal);

    if (isThisMealFavourite) {
      state = state.where((currentMeal) => currentMeal.id != meal.id).toList();
      return false;
    } 
    else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider = StateNotifierProvider<FavouriteMealsNotifier, List<MealBlueprint>>((ref) {
  return FavouriteMealsNotifier();
});
