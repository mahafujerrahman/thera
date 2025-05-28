
class GetAllTravelModel {
  final String? id;
  final String? departure;
  final String? destination;
  final int? distance;
  final int? food;
  final int? gas;
  final int? other;
  final int? totalCost;
  final String? receiptImages;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  GetAllTravelModel({
    this.id,
    this.departure,
    this.destination,
    this.distance,
    this.food,
    this.gas,
    this.other,
    this.totalCost,
    this.receiptImages,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory GetAllTravelModel.fromJson(Map<String, dynamic> json) => GetAllTravelModel(
    id: json["_id"],
    departure: json["departure"],
    destination: json["destination"],
    distance: json["distance"],
    food: json["food"],
    gas: json["gas"],
    other: json["other"],
    totalCost: json["totalCost"],
    receiptImages: json["receipt_images"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "departure": departure,
    "destination": destination,
    "distance": distance,
    "food": food,
    "gas": gas,
    "other": other,
    "totalCost": totalCost,
    "receipt_images": receiptImages,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
