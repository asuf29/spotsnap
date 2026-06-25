import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/extensions/vibe_tag_extension.dart';
import '../../../../shared/providers/create_context_provider.dart';
import '../../../../shared/widgets/design_system/design_system.dart';
import '../../../../shared/widgets/spot_image.dart';
import '../../../route/presentation/providers/route_providers.dart';
import '../../../social/presentation/providers/social_providers.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../spot/domain/entities/spot.dart';
import '../../../spot/domain/entities/spot_extensions.dart';

class DiscoverReelPage extends ConsumerWidget {
  const DiscoverReelPage({super.key, required this.spot});

  final Spot spot;

  void _setContext(WidgetRef ref) {
    ref.read(createContextSpotIdProvider.notifier).state = spot.id;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: 'spot-image-${spot.id}',
          child: SpotImage(
            imageUrl: spot.primaryImageUrl,
            fit: BoxFit.cover,
            borderRadius: 0,
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.75),
              ],
              stops: const [0.5, 1.0],
            ),
          ),
        ),
        Positioned(
          right: AppSpacing.md,
          bottom: MediaQuery.paddingOf(context).bottom + 120,
          child: Column(
            children: [
              _ReelAction(
                icon: ref.watch(isFavoriteProvider(spot.id))
                    ? Icons.favorite
                    : Icons.favorite_border,
                label: l10n.save,
                onTap: () {
                  toggleFavorite(ref, spot.id);
                  HapticFeedback.lightImpact();
                },
              ),
              const SizedBox(height: AppSpacing.md),
              _ReelAction(
                icon: Icons.face_retouching_natural_outlined,
                label: l10n.pose,
                onTap: () {
                  _setContext(ref);
                  context.push(AppRoutes.poseAssistant);
                },
              ),
              const SizedBox(height: AppSpacing.md),
              _ReelAction(
                icon: Icons.share_outlined,
                label: l10n.share,
                onTap: () {
                  final text = l10n.shareSpotTitle(spot.name);
                  Share.share(text);
                },
              ),
              const SizedBox(height: AppSpacing.md),
              _ReelAction(
                icon: Icons.route_outlined,
                label: l10n.route,
                onTap: () {
                  toggleRouteSpot(ref, spot.id);
                  _setContext(ref);
                  context.go(AppRoutes.plan);
                },
              ),
            ],
          ),
        ),
        Positioned(
          left: AppSpacing.md,
          right: 72,
          bottom: MediaQuery.paddingOf(context).bottom + AppSpacing.lg,
          child: GestureDetector(
            onTap: () => context.push(AppRoutes.spotDetailPath(spot.id)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (spot.bestTimeLabel != null)
                  GoldenHourChip(label: spot.bestTimeLabel!, compact: true),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  spot.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    CrowdIndicator(
                      level: spot.crowd,
                      compact: true,
                      showLabel: false,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      spot.crowd.label,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.textMutedOnDark,
                      ),
                    ),
                  ],
                ),
                if (spot.vibes.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.sm),
                  VibeChip(
                    label: spot.vibes.first.label,
                    variant: spot.vibes.first.chipVariant,
                  ),
                ],
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.tapForDetails,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.gold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ReelAction extends StatelessWidget {
  const _ReelAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.white, size: 24),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.white,
                  fontSize: 10,
                ),
          ),
        ],
      ),
    );
  }
}
