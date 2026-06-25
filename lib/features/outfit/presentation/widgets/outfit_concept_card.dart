import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/outfit_concept.dart';
import 'color_harmony_row.dart';

class OutfitConceptCard extends StatelessWidget {
  const OutfitConceptCard({
    super.key,
    required this.concept,
    required this.selected,
    required this.onTap,
  });

  final OutfitConcept concept;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: selected ? AppColors.gold : Colors.transparent,
            width: 2,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(concept.name, style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(concept.description, style: theme.textTheme.bodySmall),
            const SizedBox(height: AppSpacing.sm),
            ColorHarmonyRow(colors: concept.palette),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                const Icon(Icons.cloud_outlined, size: 16, color: AppColors.gold),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    concept.weatherNote,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
