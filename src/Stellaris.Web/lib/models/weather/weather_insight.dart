import 'package:stellaris_app/models/weather/weather_data.dart';

class WeatherInsight {
  final List<String> solKeys;
  final Map<String, WeatherData> weatherDataMap;

  WeatherInsight({
    required this.solKeys,
    required this.weatherDataMap,
  });

  WeatherInsight.empty()
      : solKeys = [],
        weatherDataMap = {};

  factory WeatherInsight.fromJson(Map<String, dynamic> json) {
    List<String> solKeys = List<String>.from(json['solKeys']);
    Map<String, WeatherData> weatherDataMap = {};

    json['solData'].forEach((key, value) {
      weatherDataMap[key] = WeatherData.fromJson(value);
    });

    return WeatherInsight(
      solKeys: solKeys,
      weatherDataMap: weatherDataMap,
    );
  }
}
