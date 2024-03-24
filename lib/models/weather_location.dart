import 'package:flutter_weather/models/coordinates.dart';
import 'package:flutter_weather/models/forecast.dart';
import 'package:flutter_weather/models/weather_condition.dart';
import 'package:isar/isar.dart';

part 'weather_location.g.dart';

const currentLocId = -1;

@collection
class WeatherLocation {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  WeatherLocation({
    required this.locId,
    required this.name,
    required this.timezone,
    required this.coord,
    this.conditions,
    this.forecast,
  });

  final int locId;
  final String name;
  final int timezone;
  final Coord coord;
  @ignore
  List<WeatherConditions>? conditions;
  @ignore
  Forecast? forecast;

  bool get isCurrent => locId == currentLocId;

  static WeatherLocation fromJson(Map<String, dynamic> json) {
    return WeatherLocation(
      locId: json['id'],
      name: json['name'],
      timezone: json['timezone'],
      coord: Coord.fromJson(json['coord']),
      conditions: WeatherConditions.fromJsonList(json['weather']),
      forecast: Forecast.fromJson(json['main']),
    );
  }

  static List<WeatherLocation> fromJsonList(List list) =>
      // ignore: unnecessary_lambdas
      List<WeatherLocation>.from(list.map((e) => fromJson(e)));
}
