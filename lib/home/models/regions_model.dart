// To parse this JSON data, do
//
//     final regions = regionsFromJson(jsonString);

import 'dart:convert';

Regions regionsFromJson(String str) => Regions.fromJson(json.decode(str));

String regionsToJson(Regions data) => json.encode(data.toJson());

class Regions {
  List<Meal> meals;

  Regions({
    required this.meals,
  });

  factory Regions.fromJson(Map<String, dynamic> json) => Regions(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class Meal {
  String strArea;

  Meal({
    required this.strArea,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        strArea: json["strArea"],
      );

  Map<String, dynamic> toJson() => {
        "strArea": strArea,
      };
}
