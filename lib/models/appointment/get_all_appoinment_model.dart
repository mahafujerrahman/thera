class GetAllAppointment {
  final String id;
  final ClientId? clientId;
  final DateTime apDate;

  GetAllAppointment({
    required this.id,
    this.clientId,
    required this.apDate,
  });

  // Parse JSON to GetAllAppointment
  factory GetAllAppointment.fromJson(Map<String, dynamic> json) {
    return GetAllAppointment(
      id: json['_id'] as String,
      clientId: json['clientId'] != null
          ? ClientId.fromJson(json['clientId'] as Map<String, dynamic>)
          : null,
      apDate: DateTime.parse(json['ApDate'] as String),
    );
  }

  // Convert GetAllAppointment to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'clientId': clientId?.toJson(),
      'ApDate': apDate.toIso8601String(),
    };
  }
}

class ClientId {
  final String id;
  final String name;

  ClientId({
    required this.id,
    required this.name,
  });

  // Parse JSON to ClientId
  factory ClientId.fromJson(Map<String, dynamic> json) {
    return ClientId(
      id: json['_id'] as String,
      name: json['name'] as String,
    );
  }

  // Convert ClientId to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
    };
  }
}