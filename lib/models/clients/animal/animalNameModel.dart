class GetAnimalNameModel {
  final String id;
  final String name;

  GetAnimalNameModel({
    required this.id,
    required this.name,
  });

  factory GetAnimalNameModel.fromJson(Map<String, dynamic> json) {

    if (json == null) {
      throw FormatException('Null JSON provided to GetAnimalNameModel.fromJson');
    }


    try {
      final id = json['_id']?.toString() ?? '';
      final name = json['name']?.toString() ?? '';

      if (id.isEmpty) {
        throw FormatException('Missing or empty _id field in JSON');
      }

      return GetAnimalNameModel(
        id: id,
        name: name,
      );
    } catch (e) {
      throw FormatException('Failed to parse GetAnimalNameModel: ${e.toString()}');
    }
  }

  // Not using toJson as per requirements, but here's how it would look if needed
  // Map<String, dynamic> toJson() => {
  //       '_id': id,
  //       'name': name,
  //     };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is GetAnimalNameModel &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'GetAnimalNameModel{id: $id, name: $name}';
  }
}

List<GetAnimalNameModel> parseCategories(dynamic json) {
  // Handle null input
  if (json == null) {
    throw FormatException('Null JSON array provided to parseCategories');
  }

  // Check if input is a List
  if (json is! List) {
    throw FormatException('Expected a List but got ${json.runtimeType}');
  }

  try {
    return json.map((item) {
      if (item is! Map<String, dynamic>) {
        throw FormatException('Expected Map<String, dynamic> but got ${item.runtimeType}');
      }
      return GetAnimalNameModel.fromJson(item);
    }).toList();
  } catch (e) {
    throw FormatException('Failed to parse categories: ${e.toString()}');
  }
}