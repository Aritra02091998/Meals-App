import 'package:flutter/material.dart';

class MealItemMinuteDetails extends StatelessWidget {
  
  final IconData iconName;
  final String label;

  const MealItemMinuteDetails({
    super.key, 
    required this.iconName, 
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Icon(
          iconName,
          size: 17,
          color: Colors.white ,
        ),

        const SizedBox(width: 6),

        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
