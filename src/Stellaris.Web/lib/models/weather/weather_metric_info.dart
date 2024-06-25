import 'package:stellaris_app/models/weather/weather_data.dart';

class WeatherMetricInfo {
  final double average;
  final double max;
  final double min;
  final int count;

  WeatherMetricInfo({
    required this.average,
    required this.max,
    required this.min,
    required this.count,
  });

  factory WeatherMetricInfo.fromJson(Map<String, dynamic> json) {
    return WeatherMetricInfo(
      average: json['average'],
      count: json['count'],
      min: json['minimum'],
      max: json['maximum'],
    );
  }

  static WeatherMetricInfo empty() {
    return WeatherMetricInfo(
      average: 0.0,
      max: 0.0,
      min: 0.0,
      count: 0,
    );
  }
}

class WeatherMetricInfoUtility {
  static WeatherMetricInfo getWeatherDataForFactor(
      WeatherData weatherData, String factorName) {
    switch (factorName) {
      case 'Pressure':
        return weatherData.atmosphericPressure;
      case 'Temperature':
        return weatherData.atmosphericTemperature;
      case 'Wind':
        return weatherData.horizontalWindSpeed;
      default:
        return weatherData.atmosphericTemperature;
    }
  }
}
