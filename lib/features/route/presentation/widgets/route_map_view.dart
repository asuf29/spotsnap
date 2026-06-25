import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/spot_coordinates.dart';
import '../../domain/entities/route_plan.dart';

/// Route map — Mapbox Light when `MAPBOX_TOKEN` is set, else Carto Voyager.
class RouteMapView extends StatelessWidget {
  const RouteMapView({super.key, required this.plan});

  final RoutePlan plan;

  static String get _tileUrl {
    if (AppConfig.useMapbox) {
      return 'https://api.mapbox.com/styles/v1/mapbox/light-v11/tiles/256/{z}/{x}/{y}'
          '?access_token=${AppConfig.mapboxAccessToken}';
    }
    return 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}{r}.png';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final points = plan.stops
        .map((s) => SpotCoordinates.forSpot(s.spot.id))
        .whereType<LatLng>()
        .toList();

    if (points.isEmpty) {
      return const SizedBox(
        height: 220,
        child: Center(child: Text('No map coordinates for selected spots')),
      );
    }

    final bounds = LatLngBounds.fromPoints(points);
    final center = bounds.center;

    return Container(
      height: 260,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: AppColors.beige.withValues(alpha: 0.8),
        ),
      ),
      child: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: center,
              initialZoom: 13,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: _tileUrl,
                subdomains: AppConfig.useMapbox
                    ? const []
                    : const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.snapspot.snapspot',
              ),
              if (points.length > 1)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: points,
                      color: AppColors.gold,
                      strokeWidth: 3,
                    ),
                  ],
                ),
              MarkerLayer(
                markers: [
                  for (var i = 0; i < plan.stops.length; i++)
                    if (SpotCoordinates.forSpot(plan.stops[i].spot.id) != null)
                      Marker(
                        point: SpotCoordinates.forSpot(plan.stops[i].spot.id)!,
                        width: 36,
                        height: 36,
                        child: _MapPin(order: i + 1),
                      ),
                ],
              ),
            ],
          ),
          Positioned(
            left: AppSpacing.sm,
            bottom: AppSpacing.sm,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Text(
                  '${plan.stops.length} stops · ${AppConfig.useMapbox ? 'Mapbox' : 'Carto'} · pinch to explore',
                  style: theme.textTheme.bodySmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapPin extends StatelessWidget {
  const _MapPin({required this.order});

  final int order;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.gold,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.25),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            '$order',
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        CustomPaint(
          size: const Size(10, 6),
          painter: _PinTailPainter(),
        ),
      ],
    );
  }
}

class _PinTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = ui.Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, Paint()..color = AppColors.gold);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
