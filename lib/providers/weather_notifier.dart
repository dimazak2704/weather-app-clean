import 'package:flutter/foundation.dart';

import '../models/day_weather.dart';

/// Глобальний стан погодного застосунку (варіант 6):
/// одиниці температури та вибраний день прогнозу.
///
/// Поля приватні, тож змінити їх можна лише через методи,
/// які сповіщають усіх підписників.
class WeatherNotifier extends ChangeNotifier {
  bool _isCelsius; // true — °C, false — °F
  int _selectedDay; // індекс дня тижня (0..6)

  WeatherNotifier({
    this._isCelsius = true,
    int selectedDay = 0,
  }) : _selectedDay = selectedDay.clamp(
         0,
         weekForecast.length - 1,
       );

  bool get isCelsius => _isCelsius;

  int get selectedDay => _selectedDay;

  /// Дані вибраного дня.
  DayWeather get day => weekForecast[_selectedDay];

  /// Підпис поточних одиниць.
  String get unit => _isCelsius ? '°C' : '°F';

  /// Перемикає одиниці вимірювання °C <-> °F.
  void toggleUnit() {
    _isCelsius = !_isCelsius;
    notifyListeners();
  }

  /// Обирає день прогнозу за індексом.
  void selectDay(int index) {
    final bool outOfRange =
        index < 0 || index >= weekForecast.length;
    if (outOfRange || index == _selectedDay) {
      return;
    }
    _selectedDay = index;
    notifyListeners();
  }

  /// Переводить температуру з Цельсіїв у поточні одиниці.
  int displayTemp(int celsius) {
    return _isCelsius
        ? celsius
        : (celsius * 9 / 5 + 32).round();
  }
}
