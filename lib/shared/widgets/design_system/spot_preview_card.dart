import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../features/spot/domain/entities/spot.dart';
import '../../extensions/vibe_tag_extension.dart';
import '../spot_image.dart';
import 'crowd_indicator.dart';
import 'golden_hour_chip.dart';
import 'shimmer_box.dart';
import 'vibe_chip.dart';

class SpotPreviewCard extends StatelessWidget {
  const SpotPreviewCard({
    super.key,
    required this.title,
    required this.onTap,
    this.imageUrl,
    this.bestTimeLabel,
    this.crowd = CrowdLevel.medium,
    this.vibes = const [],
    this.isLoading = false,
    this.aspectRatio = AppSpacing.spotCardAspectRatio,
    this.heroTag,
  });

  final String title;
  final VoidCallback onTap;
  final String? imageUrl;
  final String? bestTimeLabel;
  final CrowdLevel crowd;
  final List<VibeTag> vibes;
  final bool isLoading;
  final double aspectRatio;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isLoading) {
      return AspectRatio(
        aspectRatio: aspectRatio,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          child: const ShimmerBox(borderRadius: AppConstants.cardRadius),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.cardRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Full-bleed image
              _maybeHero(
                tag: heroTag,
                child: SpotImage(imageUrl: imageUrl, borderRadius: 0),
              ),

              // Bottom gradient overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.72),
                      ],
                      stops: const [0.38, 1.0],
                    ),
                  ),
                ),
              ),

              // Top row: golden hour chip + vibe chip
              if (bestTimeLabel != null || vibes.isNotEmpty)
                Positioned(
                  top: AppSpacing.xs,
                  left: AppSpacing.xs,
                  right: AppSpacing.xs,
                  child: Row(
                    children: [
                      if (bestTimeLabel != null)
                        Flexible(
                          child: GoldenHourChip(
                            label: bestTimeLabel!,
                            compact: true,
                          ),
                        ),
                      if (bestTimeLabel != null && vibes.isNotEmpty)
                        const SizedBox(width: 4),
                      if (vibes.isNotEmpty)
                        VibeChip(
                          label: vibes.first.label,
                          variant: vibes.first.chipVariant,
                        ),
                    ],
                  ),
                ),

              // Bottom: title + crowd
              Positioned(
                left: AppSpacing.sm - 4,
                right: AppSpacing.sm - 4,
                bottom: AppSpacing.sm - 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        shadows: const [
                          Shadow(blurRadius: 8, color: Colors.black54),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    CrowdIndicator(
                      level: crowd,
                      compact: true,
                      showLabel: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _maybeHero({String? tag, required Widget child}) {
    if (tag == null) return child;
    return Hero(tag: tag, child: child);
  }
}
