import 'package:flutter/foundation.dart';

import '../../application/use_cases/get_week_forecast_use_case.dart';
import '../../domain/entities/day_weather.dart';
import '../../domain/entities/temperature_unit.dart';
import '../../domain/repositories/weather_repository.dart';

/// Стан завантаження прогнозу.
enum ForecastStatus { loading, ready, failed }

/// Глобальний стан екрана: одиниці температури, вибраний день
/// і завантажений прогноз. Дані бере лише через use case.
class WeatherNotifier extends ChangeNotifier {
  final GetWeekForecastUseCase _getWeekForecast;

  TemperatureUnit _unit;
  int _selectedDay = 0; // індекс дня тижня (0..6)
  List<DayWeather> _days = const [];
  ForecastStatus _status = ForecastStatus.loading;

  WeatherNotifier(
    this._getWeekForecast, {
    this._unit = TemperatureUnit.celsius,
  });

  ForecastStatus get status => _status;

  /// Назви днів для перемикача.
  List<String> get dayNames =>
      _days.map((day) => day.day).toList();

  int get selectedDay => _selectedDay;

  /// Дані вибраного дня (лише коли статус ready).
  DayWeather get day => _days[_selectedDay];

  /// Підпис поточних одиниць.
  String get unit => _unit.label;

  /// Завантажує прогноз через use case.
  Future<void> load() async {
    if (_status != ForecastStatus.loading) {
      _status = ForecastStatus.loading;
      notifyListeners();
    }
    try {
      _days = await _getWeekForecast();
      _status = ForecastStatus.ready;
    } on ForecastUnavailableException {
      _status = ForecastStatus.failed;
    }
    notifyListeners();
  }

  /// Перемикає одиниці вимірювання °C <-> °F.
  void toggleUnit() {
    _unit = _unit.toggled;
    notifyListeners();
  }

  /// Обирає день прогнозу за індексом.
  void selectDay(int index) {
    final bool outOfRange =
        index < 0 || index >= _days.length;
    if (outOfRange || index == _selectedDay) {
      return;
    }
    _selectedDay = index;
    notifyListeners();
  }

  /// Переводить температуру з Цельсіїв у поточні одиниці.
  int displayTemp(int celsius) =>
      _unit.fromCelsius(celsius);
}
