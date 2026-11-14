import 'weather_condition.dart';

/// Прогноз погоди на одну годину (температура в °C).
class HourForecast {
  final String time;
  final WeatherCondition condition;
  final int tempC;

  const HourForecast(this.time, this.condition, this.tempC);
}
