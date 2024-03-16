import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/blocs.dart';
import 'package:weather_app/extensions/string_extension.dart';

class WeatherHomeScreen extends StatelessWidget {
  const WeatherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      weatherBloc.add(FetchWeatherEvent());
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade50,
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherLoaded) {
            final currentWeather = state.weatherModel.list?.first;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    state.weatherModel.city!.name.toString(),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    state.weatherModel.list?.first.weather?.first.description ??
                        '',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _weatherIcon(currentWeather?.weather?.first.icon),
                      const SizedBox(width: 10),
                      Text(
                        '${currentWeather?.main!.temp?.toString().toCelsius()} °C',
                        style: const TextStyle(fontSize: 36),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Max: ${currentWeather?.main?.tempMax?.toString().toCelsius()} °C',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Min: ${currentWeather?.main?.tempMin.toString().toCelsius()} °C',
                        style: const TextStyle(
                            fontSize: 16, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  const Text(
                    'Next 7 Days',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        final weather = state.weatherModel.list![index];
                        return ListTile(
                          leading: _weatherIcon(weather.weather?.first.icon),
                          title: Text('Day ${index + 1}'),
                          subtitle: Text(
                              '${weather.main?.temp.toString().toCelsius()}°C'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is WeatherError) {
            return Center(
              child: Text('Failed to load weather data: ${state.message}'),
            );
          } else {
            return const Center(
              child: Text('Unknown state'),
            );
          }
        },
      ),
    );
  }

  Widget _weatherIcon(String? iconCode) {
    if (iconCode == null) return const Icon(Icons.wb_sunny);

    switch (iconCode) {
      case '01d':
        return const Icon(Icons.wb_sunny);
      case '01n':
        return const Icon(Icons.nightlight_round);
      case '02d':
      case '02n':
        return const Icon(Icons.wb_cloudy);
      case '03d':
      case '03n':
      case '04d':
      case '04n':
        return const Icon(Icons.cloud);
      case '09d':
      case '09n':
      case '10d':
      case '10n':
        return const Icon(Icons.grain);
      case '11d':
      case '11n':
        return const Icon(Icons.flash_on);
      case '13d':
      case '13n':
        return const Icon(Icons.ac_unit);
      case '50d':
      case '50n':
        return const Icon(Icons.cloud);
      default:
        return const Icon(Icons.help);
    }
  }
}
