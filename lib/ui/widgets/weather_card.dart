import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/constants.dart';
import 'package:weather_app/domain/blocs/weather/weather_bloc.dart';
import 'package:weather_app/domain/models/weather_day.dart';
import 'package:intl/intl.dart';

class WeatherDayCard extends StatelessWidget {
  final List<WeatherDay>? weatherDays;
  final WeatherDay? weatherDay;
  final WeatherDay? selectedDay;
  final bool? isCelsius;
  const WeatherDayCard(
      {Key? key,
      this.weatherDays,
      this.weatherDay,
      this.selectedDay,
      this.isCelsius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<WeatherBloc>(context)
            .add(SelectWeatherDay(weatherDays!, weatherDay!));
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        padding: EdgeInsets.all(10),
        width: 110,
        height: 110,
        decoration: BoxDecoration(
            color: whiteBackground,
            border: Border.all(
                width: 2,
                color: weatherDay == selectedDay ? primaryColor : greyColor)),
        child: Column(
          children: [
            Center(
              child: Text(
                DateFormat('E')
                    .format(DateTime.parse(weatherDay!.applicableDate!)),
              ),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: whiteBackground,
              ),
              child: Image.network(
                'https://www.metaweather.com/static/img/weather/png/${weatherDay!.weatherStateAbbr}.png',
                fit: BoxFit.contain,
                height: 30,
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Text(isCelsius!
                  ? '${weatherDay!.minTemp!.round()}º/${weatherDay!.maxTemp!.round()}º'
                  : '${(weatherDay!.minTemp! * 9 / 5).round() + 32}º/${(weatherDay!.maxTemp! * 9 / 5).round() + 32}º'),
            )
          ],
        ),
      ),
    );
  }
}
