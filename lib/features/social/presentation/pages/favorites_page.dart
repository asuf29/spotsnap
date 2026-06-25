import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/design_system/design_system.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../discover/presentation/providers/discover_providers.dart';
import '../../../spot/domain/entities/spot.dart';
import '../../../spot/domain/entities/spot_extensions.dart';
import '../providers/social_providers.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final ids = ref.watch(favoriteSpotIdsProvider).toList();

    final spots = ids
        .map((id) => ref.watch(spotByIdProvider(id)))
        .whereType<Spot>()
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.favorites)),
      body: spots.isEmpty
          ? EmptyState(
              icon: Icons.favorite_border,
              title: l10n.favorites,
              subtitle: 'Tap the heart on any spot to save it here.',
              actionLabel: l10n.navDiscover,
              onAction: () => context.go(AppRoutes.discover),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
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
                  onTap: () =>
                      context.push(AppRoutes.spotDetailPath(spot.id)),
                )
                    .animate()
                    .fadeIn(
                      duration: 300.ms,
                      delay: (50 * index).ms,
                    )
                    .slideY(
                      begin: 0.1,
                      end: 0,
                      duration: 300.ms,
                      delay: (50 * index).ms,
                      curve: Curves.easeOut,
                    );
              },
            ),
    );
  }
}
