import 'package:flutter/material.dart';

class Games with ChangeNotifier {
  final String cover;
  final String title;
  final String description;
  final String video;
  final List<String> genres;
  final List<String> platform;
  final List<String> releaseDate;
  final String publisher;

  Games({
    required this.cover,
    required this.title,
    required this.description,
    required this.video,
    required this.genres,
    required this.platform,
    required this.releaseDate,
    required this.publisher,
  });
}
