import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/design_system/design_system.dart';
import '../../../spot/domain/entities/spot_extensions.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/city.dart';
import '../providers/discover_providers.dart';

class DiscoverLandingView extends ConsumerWidget {
  const DiscoverLandingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(discoverSearchQueryProvider).trim();
    final cities = ref.watch(citySearchResultsProvider);
    final featured = ref.watch(featuredSpotsProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    if (query.isNotEmpty) {
      return _CitySearchResults(cities: cities);
    }

    return ListView(
      padding: const EdgeInsets.only(bottom: 100),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSpacing.md, AppSpacing.xs, AppSpacing.md, 0),
          child: Text(
            l10n.whereShooting,
            style: theme.textTheme.headlineMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            l10n.whereShootingSubtitle,
            style: theme.textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.md),
          child: Text(l10n.trending, style: theme.textTheme.titleLarge),
        ),
        const SizedBox(height: AppSpacing.sm - 4),
        SizedBox(
          height: 148,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemCount: cities.length,
            separatorBuilder: (context, index) =>
                const SizedBox(width: AppSpacing.xs),
            itemBuilder: (context, index) {
              return _TrendingCityCard(
                city: cities[index],
                onTap: () => selectCity(ref, cities[index].id),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child:
              Text(l10n.featuredWorldwide, style: theme.textTheme.titleLarge),
        ),
        const SizedBox(height: AppSpacing.sm - 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: AppSpacing.xs,
              crossAxisSpacing: AppSpacing.xs,
              childAspectRatio: AppSpacing.spotCardAspectRatio,
            ),
            itemCount: featured.length,
            itemBuilder: (context, index) {
              final spot = featured[index];
              return SpotPreviewCard(
                title: spot.name,
                imageUrl: spot.primaryImageUrl,
                bestTimeLabel: spot.bestTimeLabel,
                crowd: spot.crowd,
                vibes: spot.vibes,
                heroTag: 'spot-image-${spot.id}',
                onTap: () =>
                    context.push(AppRoutes.spotDetailPath(spot.id)),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CitySearchResults extends StatelessWidget {
  const _CitySearchResults({required this.cities});

  final List<City> cities;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (cities.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Text(
            'No cities found. Try Paris, Seoul, or Tokyo.',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Consumer(
      builder: (context, ref, _) {
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.xs,
            AppSpacing.md,
            100,
          ),
          itemCount: cities.length,
          separatorBuilder: (context, index) =>
              const SizedBox(height: AppSpacing.xs),
          itemBuilder: (context, index) {
            final city = cities[index];
            return _CityListTile(
              city: city,
              onTap: () => selectCity(ref, city.id),
            );
          },
        );
      },
    );
  }
}

class _TrendingCityCard extends StatelessWidget {
  const _TrendingCityCard({required this.city, required this.onTap});

  final City city;
  final VoidCallback onTap;

  static const _emojis = ['🗼', '🌸', '🕌', '⛩️', '🌊', '🏛️', '🌃', '🏙️'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final emoji = _emojis[city.name.hashCode.abs() % _emojis.length];

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          color: isDark ? AppColors.darkCard : AppColors.beigeLight,
          border: Border.all(
            color: isDark ? AppColors.darkDivider : AppColors.beige,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const Spacer(),
            Text(
              city.name,
              style: theme.textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              '${city.spotCount} spots',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.gold,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CityListTile extends StatelessWidget {
  const _CityListTile({required this.city, required this.onTap});

  final City city;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: isDark ? AppColors.darkCard : AppColors.beigeLight,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm, vertical: AppSpacing.sm - 4),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  city.name.isNotEmpty
                      ? city.name[0].toUpperCase()
                      : '?',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: AppColors.gold),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(city.name, style: theme.textTheme.titleMedium),
                    Text(
                      '${city.country} · ${city.spotCount} spots',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 20,
                color: isDark
                    ? AppColors.textMutedOnDark
                    : AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
