import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:weather_app/api/http_exception.dart';
import 'package:weather_app/model/weather.dart';

class WeatherApiClient {
  static const baseUrl = 'http://api.openweathermap.org';
  final apiKey = dotenv.env['apiKey'].toString();

  final http.Client httpClient = http.Client();

  Uri _buildUri(Map<String, String> queryParameters) {
    var query = {'appid': apiKey, 'units': 'metric', 'lang': 'ru'};
    query = query..addAll(queryParameters);

    var uri = Uri(
      scheme: 'https',
      host: 'api.openweathermap.org',
      path: 'data/2.5/weather',
      queryParameters: query,
    );

    debugPrint('fetching $uri');

    return uri;
  }

  Future<Weather> getWeatherFromLocation(
      {required double latitude, required double longitude}) async {
    final uri = _buildUri({
      'lat': latitude.toString(),
      'lon': longitude.toString(),
    });

    final res = await httpClient.get(uri);

    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }

    final weatherJson = Weather.fromJson(json.decode(res.body));
    return weatherJson;
  }
}
