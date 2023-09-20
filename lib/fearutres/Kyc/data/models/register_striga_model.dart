// To parse this JSON data, do
//
//     final registerStrigaModel = registerStrigaModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/register_striga_response.dart';

RegisterStrigaModel registerStrigaModelFromJson(String str) => RegisterStrigaModel.fromJson(json.decode(str));

String registerStrigaModelToJson(RegisterStrigaModel data) => json.encode(data.toJson());

class RegisterStrigaModel extends RegisterStrigaResponse {

  RegisterStrigaModel({
    required super.userId,
    required super.email,
    required super.kyc,
    required super.emailVerification,
    required super.mobileVerification,
    required super.missingFields,
  });

  factory RegisterStrigaModel.fromJson(Map<String, dynamic> json) => RegisterStrigaModel(
    userId: json["userId"],
    email: json["email"],
    kyc: Kyc.fromJson(json["KYC"]),
    emailVerification: Verification.fromJson(json["emailVerification"]),
    mobileVerification: Verification.fromJson(json["mobileVerification"]),
    missingFields: List<String>.from(json["missingFields"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "email": email,
    "KYC": kyc.toJson(),
    "emailVerification": emailVerification.toJson(),
    "mobileVerification": mobileVerification.toJson(),
    "missingFields": List<dynamic>.from(missingFields.map((x) => x)),
  };
}
