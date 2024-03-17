import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather/models/forecast.dart';
import 'package:flutter_weather/services/geo_service.dart';

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
      appBar: AppBar(title: const Text('Current weather')),
      body: Center(
        child: FutureBuilder<Weather?>(
          future: GeoService().fetchCurrentCoordWeather(),
          builder: (BuildContext context, AsyncSnapshot<Weather?> snapshot) {
            final weather = snapshot.data;

            // Future done with no errors
            if (snapshot.connectionState == ConnectionState.done &&
                !snapshot.hasError &&
                weather != null) {
              return Text('${weather.forecast.temp} celcius');
            }

            // Future with some errors
            else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasError) {
              return Text("The error ${snapshot.error} occured");
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
