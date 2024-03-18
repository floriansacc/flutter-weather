import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather/models/forecast.dart';
import 'package:flutter_weather/models/weather_condition.dart';
import 'package:flutter_weather/services/geo_service.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        title: 'WeatherApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const Root(),
      ),
    );
  }
}

class WeatherProvider extends ChangeNotifier {
  int _test = 0;

  int get test => _test;

  void increment() {
    _test++;
    notifyListeners();
  }
}

class WeatherState extends StatefulWidget {
  const WeatherState({super.key});

  @override
  State<WeatherState> createState() => _WeatherState();
}

class _WeatherState extends State<WeatherState> {
  @override
  Widget build(BuildContext context) {
    return Container();
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
              return Column(
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
        ),
      ),
    );
  }
}
