import 'package:flutter/material.dart';

class OutfitConcept {
  const OutfitConcept({
    required this.id,
    required this.name,
    required this.description,
    required this.palette,
    required this.items,
    required this.weatherNote,
    this.cityIds = const [],
  });

  final String id;
  final String name;
  final String description;
  final List<Color> palette;
  final List<String> items;
  final String weatherNote;
  final List<String> cityIds;
}

class WardrobeItem {
  const WardrobeItem({
    required this.id,
    required this.name,
    required this.category,
    required this.color,
  });

  final String id;
  final String name;
  final String category;
  final Color color;
}
