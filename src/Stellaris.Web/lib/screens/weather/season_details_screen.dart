import 'package:flutter/material.dart';
import 'package:stellaris_app/models/weather/season.dart';

class SeasonDetailsScreen extends StatelessWidget {
  const SeasonDetailsScreen({required this.season, super.key});

  final String season;

  @override
  Widget build(BuildContext context) {
    final Season seasonData = Season(season);
    String getSeasonImage() {
      String path = 'assets/$season.jpg';

      return path;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 70),
            height: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                  Colors.white
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                seasonData.name,
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Image.asset(
            getSeasonImage(),
            fit: BoxFit.fitWidth,
            height: 312,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.primary.withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary.withOpacity(1),
                    Theme.of(context).colorScheme.primary,
                  ],
                  stops: const [0.02, 0.2, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: Text(
                    seasonData.description,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 8,
            width: MediaQuery.of(context).size.width - 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                  Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          const SizedBox(
            height: 36,
          )
        ],
      ),
    );
  }
}
