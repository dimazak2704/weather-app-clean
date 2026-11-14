import 'package:flutter_test/flutter_test.dart';

import 'package:weather_app/application/use_cases/get_week_forecast_use_case.dart';
import 'package:weather_app/domain/entities/day_weather.dart';
import 'package:weather_app/domain/entities/weather_condition.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

/// Підставне сховище: use case працює лише через інтерфейс,
/// тож для тесту не потрібні ні файли, ні Flutter.
class FakeWeatherRepository implements WeatherRepository {
  final int days;

  FakeWeatherRepository(this.days);

  @override
  Future<List<DayWeather>> getWeekForecast() async {
    return List.generate(
      days,
      (index) => DayWeather(
        day: 'День $index',
        description: 'Тест',
        condition: WeatherCondition.sunny,
        tempC: index,
        feelsLikeC: index,
        humidity: 50,
        windMs: 1,
        pressureMm: 750,
        hourly: const [],
      ),
    );
  }
}

void main() {
  test('повертає прогноз на 7 днів зі сховища', () async {
    final useCase = GetWeekForecastUseCase(
      FakeWeatherRepository(7),
    );

    final days = await useCase();

    expect(days, hasLength(7));
    expect(days.first.day, 'День 0');
  });

  test('неповний прогноз вважає помилкою', () {
    final useCase = GetWeekForecastUseCase(
      FakeWeatherRepository(3),
    );

    expect(
      useCase(),
      throwsA(isA<ForecastUnavailableException>()),
    );
  });
}
