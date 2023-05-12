import 'dart:ui';

class Category {
  Category({
    required this.title,
    required this.category,
    required this.textColor,
    required this.accentColor,
  });

  final String title;
  final String category; // used for calling api
  final Color textColor; // for app theme customization
  final Color accentColor; // for app theme customization
}