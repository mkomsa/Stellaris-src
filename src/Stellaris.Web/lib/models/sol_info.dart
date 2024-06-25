import 'package:flutter/material.dart';

class WeatherFactor {
  Icon icon;
  String name;
  String? description;

  WeatherFactor({required this.icon, required this.name, this.description});
}

class WeatherFactorUtility {
  static String getMeasureUnitForFactor(String factorName) {
    switch (factorName) {
      case 'Pressure':
        return 'Pa';
      case 'Temperature':
        return '\u00B0F';
      case 'Wind':
        return 'm / s';
      default:
        return 'U';
    }
  }
}

List<WeatherFactor> weatherFactors = [
  WeatherFactor(
    icon: const Icon(
      Icons.south,
      size: 32,
      shadows: [
        Shadow(
          color: Color(0xFF88A4C4),
          blurRadius: 64,
          offset: Offset(0, 8),
        )
      ],
    ),
    name: 'Pressure',
    description:
        'Mars boasts an atmosphere that starkly contrasts with Earth\'s. Dominated by carbon dioxide, Mars has a thin atmosphere, approximately 100 times less dense than Earth\'s. This results in lower atmospheric pressure, significantly affecting weather patterns and making it challenging for liquid water to exist on the surface.',
  ),
  WeatherFactor(
    icon: const Icon(
      Icons.thermostat_outlined,
      size: 32,
      shadows: [
        Shadow(
          color: Color(0xFF88A4C4),
          blurRadius: 64,
          offset: Offset(0, 8),
        )
      ],
    ),
    name: 'Temperature',
    description:
        'Daily temperatures on Mars can range from extremely cold, plunging as low as -195 degrees Fahrenheit (-125 degrees Celsius) near the poles, to milder conditions in equatorial regions. Additionally, Mars lacks the same moderating effect of oceans found on Earth, leading to more rapid temperature fluctuations between day and night.',
  ),
  WeatherFactor(
    icon: const Icon(
      Icons.air_outlined,
      size: 32,
      shadows: [
        Shadow(
          color: Color(0xFF88A4C4),
          blurRadius: 64,
          offset: Offset(0, 8),
        )
      ],
    ),
    name: 'Wind',
    description:
        'Mars experiences distinctive winds that differ significantly from those on Earth. Due to its thin atmosphere, Martian winds can reach high speeds, leading to powerful dust storms that can blanket the entire planet. These winds play a crucial role in shaping the Martian landscape, moving fine dust particles across vast regions.',
  ),
];
