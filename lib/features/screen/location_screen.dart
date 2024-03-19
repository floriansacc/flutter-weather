import 'package:flutter/material.dart';
import 'package:flutter_weather/models/forecast.dart';
import 'package:flutter_weather/services/geo_service.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<Weather?>(
        future: GeoService().fetchCurrentCoordWeather(),
        builder: (BuildContext context, AsyncSnapshot<Weather?> snapshot) {
          final weather = snapshot.data;

          // Future done with no errors
          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError &&
              weather != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${weather.forecast.temp} celcius'),
                const SizedBox(width: 8),
                Icon(weather.conditions.first.type?.icon),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasError) {
            return Text('The error ${snapshot.error} occured');
          }

          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
