import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/models/weather_location.dart';
import 'package:flutter_weather/providers/locations.dart';
import 'package:flutter_weather/widgets/add_form_popup.dart';
import 'package:intl/intl.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const ProviderScope(child: WeatherApp()));
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

class Root extends ConsumerWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locations = ref.watch(locationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => const AddLocationDialog(),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        itemCount: locations.length,
        itemBuilder: (context, index) {
          final item = locations[index];

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.isCurrent ? 'My Location' : item.name),
              const SizedBox(width: 8),
              Column(
                children: [
                  Text('${item.forecast?.temp} celcius'),
                  const SizedBox(height: 8),
                  Icon(item.conditions?.first.type?.icon),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
    required this.location,
  });

  final WeatherLocation location;

  @override
  Widget build(BuildContext context) {
    final bool isLoaded = location.forecast != null;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: location.conditions?.first.type?.background ??
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
                location.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              Text(
                DateFormat.Hm().format(DateTime.now()),
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
                  '${location.forecast?.temp}°',
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
