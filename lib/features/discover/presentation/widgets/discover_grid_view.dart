import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/design_system/design_system.dart';
import '../../../spot/domain/entities/spot.dart';
import '../../../spot/domain/entities/spot_extensions.dart';

class DiscoverGridView extends StatelessWidget {
  const DiscoverGridView({super.key, required this.spots});

  final List<Spot> spots;

  @override
  Widget build(BuildContext context) {
    if (spots.isEmpty) {
      return GridView.builder(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.xs,
          AppSpacing.md,
          100,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.sm - 4,
          crossAxisSpacing: AppSpacing.sm - 4,
          childAspectRatio: AppSpacing.spotCardAspectRatio,
        ),
        itemCount: 6,
        itemBuilder: (context, index) => SpotPreviewCard(
          title: '',
          isLoading: true,
          onTap: () {},
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.xs,
        AppSpacing.md,
        100,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.sm - 4,
        crossAxisSpacing: AppSpacing.sm - 4,
        childAspectRatio: AppSpacing.spotCardAspectRatio,
      ),
      itemCount: spots.length,
      itemBuilder: (context, index) {
        final spot = spots[index];
        return SpotPreviewCard(
          title: spot.name,
          imageUrl: spot.primaryImageUrl,
          bestTimeLabel: spot.bestTimeLabel,
          crowd: spot.crowd,
          vibes: spot.vibes,
          heroTag: 'spot-image-${spot.id}',
          onTap: () => context.push(AppRoutes.spotDetailPath(spot.id)),
        );
      },
    );
  }
}
