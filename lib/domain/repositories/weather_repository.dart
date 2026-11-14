import '../entities/day_weather.dart';

/// Прогноз недоступний: сховище не змогло віддати дані або
/// вони неправильні.
class ForecastUnavailableException implements Exception {
  final String reason;

  const ForecastUnavailableException(this.reason);

  @override
  String toString() => 'Прогноз недоступний: $reason';
}

/// Інтерфейс сховища прогнозу. Описаний у домені, а реалізації
/// лежать в Infrastructure, тож внутрішні шари не залежать від
/// способу зберігання.
abstract interface class WeatherRepository {
  /// Повертає прогноз на тиждень або кидає
  /// [ForecastUnavailableException].
  Future<List<DayWeather>> getWeekForecast();
}
