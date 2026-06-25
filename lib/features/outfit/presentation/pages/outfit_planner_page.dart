import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/outfit_providers.dart';
import '../widgets/outfit_concept_card.dart';

class OutfitPlannerPage extends ConsumerWidget {
  const OutfitPlannerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final concepts = ref.watch(outfitConceptsProvider);
    final selectedId = ref.watch(selectedOutfitConceptIdProvider);
    final wardrobe = ref.watch(wardrobeProvider);
    final selectedWardrobe = ref.watch(selectedWardrobeIdsProvider);
    final suggestion = ref.watch(outfitSuggestionProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.outfitPlanner)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(l10n.photoConcepts, style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          ...concepts.map(
            (c) => OutfitConceptCard(
              concept: c,
              selected: selectedId == c.id,
              onTap: () {
                ref.read(selectedOutfitConceptIdProvider.notifier).state = c.id;
              },
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.yourWardrobe, style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: wardrobe.map((item) {
              final isSelected = selectedWardrobe.contains(item.id);
              return FilterChip(
                label: Text(item.name),
                selected: isSelected,
                avatar: CircleAvatar(
                  backgroundColor: item.color,
                  radius: 10,
                ),
                onSelected: (_) {
                  final next = Set<String>.from(selectedWardrobe);
                  if (isSelected) {
                    next.remove(item.id);
                  } else {
                    next.add(item.id);
                  }
                  ref.read(selectedWardrobeIdsProvider.notifier).state = next;
                },
              );
            }).toList(),
          ),
          if (selectedId != null && suggestion.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.lg),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                border: Border.all(color: AppColors.gold.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome, color: AppColors.gold, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(l10n.aiOutfitSuggestion, style: theme.textTheme.titleMedium),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ...suggestion.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Icon(Icons.check_circle_outline,
                                size: 16, color: AppColors.gold),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(item, style: theme.textTheme.bodyMedium),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
