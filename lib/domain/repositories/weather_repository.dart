import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/domain/models/weather_day.dart';

class WeatherRepository {
  WeatherRepository() {}

  Future<List<WeatherDay>> getWeatherDays() async {
    try {
      http.Response response = await http
          .get(Uri.parse("https://www.metaweather.com/api/location/44418/"));
      final results = jsonDecode(response.body);
      final output = weatherDaysFromJson(results['consolidated_weather']);
      print('hola');
      return output;
    } catch (e) {
      throw e;
    }
  }
}
