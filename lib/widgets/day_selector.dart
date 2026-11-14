import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/day_weather.dart';
import '../providers/weather_notifier.dart';

/// Горизонтальний ряд чипів вибору дня (Пн..Нд).
/// Selector стежить лише за selectedDay, тому перемикання
/// °C/°F чипи не перебудовує.
class DaySelector extends StatelessWidget {
  const DaySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<WeatherNotifier, int>(
      selector: (_, weather) => weather.selectedDay,
      builder: (context, selectedDay, _) {
        return SizedBox(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: weekForecast.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(weekForecast[index].day),
                  selected: index == selectedDay,
                  onSelected: (_) => context
                      .read<WeatherNotifier>()
                      .selectDay(index),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
