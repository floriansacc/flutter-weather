import 'package:flutter/material.dart';
import 'package:flutter_weather/test1/models/forecast.dart';
import 'package:flutter_weather/test1/services/geo_service.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GeoService().fetchCurrentCoordWeather(),
      builder: (BuildContext context, AsyncSnapshot<Weather?> snapshot) {
        final weather = snapshot.data;

        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text("Error while fetching");
        } else {
          return TemperatureContainer(weather: weather);
        }
      },
    );
  }
}

class TemperatureContainer extends StatelessWidget {
  const TemperatureContainer({super.key, required this.weather});

  final Weather? weather;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
