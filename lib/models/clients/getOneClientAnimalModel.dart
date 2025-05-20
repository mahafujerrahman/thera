class GetOneClientAnimalModel {
  final String? name;
  final DateTime? updatedAt;

  GetOneClientAnimalModel({
    this.name,
    this.updatedAt,
  });

  GetOneClientAnimalModel copyWith({
    String? name,
    DateTime? updatedAt,
  }) {
    return GetOneClientAnimalModel(
      name: name ?? this.name,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory GetOneClientAnimalModel.fromJson(Map<String, dynamic> json) {
    return GetOneClientAnimalModel(
      name: json['name'] as String?,
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
