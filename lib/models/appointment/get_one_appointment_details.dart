import 'dart:convert';

import '../chartArchive/service_detailsByID_model.dart';

class GetOneAppoinmentDetailsModel {
  final String? id;
  final ClientId? clientId;
  final String? userId;
  final List<String>? areaOfConcern;
  final List<String>? treatments;
  final List<InventoryAcc>? inventoryAcc;
  final String? description;
  final int? fullCost;
  final String? name;
  final int? age;
  final bool? isHuman;
  final bool? isAnimal;
  final String? breed;
  final String? gender;
  final int? height;
  final String? color;
  final int? discount;
  final int? finalCost;
  final bool? isPaid;
  final List<String>? points;
  final List<String>? concernImages;
  final DateTime? apDate;
  final String? apStartTime;
  final String? apEndTime;
  final bool? reAllDay;
  final bool? reTwelveHourBefore;
  final bool? reOneDayBefore;
  final bool? reTwoDayBefore;
  final bool? reOneWeekBefore;
  final bool? isAppointment;
  final String? selectedAnimal;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  GetOneAppoinmentDetailsModel({
    this.id,
    this.clientId,
    this.userId,
    this.areaOfConcern,
    this.treatments,
    this.inventoryAcc,
    this.description,
    this.fullCost,
    this.name,
    this.age,
    this.isHuman,
    this.isAnimal,
    this.breed,
    this.gender,
    this.height,
    this.color,
    this.discount,
    this.finalCost,
    this.isPaid,
    this.points,
    this.concernImages,
    this.apDate,
    this.apStartTime,
    this.apEndTime,
    this.reAllDay,
    this.reTwelveHourBefore,
    this.reOneDayBefore,
    this.reTwoDayBefore,
    this.reOneWeekBefore,
    this.isAppointment,
    this.selectedAnimal,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory GetOneAppoinmentDetailsModel.fromJson(Map<String, dynamic> json) {
    // Helper function to parse JSON string arrays
    List<String> parseStringArray(dynamic data) {
      if (data == null) return [];
      if (data is List) {
        return data.map((e) => e.toString()).toList();
      }
      if (data is String) {
        try {
          final parsed = jsonDecode(data) as List;
          return parsed.map((e) => e.toString()).toList();
        } catch (e) {
          return [data];
        }
      }
      return [data.toString()];
    }

    return GetOneAppoinmentDetailsModel(
      id: json['_id'] as String?,
      clientId:
          json['clientId'] != null ? ClientId.fromJson(json['clientId']) : null,
      userId: json['userId'] as String?,
      areaOfConcern: parseStringArray(json['areaOfConcern']),
      treatments: (json['treatments'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      inventoryAcc: json['inventoryAcc'] != null
          ? List<InventoryAcc>.from(
              json['inventoryAcc'].map((x) => InventoryAcc.fromJson(x)))
          : null,
      description: json['description'] as String?,
      fullCost: json['fullCost'] as int?,
      name: json['name'] as String?,
      age: json['age'] as int?,
      isHuman: json['isHuman'] as bool?,
      isAnimal: json['isAnimal'] as bool?,
      breed: json['breed'] as String?,
      gender: json['gender'] as String?,
      height: json['height'] as int?,
      color: json['color'] as String?,
      discount: json['discount'] as int?,
      finalCost: json['finalCost'] as int?,
      isPaid: json['isPaid'] as bool?,
      points: parseStringArray(json['points']),
      concernImages: (json['Concern_images'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      apDate: json['ApDate'] != null ? DateTime.parse(json['ApDate']) : null,
      apStartTime: json['ApStartTime'] as String?,
      apEndTime: json['ApEndTime'] as String?,
      reAllDay: json['ReAllDay'] as bool?,
      reTwelveHourBefore: json['ReTwelveHourBefore'] as bool?,
      reOneDayBefore: json['ReOneDayBefore'] as bool?,
      reTwoDayBefore: json['ReTwoDayBefore'] as bool?,
      reOneWeekBefore: json['ReOneWeekBefore'] as bool?,
      isAppointment: json['isAppointment'] as bool?,
      selectedAnimal: json['selectedAnimal'] as String?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'] as int?,
    );
  }
}
