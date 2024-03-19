import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_weather/main.dart';
import 'package:flutter_weather/models/menu_titles.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherProvider appNotifier = context.watch<WeatherProvider>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ListView(
          children: [
            const Text(
              '미래의 날씨 앱에 오신 것을 환영합니다',
              style: TextStyle(fontSize: 28),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'test',
                  style: TextStyle(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            for (String item in appNotifier.menuTitles.titles)
              MenuCard(
                appNotifier: appNotifier,
                menu: item,
              ),
          ],
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.appNotifier,
    required this.menu,
  });

  final WeatherProvider appNotifier;
  final String menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: <Color>[
              Colors.green,
              Colors.blue,
            ],
            stops: <double>[0.2, 0.8],
          ),
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: () => appNotifier.changeIndex(1, menu),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              menu,
              style: const TextStyle(fontSize: 28, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
