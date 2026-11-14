import 'dart:convert';

import 'package:flutter/services.dart';

import '../../domain/entities/temperature_unit.dart';

/// Налаштування з файлу assets/config/app_settings.json.
class AppSettings {
  static const String defaultPath =
      'assets/config/app_settings.json';

  final String dataSource; // memory або json
  final String forecastAsset; // шлях до JSON-файлу прогнозу
  final TemperatureUnit defaultUnit;
  final String defaultCity;

  const AppSettings({
    required this.dataSource,
    required this.forecastAsset,
    required this.defaultUnit,
    required this.defaultCity,
  });

  static Future<AppSettings> load(
    AssetBundle bundle, {
    String path = defaultPath,
  }) async {
    final text = await bundle.loadString(path);
    return AppSettings.fromJson(
      jsonDecode(text) as Map<String, dynamic>,
    );
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      dataSource: json['dataSource'] as String,
      forecastAsset:
          json['forecastAsset'] as String? ??
          'assets/data/forecast.json',
      defaultUnit: TemperatureUnit.values.byName(
        json['defaultUnit'] as String? ?? 'celsius',
      ),
      defaultCity: json['defaultCity'] as String,
    );
  }
}
