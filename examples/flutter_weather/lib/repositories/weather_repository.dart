import 'dart:async';

import 'package:meta/meta.dart';

import 'package:flutter_web_weather/repositories/weather_api_client.dart';
import 'package:flutter_web_weather/models/models.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  Future<Weather> getWeather(String city) async {
    final int locationId = await weatherApiClient.getLocationId(city);
    return await weatherApiClient.fetchWeather(locationId);
  }
}
