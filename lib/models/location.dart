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

  String cityName;
  String countryName;
  Coord coord;
  @ignore
  Weather? weather;
  @ignore
  DateTime? localTime;
}
