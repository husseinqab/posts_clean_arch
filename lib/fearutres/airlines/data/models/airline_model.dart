import 'dart:convert';

import 'package:posts_clean_arch/fearutres/airlines/domain/entities/airline.dart';

List<AirlineModel> airlineFromJson(String str) => List<AirlineModel>.from(
    json.decode(str).map((x) => AirlineModel.fromJson(x)));

String airlineToJson(List<AirlineModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AirlineModel extends Airline {
  const AirlineModel({
    required String? name,
    required String? country,
    required String? logo,
    required String? slogan,
    required String? headQuaters,
    required String? website,
    required String? established,
  }) : super(
            name: name ?? "y",
            country: country ?? "y",
            logo: logo ?? "y",
            slogan: slogan ?? "y",
            headQuaters: headQuaters ?? "y",
            website: website ?? "y",
            established: established ?? "y");

  factory AirlineModel.fromJson(Map<String, dynamic> json) => AirlineModel(
        name: json["name"],
        country: json["country"],
        logo: json["logo"],
        slogan: json["slogan"],
        headQuaters: json["head_quaters"],
        website: json["website"], 
        established: json["established"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
        "logo": logo,
        "slogan": slogan,
        "head_quaters": headQuaters,
        "website": website,
        "established": established,
      };
}
