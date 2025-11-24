import 'package:flutter/material.dart';
import '../models/meal_model.dart';

class MealCard extends StatelessWidget {
  final MealModel meal;
  MealCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: ClipRRect(borderRadius: BorderRadius.vertical(top: Radius.circular(12)), child: Image.network(meal.thumb, fit: BoxFit.cover))),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(meal.name, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}