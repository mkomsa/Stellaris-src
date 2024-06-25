import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stellaris_app/models/weather/weather_data.dart';
import 'package:stellaris_app/providers/sol_index_provider.dart';
import 'package:stellaris_app/providers/weather_insight_provider.dart';

final selectedWeatherDataProvider = Provider<WeatherData>((ref) {
  final selectedSolIndex = ref.watch(selectedSolIndexProvider);
  final weatherInsight = ref.watch(weatherInsightProvider);

  if (weatherInsight.asData != null) {
    final selectedSol = weatherInsight.asData!.value.solKeys[selectedSolIndex];
    final solData = weatherInsight.asData!.value.weatherDataMap[selectedSol]!;
    return solData;
  }

  return WeatherData.empty();
});
