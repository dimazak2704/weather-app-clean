import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../domain/entities/day_weather.dart';
import '../../domain/entities/hour_forecast.dart';
import '../../domain/entities/weather_condition.dart';
import '../../domain/repositories/weather_repository.dart';

/// Сховище на JSON-файлі, який лежить в assets застосунку.
class JsonWeatherRepository implements WeatherRepository {
  final AssetBundle _bundle;
  final String _assetPath;

  JsonWeatherRepository(this._bundle, this._assetPath);

  @override
  Future<List<DayWeather>> getWeekForecast() async {
    try {
      final text = await _bundle.loadString(_assetPath);
      final items = jsonDecode(text) as List<dynamic>;
      return items
          .cast<Map<String, dynamic>>()
          .map(_dayFromJson)
          .toList();
    } on FlutterError {
      throw ForecastUnavailableException(
        'немає файлу $_assetPath',
      );
    } on FormatException catch (error) {
      throw ForecastUnavailableException(error.message);
    } on TypeError {
      throw ForecastUnavailableException(
        'неправильна структура $_assetPath',
      );
    }
  }

  DayWeather _dayFromJson(Map<String, dynamic> json) {
    return DayWeather(
      day: json['day'] as String,
      description: json['description'] as String,
      condition: _condition(json['condition'] as String),
      tempC: json['tempC'] as int,
      feelsLikeC: json['feelsLikeC'] as int,
      humidity: json['humidity'] as int,
      windMs: json['windMs'] as int,
      pressureMm: json['pressureMm'] as int,
      hourly: (json['hourly'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map(_hourFromJson)
          .toList(),
    );
  }

  HourForecast _hourFromJson(Map<String, dynamic> json) {
    return HourForecast(
      json['time'] as String,
      _condition(json['condition'] as String),
      json['tempC'] as int,
    );
  }

  WeatherCondition _condition(String name) {
    return WeatherCondition.values.firstWhere(
      (value) => value.name == name,
      orElse: () => throw FormatException(
        'невідомий стан погоди: $name',
      ),
    );
  }
}
