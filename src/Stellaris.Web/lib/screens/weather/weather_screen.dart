import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:stellaris_app/models/weather/weather_insight.dart';
import 'package:stellaris_app/providers/selected_sol_data_provider.dart';
import 'package:stellaris_app/screens/weather/season_details_screen.dart';
import 'package:stellaris_app/widgets/sol_list.dart';
import 'package:stellaris_app/widgets/weather/season_bar.dart';
import 'package:stellaris_app/widgets/weather/weather_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({required this.weatherInsight, super.key});

  final WeatherInsight weatherInsight;

  void selectSeason(BuildContext context, String season) {
    Navigator.push(
      context,
      PageTransition(
          child: SeasonDetailsScreen(season: season),
          type: PageTransitionType.topToBottom),
    );
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (ctx) => SeasonDetailsScreen(season: season),
    //   ),
    // );
  }

  @override
  ConsumerState<WeatherScreen> createState() {
    return _WeatherScreenState();
  }
}

class _WeatherScreenState extends ConsumerState<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    final weatherDataForSelectedSol = ref.watch(selectedWeatherDataProvider);

    String getBackgroundImagePath() {
      String season = weatherDataForSelectedSol.season;
      String path = 'assets/weather_screen_background_$season.jpg';

      return path;
    }

    return Scaffold(
      body: Stack(
        children: [
          ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.15, 0.55, 0.7, 0.85],
                colors: [
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                  Theme.of(context).colorScheme.onBackground,
                  Theme.of(context).colorScheme.onSecondary.withOpacity(0.9),
                  Theme.of(context)
                      .colorScheme
                      .onSecondaryContainer
                      .withOpacity(0.6),
                ],
              ).createShader(bounds);
            },
            child: Image.asset(
              getBackgroundImagePath(),
              fit: BoxFit.cover,
              height: deviceHeight,
              width: deviceWidth,
            ),
          ),
          Positioned.fill(
            top: kToolbarHeight + deviceHeight * 0.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SolList(solKeys: widget.weatherInsight.solKeys),
                Text(
                  _formatDateTime(weatherDataForSelectedSol.lastUTC),
                  style: currentTheme.textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                SeasonBar(
                  currentSeason: weatherDataForSelectedSol.season,
                  onSelectSeason: ((season) {
                    widget.selectSeason(context, season);
                  }),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  thickness: 1.2,
                ),
                Expanded(
                  child: WeatherInfo(
                    weatherData: weatherDataForSelectedSol,
                    solList: widget.weatherInsight.solKeys,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

String _formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
}
