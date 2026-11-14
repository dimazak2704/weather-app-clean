import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/city_notifier.dart';
import '../providers/weather_notifier.dart';
import '../widgets/city_search_field.dart';
import '../widgets/day_selector.dart';
import '../widgets/hourly_forecast.dart';
import '../widgets/metrics_row.dart';
import '../widgets/unit_fab.dart';
import '../widgets/weather_banner.dart';

/// Головний екран погодного застосунку (варіант 6).
/// Став StatelessWidget: стан зберігається в ChangeNotifier,
/// а кожен дочірній віджет сам підписується на те, що йому
/// потрібно. Даних через конструктори вниз не передаємо.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Consumer перебудовує лише заголовок, а не екран.
        title: Consumer<CityNotifier>(
          builder: (_, cityState, _) =>
              Text('Погода · ${cityState.city}'),
        ),
        actions: [
          // Друга точка перемикання одиниць — кнопка в
          // AppBar.
          IconButton(
            onPressed: () => context
                .read<WeatherNotifier>()
                .toggleUnit(),
            icon: const Icon(Icons.thermostat),
            tooltip: 'Перемкнути °C / °F',
          ),
        ],
      ),
      floatingActionButton: const UnitFab(),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CitySearchField(),
            SizedBox(height: 14),
            DaySelector(),
            SizedBox(height: 16),
            WeatherBanner(),
            SizedBox(height: 16),
            MetricsRow(),
            SizedBox(height: 24),
            ForecastTitle(),
            SizedBox(height: 12),
            HourlyForecast(),
          ],
        ),
      ),
    );
  }
}
