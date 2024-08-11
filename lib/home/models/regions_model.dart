// To parse this JSON data, do
//
//     final regions = regionsFromJson(jsonString);

import 'dart:convert';

Regions regionsFromJson(String str) => Regions.fromJson(json.decode(str));

String regionsToJson(Regions data) => json.encode(data.toJson());

class Regions {
  List<Region> regions;

  Regions({
    required this.regions,
  });

  factory Regions.fromJson(Map<String, dynamic> json) => Regions(
        regions:
            List<Region>.from(json["meals"].map((x) => Region.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(regions.map((x) => x.toJson())),
      };
}

class Region {
  String strArea;

  Region({
    required this.strArea,
  });

  factory Region.fromJson(Map<String, dynamic> json) => Region(
        strArea: json["strArea"],
      );

  Map<String, dynamic> toJson() => {
        "strArea": strArea,
      };
}
