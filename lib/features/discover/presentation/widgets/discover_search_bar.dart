import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../providers/discover_providers.dart';

class DiscoverSearchBar extends ConsumerWidget {
  const DiscoverSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(discoverSearchQueryProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm,
      ),
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        borderRadius: AppSpacing.radiusLg,
        child: TextField(
          onChanged: (value) {
            ref.read(discoverSearchQueryProvider.notifier).state = value;
            if (value.trim().isNotEmpty &&
                ref.read(selectedCityIdProvider) != null) {
              ref.read(selectedCityIdProvider.notifier).state = null;
              ref.read(selectedCategoryProvider.notifier).state = null;
            }
          },
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.searchCityHint,
            prefixIcon: const Icon(Icons.search, size: 22),
            suffixIcon: query.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () {
                      ref.read(discoverSearchQueryProvider.notifier).state = '';
                    },
                  )
                : null,
            border: InputBorder.none,
            filled: false,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }
}
