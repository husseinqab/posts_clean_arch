// To parse super JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:posts_clean_arch/fearutres/Kyc/domain/entities/user_info_response.dart';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel  extends UserInfoResponse{
  UserInfoModel({
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.nationality,
    required super.dateOfBirth,
    required super.mobile,
    required super.address,
    required super.occupation,
    required super.sourceOfFunds,
    required super.purposeOfAccount,
    required super.selfPepDeclaration,
    required super.placeOfBirth,
    required super.expectedIncomingTxVolumeYearly,
    required super.expectedOutgoingTxVolumeYearly,
    required super.kyc,
    required super.userId,
    required super.createdAt,
    required super.sourceOfFundsOther,
    required super.purposeOfAccountOther,
    required super.twoFactorEnabled,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    nationality: json["nationality"],
    dateOfBirth: DateOfBirth.fromJson(json["dateOfBirth"]),
    mobile: Mobile.fromJson(json["mobile"]),
    address: Address.fromJson(json["address"]),
    occupation: json["occupation"],
    sourceOfFunds: json["sourceOfFunds"],
    purposeOfAccount: json["purposeOfAccount"],
    selfPepDeclaration: json["selfPepDeclaration"],
    placeOfBirth: json["placeOfBirth"],
    expectedIncomingTxVolumeYearly: json["expectedIncomingTxVolumeYearly"],
    expectedOutgoingTxVolumeYearly: json["expectedOutgoingTxVolumeYearly"],
    kyc: Kyc.fromJson(json["kyc"]),
    userId: json["userId"],
    createdAt: json["createdAt"],
    sourceOfFundsOther: json["sourceOfFundsOther"],
    purposeOfAccountOther: json["purposeOfAccountOther"],
    twoFactorEnabled: json["TwoFactorEnabled"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "nationality": nationality,
    "dateOfBirth": dateOfBirth.toJson(),
    "mobile": mobile.toJson(),
    "address": address.toJson(),
    "occupation": occupation,
    "sourceOfFunds": sourceOfFunds,
    "purposeOfAccount": purposeOfAccount,
    "selfPepDeclaration": selfPepDeclaration,
    "placeOfBirth": placeOfBirth,
    "expectedIncomingTxVolumeYearly": expectedIncomingTxVolumeYearly,
    "expectedOutgoingTxVolumeYearly": expectedOutgoingTxVolumeYearly,
    "kyc": kyc.toJson(),
    "userId": userId,
    "createdAt": createdAt,
    "sourceOfFundsOther": sourceOfFundsOther,
    "purposeOfAccountOther": purposeOfAccountOther,
    "TwoFactorEnabled": twoFactorEnabled,
  };
}
