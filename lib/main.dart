import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/blocs/weather/weather_bloc.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/ui/pages/weather.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (context) => WeatherBloc()..add(WeatherInitialEvent()),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather App',
          theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor,
            primaryColor: primaryColor,
            textTheme: Theme.of(context).textTheme.apply(bodyColor: textColor),
          ),
          home: Weather()),
    );
  }
}
