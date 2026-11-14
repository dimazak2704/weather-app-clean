/// Інтерфейс сховища поточного міста.
abstract interface class CityRepository {
  Future<String> getCity();

  Future<void> saveCity(String name);
}
