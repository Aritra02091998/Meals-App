import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_blueprint.dart';
import 'package:meals_app/widgets/meal_item_minute_details.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {

  final MealBlueprint meal;
  final void Function(MealBlueprint meal) onSelectMealNavigate;

  const MealItem({
    super.key, 
    required this.meal, 
    required this.onSelectMealNavigate
  });

  String get getCategoryComplexity {
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  }

  String get getCategoryAffordability {
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      child: InkWell(
        onTap: () {
          onSelectMealNavigate(meal);
        },
        child: Stack(
          children: [
            // Image Placeholder
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),

            // Image Overlay and Text
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemMinuteDetails(iconName: Icons.timer, label: '${meal.duration} min'),

                        const SizedBox(width: 12),

                        MealItemMinuteDetails(iconName: Icons.work, label: getCategoryComplexity),

                        const SizedBox(width: 12),

                        MealItemMinuteDetails(iconName: Icons.attach_money, label: getCategoryAffordability),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
