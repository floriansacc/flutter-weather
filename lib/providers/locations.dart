import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/models/location.dart';

final locationsProvider =
    StateNotifierProvider<LocationsProvider, List<Location>>(
  (_) => LocationsProvider(),
);

class LocationsProvider extends StateNotifier<List<Location>> {
  LocationsProvider() : super([]);

  void addLocation(Location location) {
    state = [...state, location];
  }

  bool removeLocation(Location location) {
    final tempState = [...state];
    final index = tempState.indexWhere((e) => e.coord == location.coord);
    if (index == -1) return false;
    tempState.removeAt(index);
    state = tempState;
    return true;
  }
}
