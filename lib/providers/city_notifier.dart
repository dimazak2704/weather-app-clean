import 'package:flutter/foundation.dart';

/// Другий незалежний глобальний стан: поточне місто.
/// Винесений окремо, щоб зміна міста не перебудовувала
/// віджети, які залежать лише від одиниць і дня.
class CityNotifier extends ChangeNotifier {
  String _city = 'Вінниця';

  String get city => _city;

  /// Застосовує нову назву міста (порожню ігнорує).
  void setCity(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return;
    }
    _city = trimmed;
    notifyListeners();
  }
}
