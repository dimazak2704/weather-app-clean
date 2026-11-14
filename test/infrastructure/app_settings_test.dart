import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:weather_app/domain/entities/temperature_unit.dart';
import 'package:weather_app/infrastructure/config/app_settings.dart';

void main() {
  test('читає справжній файл налаштувань', () {
    final json = jsonDecode(
      File(AppSettings.defaultPath).readAsStringSync(),
    ) as Map<String, dynamic>;

    final settings = AppSettings.fromJson(json);

    expect(settings.dataSource, 'json');
    expect(
      settings.forecastAsset,
      'assets/data/forecast.json',
    );
    expect(settings.defaultUnit, TemperatureUnit.celsius);
    expect(settings.defaultCity, 'Вінниця');
  });

  test(
    'необов\'язкові поля мають значення за замовчуванням',
    () {
      final settings = AppSettings.fromJson({
        'dataSource': 'memory',
        'defaultCity': 'Вінниця',
      });

      expect(
        settings.forecastAsset,
        'assets/data/forecast.json',
      );
      expect(settings.defaultUnit, TemperatureUnit.celsius);
    },
  );

  test('невідома одиниця температури — помилка', () {
    expect(
      () => AppSettings.fromJson({
        'dataSource': 'memory',
        'defaultCity': 'Вінниця',
        'defaultUnit': 'kelvin',
      }),
      throwsArgumentError,
    );
  });
}
