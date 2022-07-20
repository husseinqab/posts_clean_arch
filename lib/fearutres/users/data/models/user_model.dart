import 'dart:convert';

import 'package:posts_clean_arch/fearutres/users/data/models/address_model.dart';
import 'package:posts_clean_arch/fearutres/users/data/models/company_model.dart';

import '../../domain/entities/address.dart';
import '../../domain/entities/company.dart';
import '../../domain/entities/user.dart';

List<UserModel> userFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel extends User {
  UserModel(
      {required super.id,
      required super.name,
      required super.username,
      required super.email,
      required super.address,
      required super.phone,
      required super.website,
      required super.company});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        address: AddressModel.fromJson(json["address"]),
        phone: json["phone"],
        website: json["website"],
        company: CompanyModel.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "address": address.toJson(),
        "phone": phone,
        "website": website,
        "company": company.toJson(),
      };
}
