import 'dart:convert';

import 'package:flutter_weather/test1/models/coordinates.dart';
import 'package:flutter_weather/test1/models/forecast.dart';
import 'package:flutter_weather/test1/services/geo_locator.dart';
import 'package:flutter_weather/test1/services/global_service.dart';
import 'package:flutter_weather/test1/shared/utils/logger.dart';

class GeoService extends GlobalService {
  Future<Weather?> fetchCurrentCoordWeather() async {
    try {
      final coord = await GeoLocator().getCoordinates();
      return fetchCurrentWeather(coord);
    } catch (e, s) {
      errorLog(e, s);
      return null;
    }
  }

  Future<Weather?> fetchCurrentWeather(Coord coordinates) async {
    final response = await httpRequest(
      HttpMethod.get,
      ApiVersion.v25,
      '/weather',
      queryParameters: {
        'lat': coordinates.lat.toString(),
        'lon': coordinates.long.toString(),
      },
    );

    if (response.statusCode != 200) return null;

    try {
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } catch (e) {
      errorLog(e);
      return null;
    }
  }
}
