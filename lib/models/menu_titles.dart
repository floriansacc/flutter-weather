import 'package:flutter/material.dart';

// enum MenuTitlesIcons {
//   home(Icons.home),
//   location(Icons.location_on_outlined),
//   future1(Icons.construction);

//   const MenuTitlesIcons(this.icon);

//   final IconData icon;
// }

class MenuItems {
  final String title;
  final IconData icon;
  final int index;

  const MenuItems({
    required this.title,
    required this.icon,
    required this.index,
  });
}

class MenuTitles {
  final List<MenuItems> items;

  const MenuTitles({required this.items});

  static final List<MenuItems> defaultItems = [
    const MenuItems(
      title: 'Home',
      icon: Icons.home,
      index: 0,
    ),
    const MenuItems(
      title: 'Location weather',
      icon: Icons.location_on_outlined,
      index: 1,
    ),
    const MenuItems(
      title: '향후 업데이트',
      icon: Icons.construction,
      index: 2,
    ),
  ];

  // final String home = 'Home';
  // final String location = 'Location weather';
  // final String future1 = '향후 업데이트';

  // final MenuTitlesIcons icon;

  // const MenuTitles({required this.icon});

  // Map<String, int> get index {
  //   return {home: 0, location: 1, future1: 2};
  // }

  // List<String> get titles {
  //   return [home, location];
  // }
}
