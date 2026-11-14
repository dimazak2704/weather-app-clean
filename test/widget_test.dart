// Тести екрана: один стан оновлює кілька місць дерева.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/main.dart';
import 'package:weather_app/providers/city_notifier.dart';
import 'package:weather_app/providers/weather_notifier.dart';

/// Застосунок з тими самими провайдерами, що й у main().
Widget buildApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => WeatherNotifier(),
      ),
      ChangeNotifierProvider(create: (_) => CityNotifier()),
    ],
    child: const WeatherApp(),
  );
}

void main() {
  testWidgets(
    'Початковий екран показує місто та температуру в °C',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildApp());

      expect(find.text('Вінниця'), findsOneWidget);
      expect(find.text('Погода · Вінниця'), findsOneWidget);
      expect(find.text('18°C'), findsOneWidget);
    },
  );

  testWidgets(
    'FAB оновлює одиниці і в банері, і в прогнозі',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildApp());

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      // Банер: 18 °C = 64 °F; прогноз на 09:00: 14 °C = 57 °F.
      expect(find.text('64°F'), findsOneWidget);
      expect(find.text('57°'), findsOneWidget);
      expect(find.text('°F'), findsOneWidget);
    },
  );

  testWidgets(
    'Вибір дня оновлює банер і заголовок прогнозу',
    (WidgetTester tester) async {
      await tester.pumpWidget(buildApp());

      await tester.tap(find.text('Ср'));
      await tester.pump();

      expect(find.text('15°C'), findsOneWidget);
      expect(find.text('Ср · Дощ'), findsOneWidget);
      expect(
        find.text('Прогноз на день · Ср'),
        findsOneWidget,
      );
    },
  );

  testWidgets('Нове місто видно в AppBar і в банері', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(buildApp());

    await tester.enterText(find.byType(TextField), 'Львів');
    await tester.testTextInput.receiveAction(
      TextInputAction.search,
    );
    await tester.pump();

    expect(find.text('Львів'), findsOneWidget);
    expect(find.text('Погода · Львів'), findsOneWidget);
  });
}
