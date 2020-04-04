import 'package:air_vision/util/math/geodetic_position.dart';

class Airport{
  Airport(this.icao, this.iata, this.name, this.city,
      this.country, this.position);

  String icao;
  String iata;
  String name;
  String city;
  String country;
  List position;

    factory Airport.fromJson(dynamic json) {
    return Airport(
      json['icao24'] as String,
      json['iata'] as String,
      json['name'] as String,
      json['city'] as String,
      json['country'] as String,
      json['position'] as List,
    );
  }
}