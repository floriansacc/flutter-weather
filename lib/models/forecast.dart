class Forecast {
  const Forecast({
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.weather,
  });

  final DateTime sunrise;
  final DateTime sunset;
  final double temp;
  final double feelsLike;
  final int humidity;
  final List<Weather> weather;

  static Forecast fromJson(Map<String, dynamic> json) {
    return Forecast(
      sunrise: json["sunrise"],
      sunset: json["sunset"],
      temp: json["temp"],
      feelsLike: json["feels_like"],
      humidity: json["humidity"],
      weather: json["weather"].map((item) => Weather.fromJson(item)),
    );
  }
}

class Weather {
  const Weather({
    required this.main,
    required this.description,
  });

  final String main;
  final String description;

  static Weather fromJson(Map<String, dynamic> json) {
    return Weather(
      description: json["description"],
      main: json["main"],
    );
  }
}
