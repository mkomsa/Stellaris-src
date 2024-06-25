import 'package:flutter/material.dart';
import 'package:stellaris_app/models/sol_info.dart';
import 'package:stellaris_app/models/weather/weather_data.dart';
import 'package:stellaris_app/models/weather/weather_metric_info.dart';
import 'package:stellaris_app/widgets/weather/weather_factor_info.dart';

class WeatherInfoGridItem extends StatefulWidget {
  const WeatherInfoGridItem({
    super.key,
    required this.factorInfo,
    required this.weatherData,
    required this.onSelectWeatherInfo,
  });

  final void Function() onSelectWeatherInfo;
  final WeatherFactor factorInfo;
  final WeatherData weatherData;

  @override
  State<StatefulWidget> createState() {
    return _CategoryGridItemState();
  }
}

class _CategoryGridItemState extends State<WeatherInfoGridItem> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);

    return Card(
      elevation: 12,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(0),
      child: InkWell(
        onTap: () {
          widget.onSelectWeatherInfo();
        },
        splashColor: currentTheme.colorScheme.onSurface,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                Theme.of(context)
                    .colorScheme
                    .secondaryContainer
                    .withOpacity(0.8),
                Theme.of(context)
                    .colorScheme
                    .secondaryContainer
                    .withOpacity(0.6),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.factorInfo.name,
                style: currentTheme.textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer),
                textAlign: TextAlign.center,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.factorInfo.icon,
                    Text(
                      WeatherFactorUtility.getMeasureUnitForFactor(
                          widget.factorInfo.name),
                      style: currentTheme.textTheme.titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: WeatherFactorInfo(
                        WeatherMetricInfoUtility.getWeatherDataForFactor(
                            widget.weatherData, widget.factorInfo.name),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
