import 'package:flutter/material.dart';

class WeatherFactor {
  Icon icon;
  String name;
  String? description;

  WeatherFactor({required this.icon, required this.name, this.description});
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
        'Mars boasts an atmosphere that starkly contrasts with Earth\'s. Dominated by carbon dioxide, Mars has a thin atmosphere, approximately 100 times less dense than Earth\'s. This results in lower atmospheric pressure, significantly affecting weather patterns and making it challenging for liquid water to exist on the surface. The Martian atmosphere, while influencing winds and occasional dust storms, lacks the dynamic complexity and life-sustaining properties found on Earth.',
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
        'Daily temperatures on Mars can range from extremely cold, plunging as low as -195\u00B0 Fahrenheit (-125\u00B0 Celsius) near the poles, to milder conditions in equatorial regions. Additionally, Mars lacks the same moderating effect of oceans found on Earth, leading to more rapid temperature fluctuations between day and night. The planet\'s distinct thermal properties contribute to its challenging environmental conditions, influencing scientific exploration and understanding of the Martian climate.',
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
        'Mars experiences distinctive winds that differ significantly from those on Earth. Due to its thin atmosphere, Martian winds can reach high speeds, leading to powerful dust storms that can blanket the entire planet. These winds play a crucial role in shaping the Martian landscape, moving fine dust particles across vast regions and contributing to the formation of unique dune fields.',
  ),
];
