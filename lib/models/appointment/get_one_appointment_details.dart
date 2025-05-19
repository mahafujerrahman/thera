class GetOneAppoinmentDetailsModel {
  final String? id;
  final ClientId? clientId;
  final String? userId;
  final List<String>? areaOfConcern;
  final List<String>? treatments;
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
    return GetOneAppoinmentDetailsModel(
      id: json['_id'] as String?,
      clientId: json['clientId'] != null ? ClientId.fromJson(json['clientId']) : null,
      userId: json['userId'] as String?,
      areaOfConcern: (json['areaOfConcern'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      treatments: (json['treatments'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      inventoryAcc: json['inventoryAcc'] as List<dynamic>?,
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
      points: (json['points'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      concernImages: (json['concernImages'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      apDate: json['apDate'] != null ? DateTime.parse(json['apDate']) : null,
      apStartTime: json['apStartTime'] as String?,
      apEndTime: json['apEndTime'] as String?,
      reAllDay: json['reAllDay'] as bool?,
      reTwelveHourBefore: json['reTwelveHourBefore'] as bool?,
      reOneDayBefore: json['reOneDayBefore'] as bool?,
      reTwoDayBefore: json['reTwoDayBefore'] as bool?,
      reOneWeekBefore: json['reOneWeekBefore'] as bool?,
      isAppointment: json['isAppointment'] as bool?,
      selectedAnimal: json['selectedAnimal'] as String?,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      v: json['__v'] as int?,
    );
  }
}

class ClientId {
  final String? id;
  final String? userId;
  final String? name;
  final String? city;
  final String? state;
  final String? zip;
  final String? phoneNumber;
  final String? email;
  final String? other;
  final int? v;
  final bool? humanClient;

  ClientId({
    this.id,
    this.userId,
    this.name,
    this.city,
    this.state,
    this.zip,
    this.phoneNumber,
    this.email,
    this.other,
    this.v,
    this.humanClient,
  });

  factory ClientId.fromJson(Map<String, dynamic> json) {
    return ClientId(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zip: json['zip'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      other: json['other'] as String?,
      v: json['__v'] as int?,
      humanClient: json['humanClient'] as bool?,
    );
  }
}
