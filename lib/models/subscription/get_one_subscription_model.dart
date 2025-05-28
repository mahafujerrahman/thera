class GetOneSubscriptionModel {
  final String? id;
  final String? duration;
  final String? advantage1;
  final String? advantage2;
  final String? advantage3;
  final double? price;
  final int? version;

  GetOneSubscriptionModel({
    this.id,
    this.duration,
    this.advantage1,
    this.advantage2,
    this.advantage3,
    this.price,
    this.version,
  });

  factory GetOneSubscriptionModel.fromJson(Map<String, dynamic> json) {
    return GetOneSubscriptionModel(
      id: json['_id'],
      duration: json['duration'],
      advantage1: json['advantage1'],
      advantage2: json['advantage2'],
      advantage3: json['advantage3'],
      price: json['price']?.toDouble(),
      version: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'duration': duration,
      'advantage1': advantage1,
      'advantage2': advantage2,
      'advantage3': advantage3,
      'price': price,
      '__v': version,
    };
  }
}