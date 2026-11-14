import '../../domain/repositories/city_repository.dart';

/// Повертає місто, для якого показуємо прогноз.
class GetCurrentCityUseCase {
  final CityRepository _repository;

  const GetCurrentCityUseCase(this._repository);

  Future<String> call() => _repository.getCity();
}
