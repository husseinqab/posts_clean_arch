import 'dart:convert';

UpdateDataRequest updateDataRequestFromJson(String str) => UpdateDataRequest.fromJson(json.decode(str));

String updateDataRequestToJson(UpdateDataRequest data) => json.encode(data.toJson());

class UpdateDataRequest {
  final String userId;
  final String firstName;
  final String lastName;
  final bool selfPepDeclaration;
  final DateOfBirth dateOfBirth;
  final Address address;
  final String nationality;
  final String occupation;
  final String sourceOfFunds;
  final String sourceOfFundsOther;
  final String purposeOfAccount;
  final String purposeOfAccountOther;
  final String placeOfBirth;
  final String expectedOutgoingTxVolumeYearly;
  final String expectedIncomingTxVolumeYearly;

  UpdateDataRequest({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.selfPepDeclaration,
    required this.dateOfBirth,
    required this.address,
    required this.nationality,
    required this.occupation,
    required this.sourceOfFunds,
    required this.sourceOfFundsOther,
    required this.purposeOfAccount,
    required this.purposeOfAccountOther,
    required this.placeOfBirth,
    required this.expectedOutgoingTxVolumeYearly,
    required this.expectedIncomingTxVolumeYearly,
  });

  factory UpdateDataRequest.fromJson(Map<String, dynamic> json) => UpdateDataRequest(
    userId: json["userId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    selfPepDeclaration: json["selfPepDeclaration"],
    dateOfBirth: DateOfBirth.fromJson(json["dateOfBirth"]),
    address: Address.fromJson(json["address"]),
    nationality: json["nationality"],
    occupation: json["occupation"],
    sourceOfFunds: json["sourceOfFunds"],
    sourceOfFundsOther: json["sourceOfFundsOther"],
    purposeOfAccount: json["purposeOfAccount"],
    purposeOfAccountOther: json["purposeOfAccountOther"],
    placeOfBirth: json["placeOfBirth"],
    expectedOutgoingTxVolumeYearly: json["expectedOutgoingTxVolumeYearly"],
    expectedIncomingTxVolumeYearly: json["expectedIncomingTxVolumeYearly"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "firstName": firstName,
    "lastName": lastName,
    "selfPepDeclaration": selfPepDeclaration,
    "dateOfBirth": dateOfBirth.toJson(),
    "address": address.toJson(),
    "nationality": nationality,
    "occupation": occupation,
    "sourceOfFunds": sourceOfFunds,
    "sourceOfFundsOther": sourceOfFundsOther,
    "purposeOfAccount": purposeOfAccount,
    "purposeOfAccountOther": purposeOfAccountOther,
    "placeOfBirth": placeOfBirth,
    "expectedOutgoingTxVolumeYearly": expectedOutgoingTxVolumeYearly,
    "expectedIncomingTxVolumeYearly": expectedIncomingTxVolumeYearly,
  };
}

class Address {
  final String addressLine1;
  final String city;
  final String country;
  final String postalCode;

  Address({
    required this.addressLine1,
    required this.city,
    required this.country,
    required this.postalCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    addressLine1: json["addressLine1"],
    city: json["city"],
    country: json["country"],
    postalCode: json["postalCode"],
  );

  Map<String, dynamic> toJson() => {
    "addressLine1": addressLine1,
    "city": city,
    "country": country,
    "postalCode": postalCode,
  };
}

class DateOfBirth {
  final int month;
  final int day;
  final int year;

  DateOfBirth({
    required this.month,
    required this.day,
    required this.year,
  });

  factory DateOfBirth.fromJson(Map<String, dynamic> json) => DateOfBirth(
    month: json["month"],
    day: json["day"],
    year: json["year"],
  );

  Map<String, dynamic> toJson() => {
    "month": month,
    "day": day,
    "year": year,
  };
}
