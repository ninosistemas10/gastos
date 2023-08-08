import 'dart:convert';

FeatureModel featureModelFromJson(String str) =>
    FeatureModel.fromJson(json.decode(str));

String featureModelToJson(FeatureModel data) => json.encode(data.toJson());

class FeatureModel {
  int? id;
  String category;
  String color;
  String icon;

  FeatureModel({
    this.id,
    this.category = '',
    this.color = '#9332a8',
    this.icon = 'local_gas_station_outlined',
  });

  factory FeatureModel.fromJson(Map<String, dynamic> json) => FeatureModel(
        id: json["id"],
        category: json["category"],
        color: json["color"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "color": color,
        "icon": icon,
      };
}
