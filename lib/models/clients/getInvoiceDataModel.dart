class GetInvoiceDataModel {
  String? id;
  String? userID;
  String? invoiceImage;
  String? institutionName;
  String? street;
  String? city;
  String? town;
  String? zipCode;
  String? phone;
  String? emailAddress;
  String? website;
  int? v;

  GetInvoiceDataModel({
    this.id,
    this.userID,
    this.invoiceImage,
    this.institutionName,
    this.street,
    this.city,
    this.town,
    this.zipCode,
    this.phone,
    this.emailAddress,
    this.website,
    this.v,
  });

  factory GetInvoiceDataModel.fromJson(Map<String, dynamic> json) => GetInvoiceDataModel(
    id: json['_id'],
    userID: json['userID'],
    invoiceImage: json['invoiceImage'],
    institutionName: json['institutionName'],
    street: json['street'],
    city: json['city'],
    town: json['town'],
    zipCode: json['zipCode'],
    phone: json['phone'],
    emailAddress: json['emailAddress'],
    website: json['website'],
    v: json['__v'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'userID': userID,
    'invoiceImage': invoiceImage,
    'institutionName': institutionName,
    'street': street,
    'city': city,
    'town': town,
    'zipCode': zipCode,
    'phone': phone,
    'emailAddress': emailAddress,
    'website': website,
    '__v': v,
  };
}