import 'package:flutter/material.dart';

/// Прогноз погоди на одну годину (температура зберігається
/// у градусах Цельсія).
class HourForecast {
  final String time;
  final IconData icon;
  final int tempC;

  const HourForecast(this.time, this.icon, this.tempC);
}

/// Погода на один день тижня. Усі температури зберігаються
/// в Цельсіях,
/// а перерахунок у Фаренгейти виконується під час
/// відображення.
class DayWeather {
  final String day; // скорочена назва дня: Пн, Вт, ...
  final String condition; // текстовий опис стану погоди
  final IconData icon; // іконка для банера
  final int tempC; // денна температура, °C
  final int feelsLikeC; // відчувається як, °C
  final int humidity; // вологість, %
  final int windMs; // швидкість вітру, м/с
  final int pressureMm; // атмосферний тиск, мм рт. ст.
  final List<HourForecast> hourly; // погодинний прогноз

  const DayWeather({
    required this.day,
    required this.condition,
    required this.icon,
    required this.tempC,
    required this.feelsLikeC,
    required this.humidity,
    required this.windMs,
    required this.pressureMm,
    required this.hourly,
  });
}

/// Статичний прогноз на тиждень (hardcoded) — 7 днів.
const List<DayWeather> weekForecast = [
  DayWeather(
    day: 'Пн',
    condition: 'Мінлива хмарність',
    icon: Icons.wb_cloudy,
    tempC: 18,
    feelsLikeC: 16,
    humidity: 62,
    windMs: 4,
    pressureMm: 751,
    hourly: [
      HourForecast('09:00', Icons.wb_sunny_outlined, 14),
      HourForecast('12:00', Icons.wb_cloudy_outlined, 17),
      HourForecast('15:00', Icons.cloud_outlined, 18),
      HourForecast('18:00', Icons.grain, 15),
      HourForecast('21:00', Icons.nights_stay_outlined, 12),
      HourForecast('00:00', Icons.nightlight_round, 10),
    ],
  ),
  DayWeather(
    day: 'Вт',
    condition: 'Сонячно',
    icon: Icons.wb_sunny,
    tempC: 22,
    feelsLikeC: 21,
    humidity: 48,
    windMs: 3,
    pressureMm: 749,
    hourly: [
      HourForecast('09:00', Icons.wb_sunny_outlined, 17),
      HourForecast('12:00', Icons.wb_sunny, 21),
      HourForecast('15:00', Icons.wb_sunny, 22),
      HourForecast('18:00', Icons.wb_twilight, 19),
      HourForecast('21:00', Icons.nights_stay_outlined, 15),
      HourForecast('00:00', Icons.nightlight_round, 13),
    ],
  ),
  DayWeather(
    day: 'Ср',
    condition: 'Дощ',
    icon: Icons.umbrella,
    tempC: 15,
    feelsLikeC: 13,
    humidity: 82,
    windMs: 6,
    pressureMm: 745,
    hourly: [
      HourForecast('09:00', Icons.grain, 12),
      HourForecast('12:00', Icons.water_drop, 14),
      HourForecast('15:00', Icons.grain, 15),
      HourForecast('18:00', Icons.thunderstorm, 13),
      HourForecast('21:00', Icons.grain, 11),
      HourForecast('00:00', Icons.nightlight_round, 9),
    ],
  ),
  DayWeather(
    day: 'Чт',
    condition: 'Хмарно',
    icon: Icons.cloud,
    tempC: 13,
    feelsLikeC: 11,
    humidity: 74,
    windMs: 5,
    pressureMm: 748,
    hourly: [
      HourForecast('09:00', Icons.cloud_outlined, 10),
      HourForecast('12:00', Icons.cloud, 12),
      HourForecast('15:00', Icons.cloud, 13),
      HourForecast('18:00', Icons.cloud_outlined, 11),
      HourForecast('21:00', Icons.nights_stay_outlined, 9),
      HourForecast('00:00', Icons.nightlight_round, 8),
    ],
  ),
  DayWeather(
    day: 'Пт',
    condition: 'Мінлива хмарність',
    icon: Icons.wb_cloudy,
    tempC: 17,
    feelsLikeC: 15,
    humidity: 60,
    windMs: 4,
    pressureMm: 750,
    hourly: [
      HourForecast('09:00', Icons.wb_sunny_outlined, 13),
      HourForecast('12:00', Icons.wb_cloudy_outlined, 16),
      HourForecast('15:00', Icons.cloud_outlined, 17),
      HourForecast('18:00', Icons.wb_twilight, 14),
      HourForecast('21:00', Icons.nights_stay_outlined, 12),
      HourForecast('00:00', Icons.nightlight_round, 10),
    ],
  ),
  DayWeather(
    day: 'Сб',
    condition: 'Ясно',
    icon: Icons.wb_sunny,
    tempC: 23,
    feelsLikeC: 23,
    humidity: 45,
    windMs: 2,
    pressureMm: 752,
    hourly: [
      HourForecast('09:00', Icons.wb_sunny_outlined, 18),
      HourForecast('12:00', Icons.wb_sunny, 22),
      HourForecast('15:00', Icons.wb_sunny, 23),
      HourForecast('18:00', Icons.wb_twilight, 20),
      HourForecast('21:00', Icons.nights_stay_outlined, 16),
      HourForecast('00:00', Icons.nightlight_round, 14),
    ],
  ),
  DayWeather(
    day: 'Нд',
    condition: 'Невеликий дощ',
    icon: Icons.umbrella,
    tempC: 19,
    feelsLikeC: 18,
    humidity: 70,
    windMs: 3,
    pressureMm: 747,
    hourly: [
      HourForecast('09:00', Icons.cloud_outlined, 15),
      HourForecast('12:00', Icons.grain, 18),
      HourForecast('15:00', Icons.water_drop, 19),
      HourForecast('18:00', Icons.grain, 16),
      HourForecast('21:00', Icons.nights_stay_outlined, 13),
      HourForecast('00:00', Icons.nightlight_round, 11),
    ],
  ),
];
