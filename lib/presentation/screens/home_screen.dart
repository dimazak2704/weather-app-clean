import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/city_notifier.dart';
import '../state/weather_notifier.dart';
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
      // Selector стежить лише за статусом завантаження.
      body: Selector<WeatherNotifier, ForecastStatus>(
        selector: (_, weather) => weather.status,
        builder: (_, status, _) => switch (status) {
          ForecastStatus.loading => const Center(
            child: CircularProgressIndicator(),
          ),
          ForecastStatus.failed => const _LoadError(),
          ForecastStatus.ready => const _ForecastContent(),
        },
      ),
    );
  }
}

/// Вміст екрана, коли прогноз завантажено.
class _ForecastContent extends StatelessWidget {
  const _ForecastContent();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
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
    );
  }
}

/// Повідомлення про помилку з повторною спробою.
class _LoadError extends StatelessWidget {
  const _LoadError();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Не вдалося завантажити прогноз'),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () =>
                context.read<WeatherNotifier>().load(),
            child: const Text('Спробувати ще раз'),
          ),
        ],
      ),
    );
  }
}
