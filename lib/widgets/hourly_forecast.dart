import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_notifier.dart';

/// Заголовок прогнозу. Selector бере лише назву дня, тому
/// перемикання °C/°F заголовок не перебудовує.
class ForecastTitle extends StatelessWidget {
  const ForecastTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<WeatherNotifier, String>(
      selector: (_, weather) => weather.day.day,
      builder: (context, dayName, _) {
        return Text(
          'Прогноз на день · $dayName',
          style: Theme.of(context).textTheme.titleLarge,
        );
      },
    );
  }
}

/// Горизонтальний список погодинного прогнозу. Друга точка,
/// де показано той самий стан WeatherNotifier.
class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key});

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherNotifier>();
    final hours = weather.day.hourly;

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hours.length,
        itemBuilder: (context, index) {
          final h = hours[index];
          return _HourCard(
            time: h.time,
            icon: h.icon,
            tempLabel: '${weather.displayTemp(h.tempC)}°',
          );
        },
      ),
    );
  }
}

/// Картка погодинного прогнозу (час + іконка +
/// температура).
class _HourCard extends StatelessWidget {
  final String time;
  final IconData icon;
  final String tempLabel;

  const _HourCard({
    required this.time,
    required this.icon,
    required this.tempLabel,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Icon(icon, color: scheme.primary),
          Text(
            tempLabel,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
