import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:stellaris_app/models/weather/weather_insight.dart';

final weatherInsightProvider = FutureProvider((ref) async {
  WeatherInsight insight = WeatherInsight.empty();

  insight = await getWeatherInsight();

  return insight;
});

Future<WeatherInsight> getWeatherInsight() async {
  // final url = Uri.parse(
  //     'https://mars.nasa.gov/rss/api/?feed=weather&category=insight_temperature&feedtype=json&ver=1.0');

  // final url1 = Uri.parse(
  //     'https://mars.nasa.gov/rss/api/?feed=weather&category=insight_temperature&feedtype=json&ver=1.0');

  // final response1 = await http.get(url1);

  // final Map<String, dynamic> responseBodyJson1 = json.decode(response1.body);

  // final responseAsInsight1 = WeatherInsight.fromJson(responseBodyJson1);

  final url = Uri.parse('https://10.0.2.2:7014/api/weather-insight');

  final response = await http.get(url);

  final Map<String, dynamic> responseBodyJson = json.decode(response.body);

  final responseAsInsight = WeatherInsight.fromJson(responseBodyJson);

  return responseAsInsight;
}
