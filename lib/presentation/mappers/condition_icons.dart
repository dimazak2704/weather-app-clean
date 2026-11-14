import 'package:flutter/material.dart';

import '../../domain/entities/weather_condition.dart';

/// Показує стан погоди з домену значком Flutter.
IconData iconFor(WeatherCondition condition) {
  return switch (condition) {
    WeatherCondition.sunny => Icons.wb_sunny,
    WeatherCondition.partlyCloudy => Icons.wb_cloudy,
    WeatherCondition.cloudy => Icons.cloud,
    WeatherCondition.rain => Icons.umbrella,
    WeatherCondition.drizzle => Icons.grain,
    WeatherCondition.shower => Icons.water_drop,
    WeatherCondition.thunderstorm => Icons.thunderstorm,
    WeatherCondition.twilight => Icons.wb_twilight,
    WeatherCondition.evening => Icons.nights_stay_outlined,
    WeatherCondition.night => Icons.nightlight_round,
  };
}
