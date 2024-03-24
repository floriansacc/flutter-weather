import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  LinearGradient get background {
    switch (this) {
      case Icons.thunderstorm ||
            Icons.water_drop ||
            Icons.tsunami ||
            Icons.waves:
        return const LinearGradient(
          colors: [Color(0xFFc5e2f7), Color(0xFF92bad2), Color(0xFF53789e)],
        );
      case Icons.snowing:
        return const LinearGradient(
          colors: [Color(0xFFcce5ec), Color(0xFFfffafa), Color(0xFF93e7fb)],
        );
      case Icons.cloud:
        return const LinearGradient(
          colors: [
            Color(0xFFd8d2cf),
            Color(0xFFd4e6ed),
          ],
        );
      case Icons.sunny:
        return const LinearGradient(
          colors: [Color(0xFFffcc00), Color(0xFFe5d075), Color(0xFFf5e0b0)],
        );
      default:
        return const LinearGradient(
          colors: [Color(0xFFc5e2f7), Color(0xFF92bad2), Color(0xFF53789e)],
        );
    }
  }
}

//
//   "linear-gradient(300deg,#c5e2f7 2%,#92bad2 20%,#53789e 70%)", // rainy
//   "linear-gradient(13deg, #cce5ec, #fffafa 50%, #93e7fb 100%)", // snowy
//   "linear-gradient(45deg, #d8d2cf, #d4e6ed 80%)", // cloudy
//   "linear-gradient(45deg, #d8d2cf, #d4e6ed 60%, #ffcc00 110%)", //partially cloudy
//   "linear-gradient(225deg, #ffcc00, #e5d075 30%, #f5e0b0 70%)", // sunny
//   "linear-gradient(112.1deg, #202639 11.4%, #3f4c77 70.2%)", // night
//

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
