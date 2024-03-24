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
      temp: double.parse(json['temp'].toString()),
      feelsLike: double.parse(json['feels_like'].toString()),
      humidity: int.parse(json['humidity'].toString()),
      tempMin: double.parse(json['temp_min'].toString()),
      tempMax: double.parse(json['temp_max'].toString()),
    );
  }
}
