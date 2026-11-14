/// Одиниці температури та бізнес-правило перерахунку.
enum TemperatureUnit {
  celsius('°C'),
  fahrenheit('°F');

  final String label;

  const TemperatureUnit(this.label);

  /// Температури зберігаються в Цельсіях, тому перераховуємо
  /// лише під час відображення.
  int fromCelsius(int celsius) {
    return this == TemperatureUnit.celsius
        ? celsius
        : (celsius * 9 / 5 + 32).round();
  }

  /// Інша одиниця (для перемикача °C/°F).
  TemperatureUnit get toggled =>
      this == TemperatureUnit.celsius
      ? TemperatureUnit.fahrenheit
      : TemperatureUnit.celsius;
}
