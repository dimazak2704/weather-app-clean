import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/weather_notifier.dart';

/// Кнопка перемикання одиниць. Consumer перебудовує лише її
/// підпис, а незмінна іконка передається через child.
class UnitFab extends StatelessWidget {
  const UnitFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherNotifier>(
      child: const Icon(Icons.swap_horiz),
      builder: (context, weather, icon) {
        return FloatingActionButton.extended(
          onPressed: () =>
              context.read<WeatherNotifier>().toggleUnit(),
          icon: icon,
          label: Text(weather.unit),
        );
      },
    );
  }
}
