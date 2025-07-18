import 'package:flutter/material.dart';
import 'package:meals_app/screens/tabs.dart';
import 'package:meals_app/widgets/MainDrawer.dart';

enum AppliedFilters { glutenFree, lactoseFree, vegetarian, vegan }

class FilterScreen extends StatefulWidget {

  // Class Variable.
  final Map<AppliedFilters, bool> currentFilters;

  const FilterScreen({
    super.key,
    required this.currentFilters,
  });

  @override
  State<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {

  // Class Variables
  var _isGlutenFree = false;
  var _isLactoseFree = false;
  var _isVegan = false;
  var _isVegetarian = false;

  @override
  void initState() {
    super.initState();
    _isGlutenFree = widget.currentFilters[AppliedFilters.glutenFree]!;
    _isLactoseFree = widget.currentFilters[AppliedFilters.lactoseFree]!;
    _isVegan = widget.currentFilters[AppliedFilters.vegan]!;
    _isVegetarian = widget.currentFilters[AppliedFilters.vegetarian]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
      drawer: MainDrawer(
        onSelectScreenFromDrawer: (screenName) {
          if (screenName == 'Meals') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const TabScreen()));
          } else if (screenName == 'Filters') {
            Navigator.pop(context);
          }
        },
      ),

      body: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (didPop) return;
          Navigator.of(context).pop({
            AppliedFilters.glutenFree: _isGlutenFree,
            AppliedFilters.lactoseFree: _isLactoseFree,
            AppliedFilters.vegetarian: _isVegetarian,
            AppliedFilters.vegan: _isVegan,
          });
        },
        child: Column(
          children: [
            // First Filter Btn.
            SwitchListTile(
              title: Text(
                'Gluten-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Only include gluten-free meals.',
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              value: _isGlutenFree,
              onChanged: (boolValuePassed) {
                setState(() {
                  _isGlutenFree = boolValuePassed;
                });
              },
            ),

            // Second Filter Btn.
            SwitchListTile(
              title: Text(
                'Lactose-Free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Only include lactose-free meals.',
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              value: _isLactoseFree,
              onChanged: (boolValuePassed) {
                setState(() {
                  _isLactoseFree = boolValuePassed;
                });
              },
            ),

            // Vegetarian Filter Btn.
            SwitchListTile(
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Only include Vegetarian meals.',
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              value: _isVegetarian,
              onChanged: (boolValuePassed) {
                setState(() {
                  _isVegetarian = boolValuePassed;
                });
              },
            ),

            // Vegan Filter Btn.
            SwitchListTile(
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Text(
                'Only include Vegan meals.',
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
              value: _isVegan,
              onChanged: (boolValuePassed) {
                setState(() {
                  _isVegan = boolValuePassed;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
