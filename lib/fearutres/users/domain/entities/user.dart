// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'package:equatable/equatable.dart';
import 'package:posts_clean_arch/fearutres/users/data/models/address_model.dart';
import 'package:posts_clean_arch/fearutres/users/data/models/company_model.dart';

class User extends Equatable {
  User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  final int id;
  final String name;
  final String username;
  final String email;
  final AddressModel address;
  final String phone;
  final String website;
  final CompanyModel company;

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, name, username, email, address, phone, website, company];
}
