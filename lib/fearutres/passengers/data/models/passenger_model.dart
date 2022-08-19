import 'dart:convert';

import 'package:posts_clean_arch/fearutres/passengers/domain/entities/passenger.dart';

PassengerResponseModel passengerFromJson(String str) => PassengerResponseModel.fromJson(json.decode(str));

class PassengerResponseModel extends PassengerResponse {
  PassengerResponseModel(
      {required super.totalPages,
      required super.totalPassengers,
      required super.passengersList});

  factory PassengerResponseModel.fromJson(Map<String, dynamic> json) =>
      PassengerResponseModel(
        totalPassengers: json["totalPassengers"],
        totalPages: json["totalPages"],
        passengersList: List<Passenger>.from(
            json["data"].map((x) => PassengerModel.fromJson(x))),
      );
}

class PassengerModel extends Passenger {

  PassengerModel({required super.id,required super.name,required super.trips});


  factory PassengerModel.fromJson(Map<String, dynamic> json) => PassengerModel(
    id: json["_id"],
    name: json["name"],
    trips: json["trips"],
  );
}