import 'package:flutter/material.dart';

enum MenuTitles {
  home('Home', Icons.home),
  location('Weather Display Test', Icons.location_on_outlined),
  future1('Location Weather', Icons.location_on_outlined),
  test('향후 업데이트', Icons.construction);

  const MenuTitles(this.title, this.icon);

  final String title;
  final IconData icon;
}
