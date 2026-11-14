import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/weather_notifier.dart';

/// Горизонтальний ряд чипів вибору дня (Пн..Нд).
/// Selector стежить лише за selectedDay, тому перемикання
/// °C/°F чипи не перебудовує.
class DaySelector extends StatelessWidget {
  const DaySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final dayNames = context
        .select<WeatherNotifier, List<String>>(
          (weather) => weather.dayNames,
        );

    return Selector<WeatherNotifier, int>(
      selector: (_, weather) => weather.selectedDay,
      builder: (context, selectedDay, _) {
        return SizedBox(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dayNames.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(dayNames[index]),
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
