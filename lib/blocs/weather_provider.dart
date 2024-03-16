import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs.dart';

class SoundProvider extends StatelessWidget {
  final Widget? child;
  const SoundProvider({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    final weatherBloc = WeatherBloc();
    return BlocProvider(
      create: (BuildContext context) {
        weatherBloc.add(FetchWeatherEvent());
        return weatherBloc;
      },
      child: child,
    );
  }
}
