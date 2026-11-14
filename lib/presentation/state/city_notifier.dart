import 'package:flutter/foundation.dart';

import '../../application/use_cases/change_city_use_case.dart';
import '../../application/use_cases/get_current_city_use_case.dart';

/// Другий незалежний глобальний стан: поточне місто.
class CityNotifier extends ChangeNotifier {
  final GetCurrentCityUseCase _getCurrentCity;
  final ChangeCityUseCase _changeCity;

  String _city = '';

  CityNotifier(this._getCurrentCity, this._changeCity);

  String get city => _city;

  /// Читає місто зі сховища під час запуску.
  Future<void> load() async {
    _city = await _getCurrentCity();
    notifyListeners();
  }

  /// Застосовує нову назву міста (порожню ігнорує).
  Future<void> setCity(String value) async {
    final saved = await _changeCity(value);
    if (saved == null) {
      return;
    }
    _city = saved;
    notifyListeners();
  }
}
