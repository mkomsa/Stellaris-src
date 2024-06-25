import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stellaris_app/models/sol_info.dart';
import 'package:stellaris_app/models/weather/weather_data.dart';
import 'package:stellaris_app/screens/weather/weather_details_screen.dart';
import 'package:stellaris_app/widgets/weather/weather_info_grid_item.dart';

class WeatherInfo extends StatefulWidget {
  const WeatherInfo(
      {required this.weatherData, required this.solList, super.key});

  final WeatherData weatherData;
  final List<String> solList;

  void selectWeatherInfo(BuildContext context, WeatherFactor weatherFactor) {
    Navigator.push(
      context,
      PageTransition(
        child: WeatherDetailsScreen(
          weatherFactor: weatherFactor,
          solList: solList,
        ),
        type: PageTransitionType.bottomToTop,
      ),
    );
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (ctx) => WeatherDetailsScreen(
    //       weatherFactor: weatherFactor,
    //       solList: solList,
    //     ),
    //   ),
    // )
  }

  @override
  State<StatefulWidget> createState() {
    return _WeatherInfoState();
  }
}

class _WeatherInfoState extends State<WeatherInfo> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: weatherFactors.length,
      padding: const EdgeInsets.only(left: 6, right: 6),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: MediaQuery.of(context).size.width /
            MediaQuery.of(context).size.height *
            1.15,
      ),
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (index != 0)
              VerticalDivider(
                thickness: 1,
                color: Theme.of(context).colorScheme.primary,
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: WeatherInfoGridItem(
                      onSelectWeatherInfo: () {
                        widget.selectWeatherInfo(
                          context,
                          weatherFactors[index],
                        );
                      },
                      factorInfo: weatherFactors[index],
                      weatherData: widget.weatherData,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
