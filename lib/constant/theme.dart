import 'package:flutter/material.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.brown, // Change this to your desired primary color
  ),
  primaryColor: Colors.brown, // Set the primary color separately
  hintColor: Colors.brown[200], // Define the secondary color as accentColor
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.pressed)) {
          return Colors.brown[400];
        }
        return Colors.brown[400];
      }),
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontFamily: "Open Sans",
      fontWeight: FontWeight.w700,
    ),
  ),
);
