import 'package:flutter/material.dart';

class CategoryBlueprint {

  final String id;
  final String title;
  final Color color;

  const CategoryBlueprint({
    required this.id, 
    required this.title, 
    this.color = Colors.orange
  }); 
}


