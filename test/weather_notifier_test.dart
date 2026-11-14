// Тести логіки стану без інтерфейсу.
import 'package:flutter_test/flutter_test.dart';

import 'package:weather_app/providers/city_notifier.dart';
import 'package:weather_app/providers/weather_notifier.dart';

void main() {
  test(
    'toggleUnit змінює одиниці й сповіщає підписників',
    () {
      final weather = WeatherNotifier();
      int notified = 0;
      weather.addListener(() => notified++);

      weather.toggleUnit();

      expect(weather.isCelsius, isFalse);
      expect(weather.unit, '°F');
      expect(notified, 1);
    },
  );

  test('displayTemp перераховує °C у °F з округленням', () {
    final weather = WeatherNotifier(isCelsius: false);

    // 18 °C = 64,4 °F ≈ 64
    expect(weather.displayTemp(18), 64);
    expect(weather.displayTemp(0), 32);
  });

  test(
    'selectDay ігнорує той самий день і межі діапазону',
    () {
      final weather = WeatherNotifier(selectedDay: 2);
      int notified = 0;
      weather.addListener(() => notified++);

      weather.selectDay(2);
      weather.selectDay(7);
      weather.selectDay(-1);
      expect(weather.selectedDay, 2);
      expect(notified, 0);

      weather.selectDay(5);
      expect(weather.selectedDay, 5);
      expect(notified, 1);
    },
  );

  test('день поза межами в конструкторі обмежується', () {
    expect(WeatherNotifier(selectedDay: 99).selectedDay, 6);
  });

  test(
    'setCity обрізає пробіли та ігнорує порожній рядок',
    () {
      final cityState = CityNotifier();
      int notified = 0;
      cityState.addListener(() => notified++);

      cityState.setCity('  Львів ');
      cityState.setCity('   ');

      expect(cityState.city, 'Львів');
      expect(notified, 1);
    },
  );
}
