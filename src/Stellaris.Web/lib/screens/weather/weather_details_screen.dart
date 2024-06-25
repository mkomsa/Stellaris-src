import 'package:flutter/material.dart';
import 'package:stellaris_app/models/sol_info.dart';
import 'package:stellaris_app/models/weather/weather_data.dart';
import 'package:stellaris_app/models/weather/weather_metric_info.dart';
import 'package:stellaris_app/providers/selected_sol_data_provider.dart';
import 'package:stellaris_app/widgets/weather/weather_factor_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stellaris_app/providers/sol_index_provider.dart';

class WeatherDetailsScreen extends ConsumerStatefulWidget {
  const WeatherDetailsScreen(
      {super.key, required this.weatherFactor, required this.solList});

  final WeatherFactor weatherFactor;
  final List<String> solList;

  @override
  ConsumerState<WeatherDetailsScreen> createState() {
    return _WindDetailsScreenState();
  }
}

class _WindDetailsScreenState extends ConsumerState<WeatherDetailsScreen> {
  List<PopupMenuItem<String>> getPopupItems() {
    List<PopupMenuItem<String>> popupItems = [];

    for (var sol in widget.solList) {
      popupItems.add(
        PopupMenuItem<String>(
          value: sol,
          child: Text(
            sol,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onSecondaryContainer),
          ),
        ),
      );
    }

    return popupItems;
  }

  @override
  Widget build(BuildContext context) {
    final WeatherData weatherData = ref.watch(selectedWeatherDataProvider);

    WeatherMetricInfo metricInfo =
        WeatherMetricInfoUtility.getWeatherDataForFactor(
            weatherData, widget.weatherFactor.name);
    WeatherFactorInfo factorInfo = WeatherFactorInfo(metricInfo);

    var weatherMetrics = factorInfo.getMetrics();

    String getFactorIcon() {
      String path = 'assets/${widget.weatherFactor.name.toLowerCase()}.png';

      return path;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'SOL ${widget.solList[ref.watch(selectedSolIndexProvider)]}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          PopupMenuButton<String>(
            iconColor: Theme.of(context).colorScheme.onPrimary,
            onSelected: (value) {
              setState(() {
                ref.read(selectedSolIndexProvider.notifier).setIndex(
                      widget.solList.indexOf(value),
                    );
              });
            },
            itemBuilder: (BuildContext context) {
              return getPopupItems();
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.secondaryContainer,
              Theme.of(context).colorScheme.primaryContainer,
            ],
            stops: const [0.1, 0.62, 0.9],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 128,
            //   width: 120,
            //   child: Icon(
            //     widget.weatherFactor.icon.icon,
            //     size: 128,
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.only(top: kToolbarHeight * 2),
              child: Image.asset(
                getFactorIcon(),
                fit: BoxFit.contain,
                height: 168,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              padding: const EdgeInsets.all(18),
              child: Text(
                widget.weatherFactor.description!,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: weatherMetrics.length,
                itemExtent: 72,
                padding: const EdgeInsets.all(12),
                itemBuilder: (ctx, index) => Card(
                  elevation: 8,
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: InkWell(
                    splashColor: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {},
                    child: Row(
                      children: [
                        const SizedBox(width: 24),
                        Icon(
                          weatherMetrics[index].icon.icon,
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: Text(
                            weatherMetrics[index].value,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                weatherMetrics[index].description,
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
