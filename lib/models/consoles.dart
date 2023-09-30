import 'package:flutter/material.dart';

class Consoles with ChangeNotifier {
  final String background;
  final String title;

  Consoles({
    required this.background,
    required this.title,
  });
}
