import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_weather/shared/utils/logger.dart';
import "package:http/http.dart" as http;

enum HttpMethod { get, post }

enum ApiVersion {
  v25(2.5),
  v30(3.0);

  const ApiVersion(this.version);

  final double version;
}

class GlobalService {
  String get apiKey => dotenv.env["WEATHER_API_KEY"]!;
  String get apiUrl => dotenv.env["WEATHER_API_URL"]!;

  Future<http.Response> httpRequest(
    HttpMethod method,
    ApiVersion version,
    String path, {
    Map<String, String>? queryParameters,
  }) async {
    assert(path[0] == "/", 'path require a "/"');

    final Uri requestUrl =
        Uri.parse('$apiUrl${version.version}$path').replace(queryParameters: {
      "appid": apiKey,
      "unit": "metric",
      ...queryParameters ?? {},
    });

    late http.Response response;

    switch (method) {
      case HttpMethod.get:
        response = await http.get(requestUrl);
      case HttpMethod.post:
        response = await http.post(requestUrl);
    }

    /// log request and error message
    if (kDebugMode) {
      String logMessage = 'Response.${method.toString()} << $requestUrl\n'
          'Response.Code:${response.statusCode}\n'
          '---------------------------------------------------';
      if (response.statusCode != 200 &&
          response.statusCode != 201 &&
          response.statusCode != 202) {
        // logMessage += '\nRequest.Body:$encodedBody';
        logMessage += '\nResponse.Body:${response.body}\n'
            '---------------------------------------------------';
      }
      logger.d(logMessage);
    }

    return response;
  }
}
