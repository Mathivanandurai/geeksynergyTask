// To parse this JSON data, do
//
//     final shoeSizeModel = shoeSizeModelFromJson(jsonString);

import 'dart:convert';

ShoeSizeModel shoeSizeModelFromJson(String str) => ShoeSizeModel.fromJson(json.decode(str));

String shoeSizeModelToJson(ShoeSizeModel data) => json.encode(data.toJson());

class ShoeSizeModel {
  String title;
  bool isAvailable;

  ShoeSizeModel({
    required this.title,
    required this.isAvailable,
  });

  factory ShoeSizeModel.fromJson(Map<String, dynamic> json) => ShoeSizeModel(
    title: json["title"],
    isAvailable: json["isAvailable"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "isAvailable": isAvailable,
  };
}


class ShoeModel {
  String id;
  String description;
  int amount;
  String name;
  String images;

  ShoeModel({
    required this.id,
    required this.description,
    required this.amount,
    required this.name,
    required this.images,
  });

  factory ShoeModel.fromJson(Map<String, dynamic> json) => ShoeModel(
    id: json["id"],
    description: json["description"],
    amount: json["amount"],
    name: json["name"],
    images: json["images"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "amount": amount,
    "name": name,

  };
}
