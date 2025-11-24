import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../models/meal_model.dart';
import '../models/meal_detail_model.dart';

class ApiService {
  static const base = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<CategoryModel>> fetchCategories() async {
    final url = Uri.parse('$base/categories.php');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['categories'] ?? [];
      return list.map((e) => CategoryModel.fromJson(e)).toList();
    }
    throw Exception('Failed to load categories');
  }

  Future<List<MealModel>> fetchMealsByCategory(String category) async {
    final url = Uri.parse('$base/filter.php?c=$category');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['meals'] ?? [];
      return list.map((e) => MealModel.fromJson(e)).toList();
    }
    throw Exception('Failed to load meals for category');
  }

  Future<List<MealModel>> searchMeals(String query) async {
    final url = Uri.parse('$base/search.php?s=$query');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List? list = data['meals'];
      if (list == null) return [];
      return list.map((e) => MealModel.fromJson(e)).toList();
    }
    throw Exception('Failed to search meals');
  }

  Future<MealDetail> fetchMealDetail(String id) async {
    final url = Uri.parse('$base/lookup.php?i=$id');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['meals'] ?? [];
      if (list.isEmpty) throw Exception('Meal not found');
      return MealDetail.fromJson(list[0]);
    }
    throw Exception('Failed to load meal detail');
  }

  Future<MealDetail> fetchRandomMeal() async {
    final url = Uri.parse('$base/random.php');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      final List list = data['meals'] ?? [];
      return MealDetail.fromJson(list[0]);
    }
    throw Exception('Failed to load random meal');
  }
}