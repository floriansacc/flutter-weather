import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/main.dart';
import 'package:flutter_weather/test1/models/menu_titles.dart';
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
            const Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 30.0),
              child: Text(
                '미래의 날씨 앱에 오신 것을 환영합니다',
                style: TextStyle(fontSize: 28),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            for (final MenuItems item in appNotifier.menuTitles.items)
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
  final MenuItems menu;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.purple.shade900,
              Colors.blue.shade900,
            ],
            stops: const <double>[0.2, 0.8],
          ),
          border: Border.all(
            color: Colors.white.withOpacity(0.4),
            width: 5,
            strokeAlign: -1,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: InkWell(
          onTap: () => appNotifier.changeIndex(menu.index, menu.title),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    menu.icon,
                    color: theme.colorScheme.primaryContainer,
                    size: 40,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Text(
                  menu.title,
                  style: const TextStyle(fontSize: 28, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
