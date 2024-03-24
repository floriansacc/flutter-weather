import 'dart:convert';

import 'package:flutter_weather/models/coordinates.dart';
import 'package:flutter_weather/models/weather_location.dart';
import 'package:flutter_weather/services/geo_locator.dart';
import 'package:flutter_weather/services/global_service.dart';
import 'package:flutter_weather/shared/utils/logger.dart';

class WeatherService extends GlobalService {
  Future<WeatherLocation?> fetchCurrentCoordWeather() async {
    try {
      final coord = await GeoLocator().getCoordinates();
      return fetchCurrentWeatherByCoord(coord);
    } catch (e, s) {
      errorLog(e, s);
      return null;
    }
  }

  Future<WeatherLocation?> fetchCurrentWeatherByName(String name) =>
      _fetchCurrentWeather(name, null);

  Future<WeatherLocation?> fetchCurrentWeatherByCoord(Coord coordinates) =>
      _fetchCurrentWeather(null, coordinates);

  Future<WeatherLocation?> _fetchCurrentWeather([
    String? name,
    Coord? coordinates,
  ]) async {
    final response = await httpRequest(
      HttpMethod.get,
      ApiVersion.v25,
      '/weather',
      queryParameters: {
        if (name != null) ...{'q': name},
        if (coordinates != null) ...{
          'lat': coordinates.lat.toString(),
          'lon': coordinates.long.toString(),
        },
      },
    );

    if (response.statusCode != 200) return null;

    try {
      final json = jsonDecode(response.body);
      return WeatherLocation.fromJson(json);
    } catch (e) {
      errorLog(e);
      return null;
    }
  }

  Future<List<WeatherLocation>?> fetchWeatherList(
    List<WeatherLocation> locations,
  ) async {
    final response = await httpRequest(
      HttpMethod.get,
      ApiVersion.v25,
      '/group',
      queryParameters: {'id': locations.map((e) => e.id).join(',')},
    );

    if (response.statusCode != 200) return null;

    try {
      final list = jsonDecode(response.body);
      if (list == null) return null;
      return WeatherLocation.fromJsonList(list);
    } catch (e) {
      errorLog(e);
      return null;
    }
  }
}
