import 'package:flutter_test/flutter_test.dart';

import 'package:weather_app/application/use_cases/get_week_forecast_use_case.dart';
import 'package:weather_app/domain/entities/day_weather.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/infrastructure/repositories/in_memory_weather_repository.dart';
import 'package:weather_app/presentation/state/weather_notifier.dart';

/// Сховище, яке спершу не працює, а потім відновлюється.
class FlakyWeatherRepository implements WeatherRepository {
  bool broken = true;

  @override
  Future<List<DayWeather>> getWeekForecast() {
    if (broken) {
      throw const ForecastUnavailableException('тест');
    }
    return InMemoryWeatherRepository().getWeekForecast();
  }
}

WeatherNotifier memoryNotifier() {
  return WeatherNotifier(
    GetWeekForecastUseCase(InMemoryWeatherRepository()),
  );
}

void main() {
  test('load переводить стан у ready', () async {
    final weather = memoryNotifier();
    expect(weather.status, ForecastStatus.loading);

    await weather.load();

    expect(weather.status, ForecastStatus.ready);
    expect(weather.day.day, 'Пн');
  });

  test(
    'помилка сховища дає failed, а повтор відновлює',
    () async {
      final repository = FlakyWeatherRepository();
      final weather = WeatherNotifier(
        GetWeekForecastUseCase(repository),
      );

      await weather.load();
      expect(weather.status, ForecastStatus.failed);

      repository.broken = false;
      await weather.load();
      expect(weather.status, ForecastStatus.ready);
    },
  );

  test(
    'toggleUnit змінює одиниці й сповіщає підписників',
    () {
      final weather = memoryNotifier();
      int notified = 0;
      weather.addListener(() => notified++);

      weather.toggleUnit();

      expect(weather.unit, '°F');
      expect(weather.displayTemp(18), 64);
      expect(notified, 1);
    },
  );

  test('selectDay ігнорує той самий день і межі', () async {
    final weather = memoryNotifier();
    await weather.load();
    int notified = 0;
    weather.addListener(() => notified++);

    weather.selectDay(0);
    weather.selectDay(7);
    weather.selectDay(-1);
    expect(notified, 0);

    weather.selectDay(5);
    expect(weather.selectedDay, 5);
    expect(notified, 1);
  });
}
