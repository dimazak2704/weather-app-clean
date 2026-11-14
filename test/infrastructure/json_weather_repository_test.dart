import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:weather_app/domain/entities/day_weather.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/infrastructure/repositories/in_memory_weather_repository.dart';
import 'package:weather_app/infrastructure/repositories/json_weather_repository.dart';

/// Набір assets із тексту, без реальних файлів застосунку.
class TextBundle extends CachingAssetBundle {
  final String? text;

  TextBundle(this.text);

  @override
  Future<ByteData> load(String key) async {
    if (text == null) {
      throw FlutterError('Unable to load asset: $key');
    }
    final bytes = Uint8List.fromList(text!.codeUnits);
    return ByteData.sublistView(bytes);
  }

  @override
  Future<String> loadString(
    String key, {
    bool cache = true,
  }) async {
    if (text == null) {
      throw FlutterError('Unable to load asset: $key');
    }
    return text!;
  }
}

JsonWeatherRepository repositoryWith(String? text) {
  return JsonWeatherRepository(
    TextBundle(text),
    'data.json',
  );
}

/// Усі поля сутності одним рядком, щоб порівняти два сховища.
String describe(DayWeather d) {
  final hours = d.hourly
      .map(
        (h) => '${h.time}/${h.condition.name}/${h.tempC}',
      )
      .join(',');
  return '${d.day}|${d.description}|${d.condition.name}|'
      '${d.tempC}|${d.feelsLikeC}|${d.humidity}|${d.windMs}|'
      '${d.pressureMm}|$hours';
}

void main() {
  test('справжній forecast.json збігається зі сховищем у пам\'яті', () async {
    final text = File('assets/data/forecast.json')
        .readAsStringSync();

    final fromJson = await repositoryWith(text)
        .getWeekForecast();
    final fromMemory = await InMemoryWeatherRepository()
        .getWeekForecast();

    expect(fromJson, hasLength(7));
    expect(
      fromJson.map(describe).toList(),
      fromMemory.map(describe).toList(),
    );
  });

  test('немає файлу — ForecastUnavailableException', () {
    expect(
      repositoryWith(null).getWeekForecast(),
      throwsA(isA<ForecastUnavailableException>()),
    );
  });

  test(
    'зіпсований JSON — ForecastUnavailableException',
    () {
      expect(
        repositoryWith('{не json').getWeekForecast(),
        throwsA(isA<ForecastUnavailableException>()),
      );
    },
  );

  test(
    'неправильна структура — ForecastUnavailableException',
    () {
      expect(
        repositoryWith('[{"day": 5}]').getWeekForecast(),
        throwsA(isA<ForecastUnavailableException>()),
      );
    },
  );

  test('невідомий стан погоди — ForecastUnavailableException', () {
    const text =
        '[{"day":"Пн","description":"?","condition":"snow",'
        '"tempC":1,"feelsLikeC":1,"humidity":1,"windMs":1,'
        '"pressureMm":1,"hourly":[]}]';

    expect(
      repositoryWith(text).getWeekForecast(),
      throwsA(isA<ForecastUnavailableException>()),
    );
  });
}
