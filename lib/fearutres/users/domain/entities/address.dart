import 'package:equatable/equatable.dart';
import 'package:posts_clean_arch/fearutres/users/data/models/geo_model.dart';
import 'package:posts_clean_arch/fearutres/users/domain/entities/geo.dart';

class Address extends Equatable{
  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoModel geo;

  @override
  // TODO: implement props
  List<Object?> get props => [
    street,
    suite,
    city,
    zipcode,
    geo
  ];
}