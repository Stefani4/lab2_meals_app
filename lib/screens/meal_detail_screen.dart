import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/meal_detail_model.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  @override
  Widget build(BuildContext context) {
    final MealDetail meal = ModalRoute.of(context)!.settings.arguments as MealDetail;

    return Scaffold(
      appBar: AppBar(title: Text(meal.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(meal.thumb),
            SizedBox(height: 8),
            Text(meal.name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Category: ${meal.category} • Area: ${meal.area}'),
            SizedBox(height: 12),
            Text('Ingredients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...meal.ingredients.map((m) {
              final k = m.keys.first;
              final v = m[k] ?? '';
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text('- $k : $v'),
              );
            }),
            SizedBox(height: 12),
            Text('Instructions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text(meal.instructions),
            SizedBox(height: 12),
            if (meal.youtube.isNotEmpty)
              ElevatedButton.icon(
                onPressed: () async {
                  final Uri url = Uri.parse(meal.youtube);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Could not open the link')),
                    );
                  }
                },
                icon: Icon(Icons.video_library),
                label: Text('Watch on YouTube'),
              ),
          ],
        ),
      ),
    );
  }
}