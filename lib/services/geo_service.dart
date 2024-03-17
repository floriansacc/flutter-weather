import 'dart:convert';

import 'package:flutter_weather/models/coordinates.dart';
import 'package:flutter_weather/models/forecast.dart';
import 'package:flutter_weather/services/geo_locator.dart';
import 'package:flutter_weather/services/global_service.dart';
import 'package:flutter_weather/shared/utils/logger.dart';

class GeoService extends GlobalService {
  Future<Forecast?> fetchCurrentCoordWeather() async {
    try {
      final coord = await GeoLocator().getCoordinates();
      return fetchCurrentWeather(coord);
    } catch (e, s) {
      errorLog(e, s);
      return null;
    }
  }

  Future<Forecast?> fetchCurrentWeather(Coord coordinates) async {
    final response = await httpRequest(
        HttpMethod.get, ApiVersion.v30, "/onecall",
        queryParameters: {
          "lat": coordinates.lat.toString(),
          "long": coordinates.long.toString(),
        });

    if (response.statusCode != 200) return null;

    try {
      final json = jsonDecode(response.body);
      return Forecast.fromJson(json.current);
    } catch (e) {
      errorLog(e);
      return null;
    }
  }
}
