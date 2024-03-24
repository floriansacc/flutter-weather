import 'package:flutter_weather/models/coordinates.dart';
import 'package:flutter_weather/models/forecast.dart';

class Location {
  const Location({
    required this.cityName,
    required this.countryName,
    required this.coord,
    required this.weather,
  });

  final String cityName;
  final String countryName;
  final Coord coord;
  final Weather weather;
}
