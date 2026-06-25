import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/extensions/vibe_tag_extension.dart';
import '../../../../shared/providers/create_context_provider.dart';
import '../../../../shared/widgets/design_system/design_system.dart';
import '../../../discover/presentation/providers/discover_providers.dart';
import '../../../spot/domain/entities/spot.dart';
import '../providers/pose_providers.dart';
import '../widgets/pose_card.dart';

class PoseAssistantPage extends ConsumerWidget {
  const PoseAssistantPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final selectedVibe = ref.watch(selectedPoseVibeProvider);
    final poses = ref.watch(poseSuggestionsProvider);
    final spotId = ref.watch(createContextSpotIdProvider);
    final spot = spotId != null ? ref.watch(spotByIdProvider(spotId)) : null;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.poseAssistant)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (spot != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                0,
              ),
              child: Text(
                l10n.posesForSpot(spot.name),
                style: theme.textTheme.bodyMedium,
              ),
            ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              children: [
                _VibeFilterChip(
                  label: l10n.allVibes,
                  selected: selectedVibe == null,
                  onTap: () =>
                      ref.read(selectedPoseVibeProvider.notifier).state = null,
                ),
                ...VibeTag.values.map(
                  (v) => _VibeFilterChip(
                    label: v.label,
                    selected: selectedVibe == v,
                    onTap: () =>
                        ref.read(selectedPoseVibeProvider.notifier).state = v,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: poses.isEmpty
                ? Center(
                    child: Text(
                      l10n.noPosesFilter,
                      style: theme.textTheme.bodyMedium,
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: poses.length,
                    itemBuilder: (context, index) =>
                        PoseCard(pose: poses[index]),
                  ),
          ),
        ],
      ),
    );
  }
}

class _VibeFilterChip extends StatelessWidget {
  const _VibeFilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.xs),
      child: VibeChip(
        label: label,
        selected: selected,
        onTap: onTap,
        variant: VibeChipVariant.custom,
      ),
    );
  }
}
