import '../../domain/entities/day_weather.dart';
import '../../domain/entities/hour_forecast.dart';
import '../../domain/entities/weather_condition.dart';
import '../../domain/repositories/weather_repository.dart';

/// Сховище в пам'яті: прогноз записаний прямо в коді.
class InMemoryWeatherRepository
    implements WeatherRepository {
  @override
  Future<List<DayWeather>> getWeekForecast() async => _week;
}

/// Статичний прогноз на тиждень.
const List<DayWeather> _week = [
  DayWeather(
    day: 'Пн',
    description: 'Мінлива хмарність',
    condition: WeatherCondition.partlyCloudy,
    tempC: 18,
    feelsLikeC: 16,
    humidity: 62,
    windMs: 4,
    pressureMm: 751,
    hourly: [
      HourForecast('09:00', WeatherCondition.sunny, 14),
      HourForecast(
        '12:00',
        WeatherCondition.partlyCloudy,
        17,
      ),
      HourForecast('15:00', WeatherCondition.cloudy, 18),
      HourForecast('18:00', WeatherCondition.drizzle, 15),
      HourForecast('21:00', WeatherCondition.evening, 12),
      HourForecast('00:00', WeatherCondition.night, 10),
    ],
  ),
  DayWeather(
    day: 'Вт',
    description: 'Сонячно',
    condition: WeatherCondition.sunny,
    tempC: 22,
    feelsLikeC: 21,
    humidity: 48,
    windMs: 3,
    pressureMm: 749,
    hourly: [
      HourForecast('09:00', WeatherCondition.sunny, 17),
      HourForecast('12:00', WeatherCondition.sunny, 21),
      HourForecast('15:00', WeatherCondition.sunny, 22),
      HourForecast('18:00', WeatherCondition.twilight, 19),
      HourForecast('21:00', WeatherCondition.evening, 15),
      HourForecast('00:00', WeatherCondition.night, 13),
    ],
  ),
  DayWeather(
    day: 'Ср',
    description: 'Дощ',
    condition: WeatherCondition.rain,
    tempC: 15,
    feelsLikeC: 13,
    humidity: 82,
    windMs: 6,
    pressureMm: 745,
    hourly: [
      HourForecast('09:00', WeatherCondition.drizzle, 12),
      HourForecast('12:00', WeatherCondition.shower, 14),
      HourForecast('15:00', WeatherCondition.drizzle, 15),
      HourForecast(
        '18:00',
        WeatherCondition.thunderstorm,
        13,
      ),
      HourForecast('21:00', WeatherCondition.drizzle, 11),
      HourForecast('00:00', WeatherCondition.night, 9),
    ],
  ),
  DayWeather(
    day: 'Чт',
    description: 'Хмарно',
    condition: WeatherCondition.cloudy,
    tempC: 13,
    feelsLikeC: 11,
    humidity: 74,
    windMs: 5,
    pressureMm: 748,
    hourly: [
      HourForecast('09:00', WeatherCondition.cloudy, 10),
      HourForecast('12:00', WeatherCondition.cloudy, 12),
      HourForecast('15:00', WeatherCondition.cloudy, 13),
      HourForecast('18:00', WeatherCondition.cloudy, 11),
      HourForecast('21:00', WeatherCondition.evening, 9),
      HourForecast('00:00', WeatherCondition.night, 8),
    ],
  ),
  DayWeather(
    day: 'Пт',
    description: 'Мінлива хмарність',
    condition: WeatherCondition.partlyCloudy,
    tempC: 17,
    feelsLikeC: 15,
    humidity: 60,
    windMs: 4,
    pressureMm: 750,
    hourly: [
      HourForecast('09:00', WeatherCondition.sunny, 13),
      HourForecast(
        '12:00',
        WeatherCondition.partlyCloudy,
        16,
      ),
      HourForecast('15:00', WeatherCondition.cloudy, 17),
      HourForecast('18:00', WeatherCondition.twilight, 14),
      HourForecast('21:00', WeatherCondition.evening, 12),
      HourForecast('00:00', WeatherCondition.night, 10),
    ],
  ),
  DayWeather(
    day: 'Сб',
    description: 'Ясно',
    condition: WeatherCondition.sunny,
    tempC: 23,
    feelsLikeC: 23,
    humidity: 45,
    windMs: 2,
    pressureMm: 752,
    hourly: [
      HourForecast('09:00', WeatherCondition.sunny, 18),
      HourForecast('12:00', WeatherCondition.sunny, 22),
      HourForecast('15:00', WeatherCondition.sunny, 23),
      HourForecast('18:00', WeatherCondition.twilight, 20),
      HourForecast('21:00', WeatherCondition.evening, 16),
      HourForecast('00:00', WeatherCondition.night, 14),
    ],
  ),
  DayWeather(
    day: 'Нд',
    description: 'Невеликий дощ',
    condition: WeatherCondition.rain,
    tempC: 19,
    feelsLikeC: 18,
    humidity: 70,
    windMs: 3,
    pressureMm: 747,
    hourly: [
      HourForecast('09:00', WeatherCondition.cloudy, 15),
      HourForecast('12:00', WeatherCondition.drizzle, 18),
      HourForecast('15:00', WeatherCondition.shower, 19),
      HourForecast('18:00', WeatherCondition.drizzle, 16),
      HourForecast('21:00', WeatherCondition.evening, 13),
      HourForecast('00:00', WeatherCondition.night, 11),
    ],
  ),
];
