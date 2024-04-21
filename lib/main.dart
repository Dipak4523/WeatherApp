import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/network_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/pages/weather_screen.dart';
import 'package:weather_app/repository/weather_repository.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (context) =>
              WeatherBloc(WeatherRepository()),
        ),
        BlocProvider<NetworkBloc>(
          create: (context) =>
              NetworkBloc()..add(NetworkObserve()),
        ),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WeatherScreen(),
    );
  }
}
