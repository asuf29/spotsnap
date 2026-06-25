import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/providers/shell_navigation_provider.dart';
import '../providers/discover_providers.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/city_hub_header.dart';
import '../widgets/discover_grid_view.dart';
import '../widgets/discover_landing_view.dart';
import '../widgets/discover_reels_view.dart';
import '../widgets/discover_search_bar.dart';
import '../widgets/discover_view_toggle.dart';

class DiscoverPage extends ConsumerWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cityId = ref.watch(selectedCityIdProvider);
    final spots = ref.watch(discoverSpotsProvider);
    final viewMode = ref.watch(discoverViewModeProvider);
    final hasCity = cityId != null;

    return HeroMode(
      enabled: shellHeroesEnabled(context, ShellBranch.discover),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const DiscoverSearchBar(),
              if (hasCity) ...[
                const CityHubHeader(),
                const SizedBox(height: AppSpacing.sm),
                const CategoryFilterBar(),
                const DiscoverViewToggle(),
              ],
              Expanded(
                child: hasCity
                    ? (viewMode == DiscoverViewMode.reels
                        ? DiscoverReelsView(spots: spots)
                        : DiscoverGridView(spots: spots))
                    : const DiscoverLandingView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
