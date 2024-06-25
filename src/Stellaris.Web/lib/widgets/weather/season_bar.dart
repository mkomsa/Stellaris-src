import 'package:flutter/material.dart';

class SeasonBar extends StatelessWidget {
  const SeasonBar(
      {required this.currentSeason, required this.onSelectSeason, super.key});

  final String currentSeason;
  final void Function(String season) onSelectSeason;

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);

    return InkWell(
      onTap: () {
        onSelectSeason(currentSeason);
      },
      splashColor: currentTheme.colorScheme.onTertiaryContainer,
      child: Container(
        width: double.infinity,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
          border: Border(
            top: BorderSide(
              width: 5,
              style: BorderStyle.solid,
              color: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(0.25),
            ),
            bottom: BorderSide(
              width: 5,
              style: BorderStyle.solid,
              color: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(0.25),
            ),
          ),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(
            Icons.eco_outlined,
            size: 26,
          ),
          const SizedBox(width: 8),
          Text(
            currentSeason.toUpperCase(),
            style: currentTheme.textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                shadows: [
                  Shadow(
                    color: Theme.of(context).colorScheme.shadow,
                    blurRadius: 12,
                    offset: const Offset(1, 2),
                  )
                ]),
            textAlign: TextAlign.center,
          )
        ]),
      ),
    );
  }
}
