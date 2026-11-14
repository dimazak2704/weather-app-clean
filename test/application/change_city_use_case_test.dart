import 'package:flutter_test/flutter_test.dart';

import 'package:weather_app/application/use_cases/change_city_use_case.dart';
import 'package:weather_app/application/use_cases/get_current_city_use_case.dart';
import 'package:weather_app/domain/repositories/city_repository.dart';

class FakeCityRepository implements CityRepository {
  String city = 'Вінниця';

  @override
  Future<String> getCity() async => city;

  @override
  Future<void> saveCity(String name) async {
    city = name;
  }
}

void main() {
  test('зберігає назву без зайвих пробілів', () async {
    final repository = FakeCityRepository();

    final saved = await ChangeCityUseCase(repository)(
      '  Львів ',
    );

    expect(saved, 'Львів');
    expect(repository.city, 'Львів');
  });

  test('порожню назву не зберігає', () async {
    final repository = FakeCityRepository();

    final saved = await ChangeCityUseCase(repository)(
      '   ',
    );

    expect(saved, isNull);
    expect(repository.city, 'Вінниця');
  });

  test(
    'GetCurrentCityUseCase читає місто зі сховища',
    () async {
      final city = await GetCurrentCityUseCase(
        FakeCityRepository(),
      )();

      expect(city, 'Вінниця');
    },
  );
}
