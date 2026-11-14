import 'hour_forecast.dart';
import 'weather_condition.dart';

/// Погода на один день тижня. Усі температури зберігаються
/// в Цельсіях.
class DayWeather {
  /// Правило домену: прогноз завжди складається на тиждень.
  static const int daysInForecast = 7;

  final String day; // скорочена назва дня: Пн, Вт, ...
  final String description; // текстовий опис погоди
  final WeatherCondition condition; // стан погоди
  final int tempC; // денна температура, °C
  final int feelsLikeC; // відчувається як, °C
  final int humidity; // вологість, %
  final int windMs; // швидкість вітру, м/с
  final int pressureMm; // атмосферний тиск, мм рт. ст.
  final List<HourForecast> hourly; // погодинний прогноз

  const DayWeather({
    required this.day,
    required this.description,
    required this.condition,
    required this.tempC,
    required this.feelsLikeC,
    required this.humidity,
    required this.windMs,
    required this.pressureMm,
    required this.hourly,
  });
}
