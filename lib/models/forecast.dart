import 'package:flutter_weather/models/coordinates.dart';

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
      temp: json['temp'],
      feelsLike: json['feels_like'],
      humidity: json['humidity'],
      tempMin: json['temp_min'],
      tempMax: json['temp_max'],
    );
  }
}

class WeatherConditions {
  const WeatherConditions({
    required this.main,
    required this.description,
  });

  final String main;
  final String description;

  static WeatherConditions fromJson(Map<String, dynamic> json) {
    return WeatherConditions(
      description: json['description'],
      main: json['main'],
    );
  }

  static List<WeatherConditions> fromJsonList(List list) =>
      // ignore: unnecessary_lambdas
      List<WeatherConditions>.from(list.map((e) => fromJson(e)));
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
