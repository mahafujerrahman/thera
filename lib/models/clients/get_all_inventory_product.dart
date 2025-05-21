class GetAllInventoryModel {
  final String? id;
  final String? productName;
  final int? pricePerOne;
  final int? buyQuantity;
  final int? currentQuantity;
  final int? totalCost;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  GetAllInventoryModel({
    this.id,
    this.productName,
    this.pricePerOne,
    this.buyQuantity,
    this.currentQuantity,
    this.totalCost,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory GetAllInventoryModel.fromJson(Map<String, dynamic> json) => GetAllInventoryModel(
    id: json["_id"],
    productName: json["productName"],
    pricePerOne: json["pricePerOne"],
    buyQuantity: json["buyQuantity"],
    currentQuantity: json["currentQuantity"],
    totalCost: json["totalCost"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "productName": productName,
    "pricePerOne": pricePerOne,
    "buyQuantity": buyQuantity,
    "currentQuantity": currentQuantity,
    "totalCost": totalCost,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
