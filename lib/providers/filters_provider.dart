import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/screens/filters_screen.dart';

enum AppliedFilters { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<AppliedFilters, bool>> {
  FiltersNotifier() : super({
    AppliedFilters.glutenFree: false,
    AppliedFilters.lactoseFree: false,
    AppliedFilters.vegetarian: false,
    AppliedFilters.vegan: false,
  });

  // Update the Map
  void setFilter(AppliedFilters filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }

  void setAllFilters(Map<AppliedFilters, bool> chosenFilters) {
    state = chosenFilters;
  }
}

final filterProvider = 
StateNotifierProvider<FiltersNotifier, Map<AppliedFilters, bool>>(
  (ref) => FiltersNotifier()
);

