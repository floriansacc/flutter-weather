import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather/features/screen/home_screen.dart';
import 'package:flutter_weather/features/screen/location_screen.dart';
import 'package:flutter_weather/models/menu_titles.dart';
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
        home: const WeatherState(),
      ),
    );
  }
}

class WeatherProvider with ChangeNotifier {
  int _selectedIndex = 0;
  String _appBarTitle = 'Home';

  int get selectedIndex => _selectedIndex;
  String get appBarTitle => _appBarTitle;

  final MenuTitles menuTitles = MenuTitles(items: MenuTitles.defaultItems);

  void changeIndex(int index, String title) {
    _selectedIndex = index;
    _appBarTitle = title;
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
    WeatherProvider appNotifier = context.watch<WeatherProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(appNotifier._appBarTitle),
      ),
      drawer: const DrawerMenu(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          switch (appNotifier.selectedIndex) {
            case 0:
              return const HomeScreen();
            case 1:
              return const LocationScreenTest();
            default:
              return const Center(
                child: Text('No screen'),
              );
          }
        },
      ),
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
          for (final MenuItems item in appNotifier.menuTitles.items)
            ListTile(
              leading: Icon(item.icon),
              title: Text(item.title),
              onTap: () {
                appNotifier.changeIndex(item.index, item.title);
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
