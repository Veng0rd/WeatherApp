import 'package:flutter/material.dart';

class AppThemes {
  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 96),
    displayMedium: TextStyle(fontSize: 36),
    displaySmall: TextStyle(fontSize: 24),
    bodyLarge: TextStyle(fontSize: 18),
    bodyMedium: TextStyle(fontSize: 12),
    bodySmall: TextStyle(fontSize: 10),
  );

  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.light,
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: const Color.fromARGB(255, 97, 97, 97),
    ),
    fontFamily: 'Ubuntu',
    textTheme: textTheme,
  );

  static final ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark().copyWith(
      brightness: Brightness.dark,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: const Color.fromARGB(255, 97, 97, 97),
    ),
    fontFamily: 'Ubuntu',
    textTheme: textTheme,
  );
}
