import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade100,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    onPrimary: const Color(0XFF9f5afd),
    onSecondary: const Color(0XFF625894),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color(0XFF262938),
    primary: Color(0XFF262938),
    secondary: Colors.white,
    onPrimary: Color(0XFF9f5afd),
    onSecondary: Color(0XFF625894),
  ),
);
