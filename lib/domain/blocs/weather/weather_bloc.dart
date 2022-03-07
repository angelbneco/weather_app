import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/models/weather_day.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial());

  WeatherRepository weatherRepository = WeatherRepository();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherInitialEvent) {
      yield WeatherLoading();
      try {
        List<WeatherDay> results = await weatherRepository.getWeatherDays();
        yield WeatherLoaded(results, results[0]);
      } catch (e) {
        yield WeatherFailed();
      }
    }
    if (event is SelectWeatherDay) {
      yield WeatherLoading();
      yield WeatherLoaded(event.weatherDays, event.selectedDay);
    }
  }
}
