import 'dart:convert';

RegisterStrigaRequest registerStrigaRequestFromJson(String str) => RegisterStrigaRequest.fromJson(json.decode(str));

String registerStrigaRequestToJson(RegisterStrigaRequest data) => json.encode(data.toJson());

class RegisterStrigaRequest {
  final String firstName;
  final String lastName;
  final String email;
  final Mobile mobile;

  RegisterStrigaRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
  });

  factory RegisterStrigaRequest.fromJson(Map<String, dynamic> json) => RegisterStrigaRequest(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    mobile: Mobile.fromJson(json["mobile"]),
  );

  Map<String, dynamic> toJson() => {
    'isDoubleWallet': false,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "mobile": mobile.toJson(),
  };
}

class Mobile {
  final String countryCode;
  final String number;

  Mobile({
    required this.countryCode,
    required this.number,
  });

  factory Mobile.fromJson(Map<String, dynamic> json) => Mobile(
    countryCode: json["countryCode"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "countryCode": countryCode,
    "number": number,
  };
}
