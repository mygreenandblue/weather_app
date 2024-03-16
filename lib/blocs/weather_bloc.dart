import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/utils/api_key.dart';

import '../model/weather_model.dart';
import 'blocs.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeatherEvent>(_fetchWeather);
  }

  final apiKey = ApiKey().apiKey;
  final location = 'Hanoi';

  void _fetchWeather(
      FetchWeatherEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherInitial());
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=$apiKey'));

      if (response.statusCode == 200) {
        final weatherData = WeatherModel.fromJson(json.decode(response.body));
        emit(WeatherLoaded(weatherData));
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      emit(WeatherError('Failed to fetch weather data: $e'));
    }
  }
}
