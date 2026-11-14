import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/weather_notifier.dart';

/// Рядок із 4 показників (вологість, вітер, тиск,
/// відчувається як) по Expanded.
class MetricsRow extends StatelessWidget {
  const MetricsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final weather = context.watch<WeatherNotifier>();
    final day = weather.day;
    final metrics = <_Metric>[
      _Metric(
        Icons.water_drop_outlined,
        '${day.humidity}%',
        'Вологість',
      ),
      _Metric(Icons.air, '${day.windMs} м/с', 'Вітер'),
      _Metric(
        Icons.compress,
        '${day.pressureMm}',
        'Тиск, мм',
      ),
      _Metric(
        Icons.thermostat,
        '${weather.displayTemp(day.feelsLikeC)}'
            '${weather.unit}',
        'Відчувається',
      ),
    ];

    return Row(
      children: [
        for (int i = 0; i < metrics.length; i++) ...[
          Expanded(child: _MetricCard(metric: metrics[i])),
          if (i < metrics.length - 1)
            const SizedBox(width: 10),
        ],
      ],
    );
  }
}

/// Проста структура для показника погоди.
class _Metric {
  final IconData icon;
  final String value;
  final String label;

  const _Metric(this.icon, this.value, this.label);
}

/// Картка одного показника погоди (іконка + значення +
/// підпис).
class _MetricCard extends StatelessWidget {
  final _Metric metric;

  const _MetricCard({required this.metric});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(metric.icon, color: scheme.primary),
          const SizedBox(height: 6),
          Text(
            metric.value,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 2),
          Text(
            metric.label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
