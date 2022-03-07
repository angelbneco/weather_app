part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {}

class WeatherInitialEvent extends WeatherEvent {
  WeatherInitialEvent();

  @override
  List<Object> get props => [];
}

class SelectWeatherDay extends WeatherEvent {
  final List<WeatherDay> weatherDays;
  final WeatherDay selectedDay;
  SelectWeatherDay(this.weatherDays, this.selectedDay);

  @override
  List<Object> get props => [weatherDays, selectedDay];
}
