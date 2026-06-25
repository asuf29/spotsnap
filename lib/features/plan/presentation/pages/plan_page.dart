import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/design_system/design_system.dart';
import '../../../discover/presentation/providers/discover_providers.dart';
import '../../../route/presentation/providers/route_providers.dart';
import '../../../route/presentation/widgets/route_map_view.dart';
import '../../../route/presentation/widgets/route_timeline.dart';

class PlanPage extends ConsumerWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final cityId = ref.watch(selectedCityIdProvider);
    final spots = cityId != null
        ? ref.watch(discoverSpotsProvider)
        : ref.watch(featuredSpotsProvider);
    final selected = ref.watch(selectedRouteSpotIdsProvider);
    final prioritizeGolden = ref.watch(prioritizeGoldenHourProvider);
    final route = ref.watch(generatedRouteProvider);

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
                  Text(
                    l10n.smartRoute,
                    style: theme.textTheme.headlineLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cityId != null
                        ? l10n.selectSpotsRoute
                        : l10n.selectSpotsOrCity,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(l10n.prioritizeGoldenHour),
                    subtitle: Text(l10n.prioritizeGoldenHourSubtitle),
                    value: prioritizeGolden,
                    onChanged: (v) =>
                        ref.read(prioritizeGoldenHourProvider.notifier).state = v,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: spots.take(12).map((spot) {
                  final isSelected = selected.contains(spot.id);
                  return FilterChip(
                    label: Text(spot.name),
                    selected: isSelected,
                    onSelected: (_) => toggleRouteSpot(ref, spot.id),
                  );
                }).toList(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: selected.isEmpty
                      ? null
                      : () {
                          generateRoute(ref);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(l10n.routeOptimized)),
                            );
                          }
                        },
                  icon: const Icon(Icons.auto_awesome),
                  label: Text(
                    selected.isEmpty
                        ? l10n.selectSpotsFirst
                        : l10n.generateRouteCount(selected.length),
                  ),
                ),
              ),
            ),
          ),
          if (route != null) ...[
            SliverToBoxAdapter(
              child: RouteMapView(plan: route),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(route.planDateLabel,
                          style: theme.textTheme.titleLarge),
                    ),
                    GoldenHourChip(
                      label: l10n.minWalk(route.totalWalkTime.inMinutes),
                      compact: true,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: RouteTimeline(plan: route),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: OutlinedButton(
                  onPressed: () {
                    final first = route.stops.first.spot.id;
                    context.push(AppRoutes.spotDetailPath(first));
                  },
                  child: Text(l10n.viewFirstStop),
                ),
              ),
            ),
          ],
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }
}
