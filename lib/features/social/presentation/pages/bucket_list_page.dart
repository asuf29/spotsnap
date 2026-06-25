import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../discover/domain/entities/city.dart';
import '../../../discover/presentation/providers/discover_providers.dart';
import '../providers/social_providers.dart';

class BucketListPage extends ConsumerWidget {
  const BucketListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final bucketIds = ref.watch(bucketListCityIdsProvider);
    final allCities = ref.watch(discoverRepositoryProvider).getTrendingCities();

    final bucketCities =
        allCities.where((c) => bucketIds.contains(c.id)).toList();
    final otherCities =
        allCities.where((c) => !bucketIds.contains(c.id)).toList();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.bucketList)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            'Dream destinations for your next shoot trip.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          if (bucketCities.isNotEmpty) ...[
            Text('On your list', style: theme.textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            ...bucketCities.asMap().entries.map(
                  (e) => _CityBucketTile(city: e.value, onList: true)
                      .animate()
                      .fadeIn(duration: 300.ms, delay: (50 * e.key).ms)
                      .slideX(
                        begin: -0.05,
                        end: 0,
                        duration: 300.ms,
                        delay: (50 * e.key).ms,
                        curve: Curves.easeOut,
                      ),
                ),
            const SizedBox(height: AppSpacing.lg),
          ],
          Text('Add more', style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          ...otherCities.asMap().entries.map(
                (e) => _CityBucketTile(city: e.value, onList: false)
                    .animate()
                    .fadeIn(duration: 300.ms, delay: (50 * e.key).ms)
                    .slideX(
                      begin: 0.05,
                      end: 0,
                      duration: 300.ms,
                      delay: (50 * e.key).ms,
                      curve: Curves.easeOut,
                    ),
              ),
        ],
      ),
    );
  }
}

class _CityBucketTile extends ConsumerWidget {
  const _CityBucketTile({
    required this.city,
    required this.onList,
  });

  final City city;
  final bool onList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm - 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.gold.withValues(alpha: 0.2),
          child: Text(
            city.name[0],
            style:
                theme.textTheme.titleMedium?.copyWith(color: AppColors.gold),
          ),
        ),
        title: Text(city.name),
        subtitle: Text('${city.country} · ${city.spotCount} spots'),
        trailing: IconButton(
          icon: Icon(
            onList ? Icons.check_circle : Icons.add_circle_outline,
            color: AppColors.gold,
          ),
          onPressed: () => toggleBucketList(ref, city.id),
        ),
      ),
    );
  }
}
