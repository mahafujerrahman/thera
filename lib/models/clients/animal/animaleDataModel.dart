// To parse this JSON data, do
//
//     final getAnimalDataModel = getAnimalDataModelFromJson(jsonString);

import 'dart:convert';

GetAnimalDataModel getAnimalDataModelFromJson(String str) => GetAnimalDataModel.fromJson(json.decode(str));

String getAnimalDataModelToJson(GetAnimalDataModel data) => json.encode(data.toJson());

class GetAnimalDataModel {
  final String? name;
  final int? age;
  final String? breed;
  final String? gender;
  final int? height;
  final String? color;

  GetAnimalDataModel({
    this.name,
    this.age,
    this.breed,
    this.gender,
    this.height,
    this.color,
  });

  factory GetAnimalDataModel.fromJson(Map<String, dynamic> json) => GetAnimalDataModel(
    name: json["name"],
    age: json["age"],
    breed: json["breed"],
    gender: json["gender"],
    height: json["height"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "age": age,
    "breed": breed,
    "gender": gender,
    "height": height,
    "color": color,
  };
}
