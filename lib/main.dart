import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather/test1/screen/home_screen.dart';
import 'package:flutter_weather/test1/screen/location_screen.dart';
import 'package:flutter_weather/test1/screen/weather_screen.dart';
import 'package:flutter_weather/test1/models/menu_titles.dart';
import 'package:google_fonts/google_fonts.dart';
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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
          useMaterial3: true,
          iconTheme: IconThemeData(color: Colors.purple.shade700),
        ),
        home: const WeatherState(),
      ),
    );
  }
}

class WeatherProvider with ChangeNotifier {
  MenuTitles selectedItem = MenuTitles.home;

  void changeItem(MenuTitles item) {
    selectedItem = item;
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
    final appNotifier = context.watch<WeatherProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(appNotifier.selectedItem.title),
      ),
      drawer: const DrawerMenu(),
      body: switch (appNotifier.selectedItem.index) {
        0 => const HomeScreen(),
        1 => const LocationScreenTest(),
        2 => const WeatherScreen(),
        _ => const Center(child: Text('No screen')),
      },
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherProvider appNotifier = context.watch<WeatherProvider>();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            child: DrawerHeader(
              child: Text('Weather App'),
            ),
          ),
          for (final item in MenuTitles.values)
            ListTile(
              leading: Icon(
                item.icon,
                color: Theme.of(context).iconTheme.color,
              ),
              title: Text(
                item.title,
                style: const TextStyle(fontSize: 16),
              ),
              onTap: () {
                appNotifier.changeItem(item);
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}

// class Test extends StatelessWidget {
//   const Test({
//     super.key,
//     required this.appNotifier,
//   });

//   final WeatherProvider appNotifier;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ListTile(
//           leading: const Icon(Icons.cloud),
//           title: Text(appNotifier.menuTitles.items[0].title),
//           onTap: () {
//             appNotifier.changeIndex(0, appNotifier.menuTitles.items[0].title);
//             Navigator.pop(context);
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.sunny),
//           title: Text(appNotifier.menuTitles.items[1].title),
//           onTap: () {
//             appNotifier.changeIndex(1, appNotifier.menuTitles.items[1].title);
//             Navigator.pop(context);
//           },
//         ),
//       ],
//     );
//   }
// }
