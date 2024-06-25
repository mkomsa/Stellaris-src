import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stellaris_app/providers/selected_sol_data_provider.dart';
import 'package:stellaris_app/screens/tabs.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  HttpOverrides.global =
      MyHttpOverrides(); //NOTE: only for dev purposes, otherwise certification is needed
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then(
    (fn) => runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends ConsumerState<MyApp> {
  ColorScheme getCurrentColorScheme(String season) {
    ColorScheme currentColorScheme = kFallColorScheme;

    switch (season) {
      case 'spring':
        currentColorScheme = kSpringColorScheme;
        break;
      case 'winter':
        currentColorScheme = kWinterColorScheme;
      case 'fall':
        currentColorScheme = kFallColorScheme;
      case 'summer':
        currentColorScheme = kSummerColorScheme;
        break;
    }

    return currentColorScheme;
  }

  @override
  Widget build(BuildContext context) {
    final weatherDataForSelectedSol = ref.watch(selectedWeatherDataProvider);

    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: getCurrentColorScheme(weatherDataForSelectedSol.season),
      textTheme: GoogleFonts.montserratTextTheme(),
    );

    return MaterialApp(
      title: 'WeatherInSight',
      theme: theme,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          Text(
            'Weather InSight',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w900,
                ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.6),
      nextScreen: const TabsScreen(),
      splashIconSize: 300,
      duration: 1500,
      splashTransition: SplashTransition.decoratedBoxTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}

var kFallColorScheme = const ColorScheme(
  primary: Color(0xFFE8A38E),
  onPrimary: Color(0xFFFDFCF4),
  secondary: Color(0xFFF9D9B6),
  onSecondary: Color(0xFF180D1F),
  surface: Color(0xFFE8A38E),
  onSurface: Color(0xFFFDFCF4),
  background: Color(0xFFE8A38E),
  onBackground: Color(0xFFFDFCF4),
  error: Color(0xFFB00020),
  onError: Color(0xFFFFFFFF),
  brightness: Brightness.light,
);

var kWinterColorScheme = const ColorScheme(
  primary: Color.fromARGB(255, 200, 200, 255),
  onPrimary: Color.fromARGB(255, 255, 255, 255),
  secondary: Color.fromARGB(255, 216, 234, 255),
  onSecondary: Color.fromARGB(255, 0, 100, 170),
  surface: Color.fromARGB(255, 200, 200, 255),
  onSurface: Color.fromARGB(255, 255, 255, 255),
  background: Color.fromARGB(255, 200, 200, 255),
  onBackground: Color.fromARGB(255, 255, 255, 255),
  error: Color(0xFFB00020),
  onError: Color(0xFFFFFFFF),
  brightness: Brightness.light,
);

var kSpringColorScheme = const ColorScheme(
  primary: Color.fromARGB(255, 174, 203, 142),
  onPrimary: Color.fromARGB(255, 165, 245, 210),
  secondary: Color(0xFFE1F7BF),
  onSecondary: Color.fromARGB(255, 40, 40, 30),
  surface: Color.fromARGB(255, 182, 220, 140),
  onSurface: Color.fromARGB(255, 235, 255, 220),
  background: Color.fromARGB(255, 174, 203, 142),
  onBackground: Color.fromARGB(255, 165, 245, 210),
  error: Color(0xFFB00020),
  onError: Color(0xFFFFFFFF),
  brightness: Brightness.light,
);

var kSummerColorScheme = const ColorScheme(
  primary: Color(0xFFEEDCA5),
  onPrimary: Color.fromARGB(255, 240, 255, 210),
  secondary: Color(0xFFF7F1C4),
  onSecondary: Color(0xFF1D3749),
  surface: Color(0xFFEEDCA5),
  onSurface: Colors.white,
  background: Color(0xFFEEDCA5),
  onBackground: Color(0xFF1D3749),
  error: Color(0xFFB00020),
  onError: Color(0xFFFFFFFF),
  brightness: Brightness.light,
);
