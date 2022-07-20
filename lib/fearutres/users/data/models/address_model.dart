import 'package:posts_clean_arch/fearutres/users/data/models/geo_model.dart';
import 'package:posts_clean_arch/fearutres/users/domain/entities/address.dart';

class AddressModel extends Address {
  AddressModel(
      {required super.street,
      required super.suite,
      required super.city,
      required super.zipcode,
      required super.geo});

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
        geo: GeoModel.fromJson(json["geo"]),
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "suite": suite,
        "city": city,
        "zipcode": zipcode,
        "geo": geo.toJson(),
      };
}
