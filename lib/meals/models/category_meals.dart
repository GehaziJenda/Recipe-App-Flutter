// To parse this JSON data, do
//
//     final categoryMeals = categoryMealsFromJson(jsonString);

import 'dart:convert';

Meals mealsFromJson(String str) => Meals.fromJson(json.decode(str));

String mealsToJson(Meals data) => json.encode(data.toJson());

class Meals {
  List<Meal> meals;

  Meals({
    required this.meals,
  });

  factory Meals.fromJson(Map<String, dynamic> json) => Meals(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class Meal {
  String strMeal;
  String strMealThumb;
  String idMeal;

  Meal({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
      );

  Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
      };
}
