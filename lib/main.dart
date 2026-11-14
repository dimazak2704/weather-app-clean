import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/city_notifier.dart';
import 'providers/weather_notifier.dart';
import 'screens/home_screen.dart';

/// Точка входу застосунку.
void main() {
  // Початкові одиниці та день можна передати в адресі
  // сторінки, наприклад ?unit=f&day=2 (у веб-версії).
  final params = Uri.base.queryParameters;
  final bool initialCelsius = params['unit'] != 'f';
  final int initialDay =
      int.tryParse(params['day'] ?? '') ?? 0;

  runApp(
    // Провайдери стоять вище за MaterialApp, тому їхній стан
    // доступний на будь-якому екрані застосунку.
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherNotifier(
            isCelsius: initialCelsius,
            selectedDay: initialDay,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CityNotifier(),
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
