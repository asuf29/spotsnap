import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../discover/domain/entities/city.dart';
import '../../../discover/presentation/providers/discover_providers.dart';
import '../providers/social_providers.dart';

class SavedCitiesPage extends ConsumerWidget {
  const SavedCitiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final savedIds = ref.watch(savedCityIdsProvider);
    final cities = ref
        .watch(discoverRepositoryProvider)
        .getTrendingCities()
        .where((c) => savedIds.contains(c.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.savedCities)),
      body: cities.isEmpty
          ? EmptyState(
              icon: Icons.bookmark_border,
              title: l10n.savedCities,
              subtitle: 'Save cities from Discover to revisit quickly.',
              actionLabel: l10n.navDiscover,
              onAction: () => context.go(AppRoutes.discover),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: cities.length,
              separatorBuilder: (_, i) =>
                  const SizedBox(height: AppSpacing.sm - 4),
              itemBuilder: (context, index) {
                final city = cities[index];
                return _SavedCityCard(city: city)
                    .animate()
                    .fadeIn(duration: 300.ms, delay: (50 * index).ms)
                    .slideX(
                      begin: 0.05,
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

class _SavedCityCard extends ConsumerWidget {
  const _SavedCityCard({required this.city});

  final City city;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      child: ListTile(
        onTap: () {
          selectCity(ref, city.id);
          context.go(AppRoutes.discover);
        },
        leading: const Icon(Icons.bookmark, color: AppColors.gold),
        title: Text(
          city.name,
          style: theme.textTheme.titleMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          city.tagline,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.close, size: 20),
          onPressed: () => toggleSavedCity(ref, city.id),
        ),
      ),
    );
  }
}
