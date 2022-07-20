import 'package:equatable/equatable.dart';

class Geo extends Equatable{
  Geo({
    required this.lat,
    required this.lng,
  });

  final String lat;
  final String lng;

  @override
  // TODO: implement props
  List<Object?> get props => [lat,lng];
}