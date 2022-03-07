List<WeatherDay> weatherDaysFromJson(List<dynamic> listOfDays) =>
    (listOfDays).map((e) => WeatherDay.fromJson(e)).toList();

class WeatherDay {
  int? id;
  String? weatherStateName;
  String? weatherStateAbbr;
  String? applicableDate;
  double? minTemp;
  double? maxTemp;
  double? theTemp;
  double? windSpeed;
  double? airPressure;
  int? humidity;

  WeatherDay({
    this.id,
    this.weatherStateName,
    this.weatherStateAbbr,
    this.applicableDate,
    this.minTemp,
    this.maxTemp,
    this.theTemp,
    this.windSpeed,
    this.airPressure,
    this.humidity,
  });

  WeatherDay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weatherStateName = json['weather_state_name'];
    weatherStateAbbr = json['weather_state_abbr'];
    applicableDate = json['applicable_date'];
    minTemp = json['min_temp'];
    maxTemp = json['max_temp'];
    theTemp = json['the_temp'];
    windSpeed = json['wind_speed'];
    airPressure = json['air_pressure'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['weather_state_name'] = this.weatherStateName;
    data['weather_state_abbr'] = this.weatherStateAbbr;
    data['applicable_date'] = this.applicableDate;
    data['min_temp'] = this.minTemp;
    data['max_temp'] = this.maxTemp;
    data['the_temp'] = this.theTemp;
    data['wind_speed'] = this.windSpeed;
    data['air_pressure'] = this.airPressure;
    data['humidity'] = this.humidity;
    return data;
  }
}
