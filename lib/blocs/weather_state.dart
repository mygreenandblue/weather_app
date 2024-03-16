import '../model/weather_model.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weatherModel;

  WeatherLoaded(this.weatherModel);
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}
