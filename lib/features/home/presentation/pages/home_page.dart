import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../features/discover/presentation/providers/discover_providers.dart';
import '../../../../features/spot/domain/entities/spot_extensions.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/design_system/design_system.dart';
import '../../../../shared/widgets/glass_container.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const _cities = [
    ('paris', 'Paris', '🗼'),
    ('seoul', 'Seoul', '🌸'),
    ('istanbul', 'İstanbul', '🕌'),
    ('tokyo', 'Tokyo', '⛩️'),
    ('santorini', 'Santorini', '🌊'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final featured = ref.watch(featuredSpotsProvider);

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.goodMorning, style: theme.textTheme.bodyMedium),
                  Text(
                    l10n.readyToShoot,
                    style: theme.textTheme.headlineLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _GoldenHourBanner(),
                  const SizedBox(height: AppSpacing.lg),
                  Text(l10n.trendingCities,
                      style: theme.textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.sm),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 128,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md),
                itemCount: _cities.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: AppSpacing.xs),
                itemBuilder: (context, index) {
                  final (id, name, emoji) = _cities[index];
                  return _CityChip(
                    name: name,
                    emoji: emoji,
                    onTap: () {
                      selectCity(ref, id);
                      context.go(AppRoutes.discover);
                    },
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.sm,
              ),
              child: Text(l10n.forYou, style: theme.textTheme.titleLarge),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.xs,
                crossAxisSpacing: AppSpacing.xs,
                childAspectRatio: AppSpacing.spotCardAspectRatio,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (featured.isEmpty) {
                    return const SpotPreviewCard(
                      title: '',
                      isLoading: true,
                      onTap: _noop,
                    );
                  }
                  final spot = featured[index];
                  return SpotPreviewCard(
                    title: spot.name,
                    imageUrl: spot.primaryImageUrl,
                    bestTimeLabel: spot.bestTimeLabel,
                    crowd: spot.crowd,
                    vibes: spot.vibes,
                    heroTag: 'spot-image-${spot.id}',
                    onTap: () => context.push(
                      AppRoutes.spotDetailPath(spot.id),
                    ),
                  );
                },
                childCount:
                    featured.isEmpty ? 4 : featured.length.clamp(0, 4),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

void _noop() {}

class _GoldenHourBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassContainer(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.wb_twilight_outlined,
              color: AppColors.gold,
              size: 22,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's golden hour",
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.xs - 4),
                const GoldenHourChip(
                  label: '18:42 – 19:30',
                  subtitle: 'Best shoot window',
                  compact: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CityChip extends StatelessWidget {
  const _CityChip({
    required this.name,
    required this.emoji,
    required this.onTap,
  });

  final String name;
  final String emoji;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 96,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDark ? AppColors.darkCard : AppColors.beigeLight,
          border: Border.all(
            color: isDark ? AppColors.darkDivider : AppColors.beige,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(AppSpacing.sm - 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 26)),
            const Spacer(),
            Text(
              name,
              style: theme.textTheme.labelLarge?.copyWith(
                fontSize: 13,
                color: isDark ? AppColors.textOnDark : AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
