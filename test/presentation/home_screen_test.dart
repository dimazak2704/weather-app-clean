import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/application/use_cases/change_city_use_case.dart';
import 'package:weather_app/application/use_cases/get_current_city_use_case.dart';
import 'package:weather_app/application/use_cases/get_week_forecast_use_case.dart';
import 'package:weather_app/domain/entities/day_weather.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';
import 'package:weather_app/infrastructure/repositories/in_memory_city_repository.dart';
import 'package:weather_app/infrastructure/repositories/in_memory_weather_repository.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/presentation/state/city_notifier.dart';
import 'package:weather_app/presentation/state/weather_notifier.dart';

class BrokenWeatherRepository implements WeatherRepository {
  @override
  Future<List<DayWeather>> getWeekForecast() {
    throw const ForecastUnavailableException('тест');
  }
}

/// Застосунок, зібраний так само, як у main().
Widget buildApp(WeatherRepository repository) {
  final city = InMemoryCityRepository('Вінниця');
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => WeatherNotifier(
          GetWeekForecastUseCase(repository),
        )..load(),
      ),
      ChangeNotifierProvider(
        create: (_) => CityNotifier(
          GetCurrentCityUseCase(city),
          ChangeCityUseCase(city),
        )..load(),
      ),
    ],
    child: const WeatherApp(),
  );
}

void main() {
  testWidgets('Прогноз зі сховища показано на екрані', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildApp(InMemoryWeatherRepository()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Вінниця'), findsOneWidget);
    expect(find.text('Погода · Вінниця'), findsOneWidget);
    expect(find.text('18°C'), findsOneWidget);
  });

  testWidgets('FAB оновлює і банер, і прогноз', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildApp(InMemoryWeatherRepository()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();

    expect(find.text('64°F'), findsOneWidget);
    expect(find.text('57°'), findsOneWidget);
  });

  testWidgets('Вибір дня оновлює банер і заголовок', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildApp(InMemoryWeatherRepository()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ср'));
    await tester.pumpAndSettle();

    expect(find.text('15°C'), findsOneWidget);
    expect(find.text('Ср · Дощ'), findsOneWidget);
    expect(
      find.text('Прогноз на день · Ср'),
      findsOneWidget,
    );
  });

  testWidgets('Нове місто видно в AppBar і в банері', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildApp(InMemoryWeatherRepository()),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Львів');
    await tester.testTextInput.receiveAction(
      TextInputAction.search,
    );
    await tester.pumpAndSettle();

    expect(find.text('Львів'), findsOneWidget);
    expect(find.text('Погода · Львів'), findsOneWidget);
  });

  testWidgets('Помилка сховища показує повідомлення', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      buildApp(BrokenWeatherRepository()),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Не вдалося завантажити прогноз'),
      findsOneWidget,
    );
    expect(find.text('Спробувати ще раз'), findsOneWidget);
  });
}
