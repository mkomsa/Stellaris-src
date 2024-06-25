import 'package:stellaris_app/models/weather/weather_metric_info.dart';

class WeatherData {
  final WeatherMetricInfo atmosphericTemperature;
  final WeatherMetricInfo horizontalWindSpeed;
  final WeatherMetricInfo atmosphericPressure;
  final String lastUTC;
  String season;

  WeatherData({
    required this.atmosphericTemperature,
    required this.horizontalWindSpeed,
    required this.atmosphericPressure,
    required this.lastUTC,
    required this.season,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      atmosphericTemperature:
          WeatherMetricInfo.fromJson(json['atmosphericTemperature']),
      horizontalWindSpeed:
          WeatherMetricInfo.fromJson(json['horizontalWindSpeed']),
      atmosphericPressure: WeatherMetricInfo.fromJson(json['pressure']),
      lastUTC: json['lastUTC'],
      season: json['season'],
    );
  }

  static WeatherData empty() {
    return WeatherData(
      atmosphericTemperature: WeatherMetricInfo.empty(),
      horizontalWindSpeed: WeatherMetricInfo.empty(),
      atmosphericPressure: WeatherMetricInfo.empty(),
      lastUTC: '',
      season: '',
    );
  }
}
