import 'package:flutter_weather/models/coordinates.dart';
import 'package:flutter_weather/models/forecast.dart';
import 'package:isar/isar.dart';

part 'location.g.dart';

@collection
class Location {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  Location({
    required this.cityName,
    required this.countryName,
    required this.coord,
    this.weather,
    this.localTime,
  });

  final String cityName;
  final String countryName;
  final Coord coord;
  @ignore
  final Weather? weather;
  @ignore
  final DateTime? localTime;
}
