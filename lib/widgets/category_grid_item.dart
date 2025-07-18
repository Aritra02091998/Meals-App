import 'package:flutter/material.dart';
import 'package:meals_app/models/category_blueprint.dart';

class CategoryGridItem extends StatelessWidget {

  final CategoryBlueprint category;
  final void Function() onSelectCategory;

  const CategoryGridItem({
    super.key, 
    required this.category,
    required this.onSelectCategory
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            colors: [
              category.color.withAlpha(140),
              category.color.withAlpha(230),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text( 
          category.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,  
          ),
        ),
      ),
    );
  }
}
