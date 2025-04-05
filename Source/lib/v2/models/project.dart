import 'package:flutter/foundation.dart';

@immutable
class Project {
  final String title;
  final String imagePath;
  final String date; // Using String for simplicity, could be DateTime
  final String category; // e.g., 'made', 'contributed'
  final List<String> platforms; // e.g., ['mobile', 'web']
  final Map<String, String> links; // e.g., {'playstore': 'url', 'github': 'url'}

  const Project({
    required this.title,
    required this.imagePath,
    required this.date,
    required this.category,
    required this.platforms,
    required this.links,
  });
}
