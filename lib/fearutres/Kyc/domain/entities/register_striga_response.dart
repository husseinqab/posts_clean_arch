// To parse this JSON data, do
//
//     final registerStrigaResponse = registerStrigaResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class RegisterStrigaResponse {
  final String userId;
  final String email;
  final Kyc kyc;
  final Verification emailVerification;
  final Verification mobileVerification;
  final List<String> missingFields;

  RegisterStrigaResponse({
    required this.userId,
    required this.email,
    required this.kyc,
    required this.emailVerification,
    required this.mobileVerification,
    required this.missingFields,
  });
}

class Verification {
  final DateTime dateExpires;

  Verification({
    required this.dateExpires,
  });

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
    dateExpires: DateTime.parse(json["dateExpires"]),
  );

  Map<String, dynamic> toJson() => {
    "dateExpires": dateExpires.toIso8601String(),
  };
}

class Kyc {
  final bool emailVerified;
  final bool mobileVerified;
  final String status;

  Kyc({
    required this.emailVerified,
    required this.mobileVerified,
    required this.status,
  });

  factory Kyc.fromJson(Map<String, dynamic> json) => Kyc(
    emailVerified: json["emailVerified"],
    mobileVerified: json["mobileVerified"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "emailVerified": emailVerified,
    "mobileVerified": mobileVerified,
    "status": status,
  };
}
