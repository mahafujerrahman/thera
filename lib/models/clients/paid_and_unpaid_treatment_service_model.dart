import 'dart:convert';

class GetAllTreatmentModels {
  final String? id;
  final String? clientId;
  final String? userId;
  final List<String>? areaOfConcern;
  final List<dynamic>? inventoryAcc;
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

  GetAllTreatmentModels({
    this.id,
    this.clientId,
    this.userId,
    this.areaOfConcern,
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

  factory GetAllTreatmentModels.fromRawJson(String str) => GetAllTreatmentModels.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllTreatmentModels.fromJson(Map<String, dynamic> json) => GetAllTreatmentModels(
    id: json["_id"],
    clientId: json["clientId"],
    userId: json["userId"],
    areaOfConcern: json["areaOfConcern"] == null ? [] : List<String>.from(json["areaOfConcern"]!.map((x) => x)),
    inventoryAcc: json["inventoryAcc"] == null ? [] : List<dynamic>.from(json["inventoryAcc"]!.map((x) => x)),
    description: json["description"],
    fullCost: json["fullCost"],
    name: json["name"],
    age: json["age"],
    isHuman: json["isHuman"],
    isAnimal: json["isAnimal"],
    breed: json["breed"],
    gender: json["gender"],
    height: json["height"],
    color: json["color"],
    discount: json["discount"],
    finalCost: json["finalCost"],
    isPaid: json["isPaid"],
    points: json["points"] == null ? [] : List<String>.from(json["points"]!.map((x) => x)),
    concernImages: json["Concern_images"] == null ? [] : List<String>.from(json["Concern_images"]!.map((x) => x)),
    apDate: json["ApDate"] == null ? null : DateTime.parse(json["ApDate"]),
    apStartTime: json["ApStartTime"],
    apEndTime: json["ApEndTime"],
    reAllDay: json["ReAllDay"],
    reTwelveHourBefore: json["ReTwelveHourBefore"],
    reOneDayBefore: json["ReOneDayBefore"],
    reTwoDayBefore: json["ReTwoDayBefore"],
    reOneWeekBefore: json["ReOneWeekBefore"],
    isAppointment: json["isAppointment"],
    selectedAnimal: json["selectedAnimal"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "clientId": clientId,
    "userId": userId,
    "areaOfConcern": areaOfConcern == null ? [] : List<dynamic>.from(areaOfConcern!.map((x) => x)),
    "inventoryAcc": inventoryAcc == null ? [] : List<dynamic>.from(inventoryAcc!.map((x) => x)),
    "description": description,
    "fullCost": fullCost,
    "name": name,
    "age": age,
    "isHuman": isHuman,
    "isAnimal": isAnimal,
    "breed": breed,
    "gender": gender,
    "height": height,
    "color": color,
    "discount": discount,
    "finalCost": finalCost,
    "isPaid": isPaid,
    "points": points == null ? [] : List<dynamic>.from(points!.map((x) => x)),
    "Concern_images": concernImages == null ? [] : List<dynamic>.from(concernImages!.map((x) => x)),
    "ApDate": apDate?.toIso8601String(),
    "ApStartTime": apStartTime,
    "ApEndTime": apEndTime,
    "ReAllDay": reAllDay,
    "ReTwelveHourBefore": reTwelveHourBefore,
    "ReOneDayBefore": reOneDayBefore,
    "ReTwoDayBefore": reTwoDayBefore,
    "ReOneWeekBefore": reOneWeekBefore,
    "isAppointment": isAppointment,
    "selectedAnimal": selectedAnimal,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
