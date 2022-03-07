part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {}

class WeatherInitial extends WeatherState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class WeatherLoading extends WeatherState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class WeatherLoaded extends WeatherState {
  final List<WeatherDay> weatherDays;
  final WeatherDay selectedDay;

  WeatherLoaded(this.weatherDays, this.selectedDay);

  @override
  List<Object?> get props => [weatherDays];
}

class WeatherFailed extends WeatherState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
