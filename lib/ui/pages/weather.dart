import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/domain/blocs/weather/weather_bloc.dart';
import 'package:weather_app/domain/models/weather_day.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/ui/widgets/weather_card.dart';

class Weather extends StatefulWidget {
  Weather({Key? key}) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  bool isCelsius = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: <Widget>[
          GestureDetector(
            onTap: () => setState(() {
              isCelsius = !isCelsius;
            }),
            child: Container(
              width: 50,
              padding: EdgeInsets.only(right: 20),
              child: Center(
                child: Text(
                  isCelsius ? 'ºC' : 'ºF',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
        if (state is WeatherLoading) {
          return _getLoadingScenario();
        } else if (state is WeatherLoaded) {
          return _getLoadedScenario(
              state.weatherDays, state.selectedDay, isCelsius, context);
        } else {
          return _getErrorScenario(context);
        }
      }),
    );
  }
}

_getLoadingScenario() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

_getErrorScenario(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Center(child: Text('There has been a problem :(')),
      IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () =>
            BlocProvider.of<WeatherBloc>(context).add(WeatherInitialEvent()),
      ),
    ],
  );
}

_getLoadedScenario(List<WeatherDay> weatherDays, WeatherDay selectedDay,
    bool isCelsius, BuildContext context) {
  return RefreshIndicator(
      onRefresh: () async =>
          BlocProvider.of<WeatherBloc>(context).add(WeatherInitialEvent()),
      child: MediaQuery.of(context).orientation == Orientation.portrait
          ? _portraitLayout(weatherDays, selectedDay, isCelsius)
          : _landscapetLayout(weatherDays, selectedDay, isCelsius, context));
}

_portraitLayout(
    List<WeatherDay> weatherDays, WeatherDay selectedDay, bool isCelsius) {
  return ListView(
    children: [
      Container(
        margin: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                DateFormat('EEEE')
                    .format(DateTime.parse(selectedDay.applicableDate!)),
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedDay.weatherStateName!,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Image.network(
                  'https://www.metaweather.com/static/img/weather/png/${selectedDay.weatherStateAbbr}.png',
                  fit: BoxFit.contain,
                  height: 200,
                ),
              ),
            ),
            Center(
                child: Text(
              isCelsius
                  ? selectedDay.theTemp!.round().toString() + 'ºC'
                  : ((selectedDay.theTemp! * 9 / 5).round() + 32).toString() +
                      'ºF',
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            )),
            Text('Humidity: ${selectedDay.humidity}%'),
            SizedBox(height: 10),
            Text('Pressure: ${selectedDay.airPressure!.round()} hPa'),
            SizedBox(height: 10),
            Text('Wind: ${selectedDay.windSpeed!.round()} Km/h'),
            SizedBox(height: 20),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: weatherDays
                  .map((item) => new WeatherDayCard(
                      weatherDays: weatherDays,
                      weatherDay: item,
                      selectedDay: selectedDay,
                      isCelsius: isCelsius))
                  .toList()),
        ),
      )
    ],
  );
}

_landscapetLayout(List<WeatherDay> weatherDays, WeatherDay selectedDay,
    bool isCelsius, BuildContext context) {
  return ListView(
    children: [
      Container(
        margin: EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width / 6,
              child: Image.network(
                'https://www.metaweather.com/static/img/weather/png/${selectedDay.weatherStateAbbr}.png',
                fit: BoxFit.contain,
                height: 130,
              ),
            ),
            SizedBox(width: 20),
            Center(
              child: Text(
                isCelsius
                    ? selectedDay.theTemp!.round().toString() + 'ºC'
                    : ((selectedDay.theTemp! * 9 / 5).round() + 32).toString() +
                        'ºF',
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text('Humidity: ${selectedDay.humidity}%'),
                SizedBox(height: 10),
                Text('Pressure: ${selectedDay.airPressure!.round()} hPa'),
                SizedBox(height: 10),
                Text('Wind: ${selectedDay.windSpeed!.round()} Km/h'),
                SizedBox(height: 10),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Text(
                    DateFormat('EEEE')
                        .format(DateTime.parse(selectedDay.applicableDate!)),
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  selectedDay.weatherStateName!,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(width: 30),
          ],
        ),
      ),
      SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: weatherDays
                  .map((item) => new WeatherDayCard(
                      weatherDays: weatherDays,
                      weatherDay: item,
                      selectedDay: selectedDay,
                      isCelsius: isCelsius))
                  .toList()),
        ),
      )
    ],
  );
}
