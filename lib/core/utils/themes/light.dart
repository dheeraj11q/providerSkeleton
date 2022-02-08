import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.blue.shade100,
    primaryColor: Colors.blue,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
    iconTheme: const IconThemeData(
      color: Colors.grey,
    ),
    textTheme: const TextTheme(button: TextStyle(color: Colors.white)),
    colorScheme: const ColorScheme.light());
