import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/models/location.dart';
import 'package:flutter_weather/services/weather_service.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

final locationsProvider =
    StateNotifierProvider<LocationsProvider, List<Location>>(
  (_) => LocationsProvider(),
);

class LocationsProvider extends StateNotifier<List<Location>> {
  LocationsProvider() : super([]) {
    _init().then((value) async {
      _addCurrentLocation();
      _setAllWeathers();
    });
  }

  Isar? _isar;

  Future<void> _init() async {
    final dir = await getApplicationSupportDirectory();
    final isar = await Isar.open([LocationSchema], directory: dir.path);
    _isar = isar;
    state = await isar.locations.where().findAll();
  }

  Future<void> _setAllWeathers() async {
    // TODO: request WeatherService().fetchCurrentWeather for each location
    //       or find an endpoint that supports multiple coordinates
  }

  Future<void> _addCurrentLocation() async {
    final isar = _isar;
    if (isar == null) return;

    final currentWeather = await WeatherService().fetchCurrentCoordWeather();

    if (currentWeather == null) return;

    state = [
      Location(
        cityName: 'Current Location',
        countryName: 'Current Location',
        coord: currentWeather.coord,
        weather: currentWeather,
      ),
      ...state,
    ];
  }

  Future<void> addLocation(Location location) async {
    final isar = _isar;
    if (isar == null) return;

    await isar.writeTxn(() async {
      await isar.locations.put(location);
    });

    final index = state.length; // future index of inserted location
    state = [...state, location];

    // fetch the weather for this new location
    WeatherService().fetchCurrentWeather(location.coord).then((weather) async {
      if (weather == null) return;

      // update state and database
      await isar.writeTxn(() async {
        location.weather = weather;
        await isar.locations.put(location);
        final tempState = [...state];
        tempState[index] = location;
        state = tempState;
      });
    });
  }

  Future<bool> removeLocation(int index, Location location) async {
    final isar = _isar;
    if (isar == null) return false;

    final success = await isar.locations.delete(location.id);
    if (success) {
      final tempState = [...state];
      final index = tempState.indexWhere((e) => e.id == location.id);
      if (index == -1) return success;
      tempState.removeAt(index);
      state = tempState;
    }

    return true;
  }
}
