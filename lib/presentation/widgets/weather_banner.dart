import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../mappers/condition_icons.dart';
import '../state/city_notifier.dart';
import '../state/weather_notifier.dart';

/// Великий банер з градієнтом: місто, день, температура
/// (у поточних одиницях), іконка. Перша точка, де
/// показано стан WeatherNotifier.
class WeatherBanner extends StatelessWidget {
  const WeatherBanner({super.key});

  @override
  Widget build(BuildContext context) {
    // Підписка: банер перебудується при зміні стану.
    final weather = context.watch<WeatherNotifier>();
    final city = context.watch<CityNotifier>().city;
    final day = weather.day;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF4F8CFF), Color(0xFF7B5CFF)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F8CFF)
                .withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        city,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleLarge
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${weather.displayTemp(day.tempC)}'
                  '${weather.unit}',
                  style: textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${day.day} · ${day.description}',
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            iconFor(day.condition),
            color: Colors.white,
            size: 96,
          ),
        ],
      ),
    );
  }
}
