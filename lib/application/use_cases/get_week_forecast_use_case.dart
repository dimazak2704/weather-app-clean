import '../../domain/entities/day_weather.dart';
import '../../domain/repositories/weather_repository.dart';

/// Отримує прогноз на тиждень і перевіряє правило домену:
/// днів має бути рівно 7.
class GetWeekForecastUseCase {
  final WeatherRepository _repository;

  const GetWeekForecastUseCase(this._repository);

  Future<List<DayWeather>> call() async {
    final days = await _repository.getWeekForecast();
    if (days.length != DayWeather.daysInForecast) {
      throw ForecastUnavailableException(
        'очікується ${DayWeather.daysInForecast} днів, '
        'отримано ${days.length}',
      );
    }
    return days;
  }
}
