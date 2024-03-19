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

  final MenuTitles menuTitles = const MenuTitles();

  void changeIndex(int value, String title) {
    _selectedIndex = value;
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
        title: Text('${appNotifier._appBarTitle}'),
      ),
      drawer: const DrawerMenu(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          switch (appNotifier.selectedIndex) {
            case 0:
              return const HomeScreen();
            case 1:
              return const LocationScreen();
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
          ListTile(
            leading: const Icon(Icons.cloud),
            title: Text(appNotifier.menuTitles.home),
            onTap: () {
              appNotifier.changeIndex(1, appNotifier.menuTitles.home);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.sunny),
            title: Text(appNotifier.menuTitles.location),
            onTap: () {
              appNotifier.changeIndex(2, appNotifier.menuTitles.location);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
