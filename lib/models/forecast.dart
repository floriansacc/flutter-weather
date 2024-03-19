import 'package:flutter_weather/models/coordinates.dart';
import 'package:flutter_weather/models/weather_condition.dart';

class Forecast {
  const Forecast({
    // required this.sunrise,
    // required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.tempMin,
    required this.tempMax,
  });

  // final DateTime sunrise;
  // final DateTime sunset;
  final double temp;
  final double feelsLike;
  final int humidity;
  final double tempMin;
  final double tempMax;

  static Forecast fromJson(Map<String, dynamic> json) {
    return Forecast(
      // sunrise: DateTime.fromMicrosecondsSinceEpoch(json["sunrise"]),
      // sunset: DateTime.fromMicrosecondsSinceEpoch(json["sunset"]),
      temp: json['temp'] ?? 0,
      feelsLike: json['feels_like'] ?? 0,
      humidity: json['humidity'] ?? 0,
      tempMin: json['temp_min'] ?? 0,
      tempMax: json['temp_max'] ?? 0,
    );
  }
}

class Weather {
  Weather({
    required this.coord,
    required this.conditions,
    required this.forecast,
  });

  final Coord coord;
  final List<WeatherConditions> conditions;
  final Forecast forecast;

  static Weather fromJson(Map<String, dynamic> json) {
    return Weather(
      forecast: Forecast.fromJson(json['main']),
      conditions: WeatherConditions.fromJsonList(json['weather']),
      coord: Coord.fromJson(json['coord']),
    );
  }
}
