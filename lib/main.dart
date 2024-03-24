import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/providers/locations.dart';
import 'package:flutter_weather/widgets/add_form_popup.dart';

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
