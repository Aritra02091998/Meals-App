import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal_blueprint.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/MainDrawer.dart';
import 'package:meals_app/screens/filters_screen.dart';

const initialFilters = {
  AppliedFilters.glutenFree: false,
  AppliedFilters.lactoseFree: false,
  AppliedFilters.vegetarian: false,
  AppliedFilters.vegan: false,
};

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  // Class variable: To switch between screens present in the lower Tab
  // 0: Categories, 1: Favourites.
  int _selectedPageIndex = 0;
  final List<MealBlueprint> _favouriteMeals = [];
  Map<AppliedFilters, bool> _selectedFilters = initialFilters;

  void _showMessageOnFavouriteBtnPress(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), duration: Duration(seconds: 2)));
  }

  void _addOrRemoveFromFavourites(MealBlueprint meal) {
    bool isExisting = _favouriteMeals.contains(meal);
    setState(() {
      if (isExisting) {
        _favouriteMeals.remove(meal);
        _showMessageOnFavouriteBtnPress('Meal is no longer a favourite.');
      } else {
        _favouriteMeals.add(meal);
        _showMessageOnFavouriteBtnPress('Meal is now a favourite.');
      }
    });
  }

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
      final returnedMapOfFiltersFromFilterScreen = await Navigator.push<Map<AppliedFilters, bool>>(
        context,
        MaterialPageRoute(builder: 
          (context) => const FilterScreen(
            currentFilters: initialFilters,
          )
        ),
      );

      setState(() {
        _selectedFilters = returnedMapOfFiltersFromFilterScreen ?? initialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    // Class Variable.
    final List<MealBlueprint> availableFilteredMeals = dummyMeals.where((meal) {
      if (_selectedFilters[AppliedFilters.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[AppliedFilters.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[AppliedFilters.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[AppliedFilters.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      addOrRemoveFromFavourites: _addOrRemoveFromFavourites,
      availableFilteredMeals: availableFilteredMeals,
    );
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePageTitle = 'Your Favourites';
      activePage = MealsScreen(
        meals: _favouriteMeals, 
        addOrRemoveFromFavourites: _addOrRemoveFromFavourites
      );
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
