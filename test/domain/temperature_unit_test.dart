import 'package:flutter_test/flutter_test.dart';

import 'package:weather_app/domain/entities/temperature_unit.dart';

void main() {
  test('°C повертається без змін', () {
    expect(TemperatureUnit.celsius.fromCelsius(18), 18);
  });

  test('°F рахується за формулою з округленням', () {
    // 18 °C = 64,4 °F ≈ 64
    expect(TemperatureUnit.fahrenheit.fromCelsius(18), 64);
    expect(TemperatureUnit.fahrenheit.fromCelsius(0), 32);
    expect(
      TemperatureUnit.fahrenheit.fromCelsius(-40),
      -40,
    );
  });

  test('toggled перемикає одиницю туди й назад', () {
    const unit = TemperatureUnit.celsius;

    expect(unit.toggled, TemperatureUnit.fahrenheit);
    expect(unit.toggled.toggled, unit);
  });
}
