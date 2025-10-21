import 'package:flutter/material.dart';

/// The `AppTheme` class in Dart defines a method to retrieve a theme with Material3 design and a custom
/// color scheme.
class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(56, 142, 60, 1),
        ),
      );
}
