import 'dart:convert';

class GetNotificationModel {
  final String? id;
  final String? title;
  final String? messageBody;
  final int? timeBefore;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  GetNotificationModel({
    this.id,
    this.title,
    this.messageBody,
    this.timeBefore,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory GetNotificationModel.fromRawJson(String str) => GetNotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetNotificationModel.fromJson(Map<String, dynamic> json) => GetNotificationModel(
    id: json["_id"],
    title: json["title"],
    messageBody: json["messageBody"],
    timeBefore: json["timeBefore"],
    userId: json["userId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "messageBody": messageBody,
    "timeBefore": timeBefore,
    "userId": userId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
