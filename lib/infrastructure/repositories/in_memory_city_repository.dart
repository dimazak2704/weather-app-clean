import '../../domain/repositories/city_repository.dart';

/// Місто зберігається в пам'яті до закриття застосунку.
class InMemoryCityRepository implements CityRepository {
  String _city;

  InMemoryCityRepository(this._city);

  @override
  Future<String> getCity() async => _city;

  @override
  Future<void> saveCity(String name) async {
    _city = name;
  }
}
