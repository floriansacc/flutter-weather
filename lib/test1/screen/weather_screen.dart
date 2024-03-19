import 'package:flutter/material.dart';
import 'package:flutter_weather/test1/models/forecast.dart';
import 'package:flutter_weather/test1/services/geo_service.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: GeoService().fetchCurrentCoordWeather(),
        builder: (BuildContext context, AsyncSnapshot<Weather?> snapshot) {
          final weather = snapshot.data;

          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError &&
              weather != null) {
            return TemperatureContainer(weather: weather);
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError) {
            return const Text('Error while fetching');
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        },
      ),
    );
  }
}

class TemperatureContainer extends StatelessWidget {
  const TemperatureContainer({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('${weather.forecast.temp}'),
      ],
    );
  }
}
