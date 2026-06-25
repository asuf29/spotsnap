import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../features/route/presentation/providers/route_providers.dart';
import '../../l10n/app_localizations.dart';

class MainShell extends ConsumerWidget {
  const MainShell({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final selected = ref.watch(selectedRouteSpotIdsProvider);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isDark
                  ? AppColors.darkDivider
                  : AppColors.beige,
              width: 0.5,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: navigationShell.goBranch,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home_rounded),
              label: l10n.navHome,
            ),
            NavigationDestination(
              icon: const Icon(Icons.explore_outlined),
              selectedIcon: const Icon(Icons.explore),
              label: l10n.navDiscover,
            ),
            NavigationDestination(
              icon: const Icon(Icons.route_outlined),
              selectedIcon: const Icon(Icons.route),
              label: l10n.navPlan,
            ),
            NavigationDestination(
              icon: const Icon(Icons.auto_awesome_outlined),
              selectedIcon: const Icon(Icons.auto_awesome),
              label: l10n.navCreate,
            ),
            NavigationDestination(
              icon: const Icon(Icons.person_outline_rounded),
              selectedIcon: const Icon(Icons.person_rounded),
              label: l10n.navProfile,
            ),
          ],
        ),
      ),
      floatingActionButton: navigationShell.currentIndex == 2
          ? FloatingActionButton.extended(
              onPressed: () {
                if (selected.isNotEmpty) {
                  generateRoute(ref);
                }
              },
              backgroundColor: AppColors.gold,
              foregroundColor: AppColors.white,
              elevation: 2,
              icon: const Icon(Icons.auto_awesome, size: 20),
              label: Text(
                selected.isEmpty
                    ? l10n.selectSpotsFirst
                    : l10n.generateRoute,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
