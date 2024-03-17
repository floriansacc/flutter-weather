import 'package:flutter/material.dart';

enum WeatherConditionsType {
  thunderstorm(Icons.thunderstorm),
  drizzle(Icons.tsunami),
  rain(Icons.water_drop),
  snow(Icons.snowing),
  atmosphere(Icons.waves),
  clear(Icons.sunny),
  cloud(Icons.cloud);

  const WeatherConditionsType(this.icon);

  final IconData icon;
}

/// https://openweathermap.org/weather-conditions
class WeatherConditions {
  const WeatherConditions({
    required this.type,
    required this.main,
    required this.description,
  });

  final WeatherConditionsType? type;
  final String main;
  final String description;

  static WeatherConditions fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;

    late WeatherConditionsType? type;

    if (id < 300) {
      type = WeatherConditionsType.thunderstorm;
    } else if (id < 500) {
      type = WeatherConditionsType.drizzle;
    } else if (id < 600) {
      type = WeatherConditionsType.snow;
    } else if (id < 700) {
      type = WeatherConditionsType.atmosphere;
    } else if (id == 800) {
      type = WeatherConditionsType.clear;
    } else if (id < 900) {
      type = WeatherConditionsType.cloud;
    }

    return WeatherConditions(
      type: type,
      description: json['description'],
      main: json['main'],
    );
  }

  static List<WeatherConditions> fromJsonList(List list) =>
      // ignore: unnecessary_lambdas
      List<WeatherConditions>.from(list.map((e) => fromJson(e)));
}
