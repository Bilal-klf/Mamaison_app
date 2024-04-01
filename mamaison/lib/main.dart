import 'package:flutter/material.dart';
import 'package:mamaison/login_page.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 37, 37, 51));

var kDarkColorSheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125));

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]).then((fn){});
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorSheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorSheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: kColorScheme.onPrimaryContainer,
              backgroundColor: kColorScheme.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              bodyMedium: TextStyle(
                  color: kColorScheme.onSecondaryContainer,
                  fontSize: 15,
                  fontWeight: FontWeight.normal), // text inside the cards
              titleLarge: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kColorScheme.onSecondaryContainer),
            ),
      ),
      themeMode: ThemeMode.dark,
      home: const Scaffold(body: LoginPage()),
    ),
  );
}
