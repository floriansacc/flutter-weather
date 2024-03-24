import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/providers/locations.dart';

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
      appBar: AppBar(title: const Text('Current weather')),
      body: Center(
        child: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            final item = locations[index];

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item.name),
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
      ),
    );
  }
}
