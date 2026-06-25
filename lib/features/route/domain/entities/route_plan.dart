import 'package:flutter/material.dart';

import '../../../spot/domain/entities/spot.dart';

enum TravelMode { walk, metro, rideshare }

class RouteStop {
  const RouteStop({
    required this.spot,
    required this.arrivalLabel,
    required this.order,
    this.modeToNext = TravelMode.walk,
    this.durationToNext = Duration.zero,
  });

  final Spot spot;
  final String arrivalLabel;
  final int order;
  final TravelMode modeToNext;
  final Duration durationToNext;
}

class RoutePlan {
  const RoutePlan({
    required this.id,
    required this.stops,
    required this.totalWalkTime,
    required this.planDateLabel,
  });

  final String id;
  final List<RouteStop> stops;
  final Duration totalWalkTime;
  final String planDateLabel;
}

extension TravelModeX on TravelMode {
  String get label => switch (this) {
        TravelMode.walk => 'Walk',
        TravelMode.metro => 'Metro',
        TravelMode.rideshare => 'Uber',
      };

  IconData get icon => switch (this) {
        TravelMode.walk => Icons.directions_walk,
        TravelMode.metro => Icons.train_outlined,
        TravelMode.rideshare => Icons.local_taxi_outlined,
      };
}
