import 'dart:convert';

class GetClientInfoByIdModel {
  final String? id;
  final String? userId;
  final String? name;
  final String? city;
  final String? state;
  final String? zip;
  final String? phoneNumber;
  final String? email;
  final String? other;
  final int? v;
  final bool? humanClient;

  GetClientInfoByIdModel({
    this.id,
    this.userId,
    this.name,
    this.city,
    this.state,
    this.zip,
    this.phoneNumber,
    this.email,
    this.other,
    this.v,
    this.humanClient,
  });

  factory GetClientInfoByIdModel.fromRawJson(String str) => GetClientInfoByIdModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetClientInfoByIdModel.fromJson(Map<String, dynamic> json) => GetClientInfoByIdModel(
    id: json["_id"],
    userId: json["userId"],
    name: json["name"],
    city: json["city"],
    state: json["state"],
    zip: json["zip"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    other: json["other"],
    v: json["__v"],
    humanClient: json["humanClient"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "name": name,
    "city": city,
    "state": state,
    "zip": zip,
    "phoneNumber": phoneNumber,
    "email": email,
    "other": other,
    "__v": v,
    "humanClient": humanClient,
  };
}
