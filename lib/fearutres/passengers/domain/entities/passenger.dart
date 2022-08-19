// To parse this JSON data, do
//
//     final passenger = passengerFromJson(jsonString);

import 'dart:convert';

class PassengerResponse {
  PassengerResponse({
    required this.totalPassengers,
    required this.totalPages,
    required this.passengersList,
  });

  final int totalPassengers;
  final int totalPages;
  final List<Passenger> passengersList;
}

class Passenger {
  Passenger({
    required this.id,
    required this.name,
    required this.trips,
  });

  final String id;
  final String name;
  final int trips;
}
