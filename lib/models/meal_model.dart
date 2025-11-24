class MealModel {
  final String id;
  final String name;
  final String thumb;


  MealModel({required this.id, required this.name, required this.thumb});


  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      thumb: json['strMealThumb'] ?? '',
    );
  }
}