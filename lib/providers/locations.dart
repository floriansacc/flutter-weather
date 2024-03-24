// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/models/weather_location.dart';
import 'package:flutter_weather/services/weather_service.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

final locationsProvider =
    StateNotifierProvider<WeatherLocationsProvider, List<WeatherLocation>>(
  (_) => WeatherLocationsProvider(),
);

class WeatherLocationsProvider extends StateNotifier<List<WeatherLocation>> {
  WeatherLocationsProvider() : super([]) {
    _init().then((value) async {
      _setAllWeathers();
      _addCurrentWeatherLocation();
    });
  }

  Isar? _isar;

  Future<void> _init() async {
    final dir = await getApplicationSupportDirectory();
    final isar = await Isar.open([WeatherLocationSchema], directory: dir.path);
    _isar = isar;
    state = await isar.weatherLocations.where().findAll();
  }

  Future<void> _setAllWeathers() async {
    final tempList = [...state];
    final weatherList = await WeatherService().fetchWeatherList(tempList);

    if (weatherList == null) return;

    if (state.isNotEmpty && state.first.isCurrent)
      state = [state.first, ...weatherList];
    else {
      state = [...weatherList];
    }
  }

  Future<void> _addCurrentWeatherLocation() async {
    final isar = _isar;
    if (isar == null) return;

    final currentWeather = await WeatherService().fetchCurrentCoordWeather();

    if (currentWeather == null) return;

    state = [
      WeatherLocation(
        locId: currentLocId,
        name: currentWeather.name,
        timezone: currentWeather.timezone,
        coord: currentWeather.coord,
        conditions: currentWeather.conditions,
        forecast: currentWeather.forecast,
      ),
      ...state,
    ];
  }

  Future<void> addWeatherLocation(WeatherLocation weatherLocation) async {
    final isar = _isar;
    if (isar == null) return;

    await isar.writeTxn(() async {
      await isar.weatherLocations.put(weatherLocation);
    });

    final index = state.length; // future index of inserted WeatherLocation
    state = [...state, weatherLocation];

    // fetch the weather for this new WeatherLocation
    WeatherService()
        .fetchCurrentWeather(weatherLocation.coord)
        .then((weather) async {
      if (weather == null) return;

      // update state and database
      await isar.writeTxn(() async {
        weatherLocation.conditions = weather.conditions;
        weatherLocation.forecast = weather.forecast;
        await isar.weatherLocations.put(weatherLocation);
        final tempState = [...state];
        tempState[index] = weatherLocation;
        state = tempState;
      });
    });
  }

  Future<bool> removeWeatherLocation(WeatherLocation weatherLocation) async {
    // cannot delete current location
    if (weatherLocation.isCurrent) return false;

    final isar = _isar;
    if (isar == null) return false;

    final success = await isar.weatherLocations.delete(weatherLocation.id);
    if (success) {
      final tempState = [...state];
      final index = tempState.indexWhere((e) => e.id == weatherLocation.id);
      if (index == -1) return success;
      tempState.removeAt(index);
      state = tempState;
    }

    return true;
  }
}
