class SubscriptionPlanModel {
  final String id;
  final String duration;
  final String advantage1;
  final String advantage2;
  final String advantage3;
  final double price;
  final bool currentPlan;

  SubscriptionPlanModel({
    required this.id,
    required this.duration,
    required this.advantage1,
    required this.advantage2,
    required this.advantage3,
    required this.price,
    required this.currentPlan,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanModel(
      id: json['_id'],
      duration: json['duration'],
      advantage1: json['advantage1'],
      advantage2: json['advantage2'],
      advantage3: json['advantage3'],
      price: (json['price'] as num).toDouble(),
      currentPlan: json['currentPlan'],
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
      'currentPlan': currentPlan,
    };
  }
}