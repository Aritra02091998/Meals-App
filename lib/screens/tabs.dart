import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_providers.dart';
import 'package:meals_app/models/meal_blueprint.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/MainDrawer.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/providers/favourites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabScreen> {
  // Class variable: To switch between screens present in the lower Tab
  // 0: Categories, 1: Favourites.
  int _selectedPageIndex = 0;

  // Method to switch the screens.
  // From the Bottom Nav Bar.
  void _switchScreenOnClick(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _onSelectScreenFromDrawer(String identifier) async {
    if (identifier == 'Meals') {
      Navigator.pop(context);
    } else if (identifier == 'Filters') {
      Navigator.pop(context);
      await Navigator.push<Map<AppliedFilters, bool>>(
        context,
        MaterialPageRoute(builder: (context) => const FilterScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Accessing the dummyMeals List using the riverpod providers.
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filterProvider);

    // Class Variable.
    final List<MealBlueprint> availableFilteredMeals = meals.where((meal) {
      if (activeFilters[AppliedFilters.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[AppliedFilters.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[AppliedFilters.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (activeFilters[AppliedFilters.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(availableFilteredMeals: availableFilteredMeals);
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMealsProvider);
      activePageTitle = 'Your Favourites';
      activePage = MealsScreen(meals: favouriteMeals);
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),

      drawer: MainDrawer(onSelectScreenFromDrawer: _onSelectScreenFromDrawer),

      body: activePage,

      bottomNavigationBar: BottomNavigationBar(
        onTap: _switchScreenOnClick,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
