import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/model/error_model.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/repository/weather_repository.dart';

abstract class WeatherEvent {}

class GetWeather extends WeatherEvent {
  final String location;
  GetWeather({required this.location});
}

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherError extends WeatherState {
  final ErrorHandler errorHandler;
  WeatherError(this.errorHandler);
}

class WeatherLoaded extends WeatherState {
  WeatherLoaded(this.weather);
  final WeatherModel weather;
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
    on<GetWeather>(_onWeatherRequested);
  }

  final WeatherRepository weatherRepository;

  void _onWeatherRequested(GetWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.getWeather(event.location);
      if (weather is WeatherModel) {
        emit(WeatherLoaded(weather));
      } else {
        emit(WeatherError(weather));
      }
    } catch (e) {
      emit(WeatherError(ErrorHandler(cod: '404', message: e.toString())));
    }
  }
}
