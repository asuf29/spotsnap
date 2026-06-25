import 'package:flutter/material.dart';

import '../../features/spot/domain/entities/spot.dart';

extension SpotCategoryX on SpotCategory {
  String get label => switch (this) {
        SpotCategory.popular => 'Popular',
        SpotCategory.hiddenGem => 'Hidden gems',
        SpotCategory.sunset => 'Sunset',
        SpotCategory.cafe => 'Cafe spots',
        SpotCategory.rooftop => 'Rooftop',
        SpotCategory.beach => 'Beach',
      };

  IconData get icon => switch (this) {
        SpotCategory.popular => Icons.local_fire_department_outlined,
        SpotCategory.hiddenGem => Icons.diamond_outlined,
        SpotCategory.sunset => Icons.wb_twilight_outlined,
        SpotCategory.cafe => Icons.coffee_outlined,
        SpotCategory.rooftop => Icons.apartment_outlined,
        SpotCategory.beach => Icons.beach_access_outlined,
      };
}
