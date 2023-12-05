import 'package:flutter/material.dart';

final appTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.brown[200],
    elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.brown[400];
          }
          return Colors.white;
        }))),
    textTheme: const TextTheme(
        displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontFamily:"Open Sans",
            fontWeight: FontWeight.w700)));
class AppTheme {
  static const Color primaryColor = Color(0xFF007AFF);
  static const Color secondaryColor = Color(0xFFFFA500);
// Add more colors as needed
}
final ThemeData appThemeData = ThemeData(
  primaryColor: AppTheme.primaryColor,
  hintColor: AppTheme.secondaryColor,
  // Define other theme properties
);