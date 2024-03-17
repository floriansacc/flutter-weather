import 'dart:convert';

import 'package:flutter_weather/models/coordinates.dart';
import 'package:flutter_weather/models/forecast.dart';
import 'package:flutter_weather/services/global_service.dart';

class GeoService extends GlobalService {
  Future<Forecast?> fetchCurrentWeather(Coord coordinates) async {
    final response = await httpRequest(
        HttpMethod.get, ApiVersion.v30, "onecall",
        queryParameters: {
          "lat": coordinates.lat,
          "long": coordinates.long,
        });

    if (response.statusCode != 200) return null;

    final json = jsonDecode(response.body);
    return Forecast.fromJson(json.current);
  }
}
