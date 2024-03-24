import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather/models/coordinates.dart';
import 'package:flutter_weather/models/forecast.dart';
import 'package:flutter_weather/services/geo_service.dart';
import 'package:intl/intl.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeatherApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Root(),
    );
  }
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Weather'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            )
          ],
        ),
        body: ListView(
          children: [
            LocationCard(
              location: Location.test,
            ),
            LocationCard(
              location: Location.test,
            ),
            LocationCard(
              location: Location.test,
            ),
            LocationCard(
              location: Location.test,
            ),
            LocationCard(
              location: Location.test,
            ),
            LocationCard(
              location: Location.test,
            ),
            LocationCard(
              location: Location.test,
            ),
          ],
        ));
  }
}

class Location {
  const Location({
    required this.cityName,
    required this.countryName,
    required this.coord,
    this.weather,
    this.localTime,
  });

  final String cityName;
  final String countryName;
  final Coord coord;
  final Weather? weather;
  final DateTime? localTime;

  Location.test2()
      : cityName = 'Seoul',
        countryName = 'South Korea',
        coord = Coord(lat: 0.1, long: 0.1),
        localTime = DateTime.now(),
        weather = null;

  static Location get test => Location(
        cityName: 'Seoul',
        countryName: 'South Korea',
        coord: const Coord(lat: 0.1, long: 0.1),
        localTime: DateTime.now(),
        weather: null,
      );
}

class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
    required this.location,
  });

  final Location location;

  @override
  Widget build(BuildContext context) {
    final bool isLoaded = location.weather != null;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: location.weather?.conditions.first.type?.background ??
            const LinearGradient(colors: [Colors.red, Colors.blue]),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location.cityName,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              Text(
                DateFormat.Hm().format(location.localTime ?? DateTime.now()),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          if (isLoaded)
            Column(
              children: [
                Text(
                  '${location.weather?.forecast.temp}°',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 60,
                    color: Colors.white,
                    shadows: [
                      Shadow(color: Colors.grey.shade600, blurRadius: 10),
                    ],
                  ),
                ),
              ],
            )
          else
            // CircularProgressIndicator(),
            Column(
              children: [
                Text(
                  '20°',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 60,
                    color: Colors.white,
                    shadows: [
                      Shadow(color: Colors.grey.shade600, blurRadius: 10),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      shadows: [
                        Shadow(color: Colors.grey.shade600, blurRadius: 10),
                      ],
                    ),
                    children: const [
                      TextSpan(text: 'min: XX° / '),
                      TextSpan(text: 'max: XX°'),
                    ],
                  ),
                )
              ],
            )
        ],
      ),
    );
  }
}

class WeatherDisplay extends StatelessWidget {
  const WeatherDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Weather?>(
      future: GeoService().fetchCurrentCoordWeather(),
      builder: (BuildContext context, AsyncSnapshot<Weather?> snapshot) {
        final weather = snapshot.data;

        // Future done with no errors
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError &&
            weather != null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${weather.forecast.temp} celcius'),
              const SizedBox(width: 8),
              Icon(weather.conditions.first.type?.icon),
            ],
          );
        }

        // Future with some errors
        else if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasError) {
          return Text('The error ${snapshot.error} occured');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
