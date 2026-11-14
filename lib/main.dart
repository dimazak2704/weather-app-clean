import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'application/use_cases/change_city_use_case.dart';
import 'application/use_cases/get_current_city_use_case.dart';
import 'application/use_cases/get_week_forecast_use_case.dart';
import 'domain/repositories/city_repository.dart';
import 'domain/repositories/weather_repository.dart';
import 'infrastructure/config/app_settings.dart';
import 'infrastructure/repositories/in_memory_city_repository.dart';
import 'infrastructure/repositories/in_memory_weather_repository.dart';
import 'infrastructure/repositories/json_weather_repository.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/state/city_notifier.dart';
import 'presentation/state/weather_notifier.dart';

/// Точка входу: тут збираються всі шари застосунку.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settings = await AppSettings.load(rootBundle);

  // Infrastructure: конкретне сховище обирається лише тут.
  final WeatherRepository weatherRepository =
      switch (settings.dataSource) {
        'json' => JsonWeatherRepository(
          rootBundle,
          settings.forecastAsset,
        ),
        'memory' => InMemoryWeatherRepository(),
        final other => throw FormatException(
          'Невідоме сховище: $other',
        ),
      };
  final CityRepository cityRepository =
      InMemoryCityRepository(settings.defaultCity);

  // Application: сховища передаються через конструктор.
  final getWeekForecast = GetWeekForecastUseCase(
    weatherRepository,
  );
  final getCurrentCity = GetCurrentCityUseCase(
    cityRepository,
  );
  final changeCity = ChangeCityUseCase(cityRepository);

  // Presentation: стан працює лише з use cases.
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherNotifier(
            getWeekForecast,
            unit: settings.defaultUnit,
          )..load(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              CityNotifier(getCurrentCity, changeCity)
                ..load(),
        ),
      ],
      child: const WeatherApp(),
    ),
  );
}

/// Кореневий віджет застосунку.
/// Задає тему Material Design 3 через ColorScheme.fromSeed
/// та головний екран.
class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Погода',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F8CFF),
          brightness: Brightness.light,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
