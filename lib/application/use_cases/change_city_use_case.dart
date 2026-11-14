import '../../domain/repositories/city_repository.dart';

/// Змінює поточне місто. Порожню назву не приймає.
class ChangeCityUseCase {
  final CityRepository _repository;

  const ChangeCityUseCase(this._repository);

  /// Повертає збережену назву або null, якщо вона порожня.
  Future<String?> call(String rawName) async {
    final name = rawName.trim();
    if (name.isEmpty) {
      return null;
    }
    await _repository.saveCity(name);
    return name;
  }
}
