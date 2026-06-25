import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/design_system/design_system.dart';
import '../../../social/presentation/providers/social_providers.dart';
import '../providers/discover_providers.dart';

class CityHubHeader extends ConsumerWidget {
  const CityHubHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final city = ref.watch(selectedCityProvider);
    if (city == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final isSaved = ref.watch(isCitySavedProvider(city.id));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: back on left, bookmark on right
          Row(
            children: [
              GestureDetector(
                onTap: () => clearSelectedCity(ref),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkCard
                        : AppColors.beigeLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark
                          ? AppColors.darkDivider
                          : AppColors.beige,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 14,
                        color: isDark
                            ? AppColors.textOnDark
                            : AppColors.textPrimary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        l10n.back,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => toggleSavedCity(ref, city.id),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isSaved
                        ? AppColors.gold.withValues(alpha: 0.15)
                        : (isDark
                            ? AppColors.darkCard
                            : AppColors.beigeLight),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSaved
                          ? AppColors.gold.withValues(alpha: 0.4)
                          : (isDark
                              ? AppColors.darkDivider
                              : AppColors.beige),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    isSaved
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    size: 18,
                    color: isSaved
                        ? AppColors.gold
                        : (isDark
                            ? AppColors.textMutedOnDark
                            : AppColors.textSecondary),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),

          // City name + meta
          Text(
            city.name,
            style: theme.textTheme.headlineMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            '${city.country} · ${city.spotCount} spots',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            city.tagline,
            style: theme.textTheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSpacing.sm - 4),
          const GoldenHourChip(
            label: 'Golden hour · 18:42',
            subtitle: 'Best shoot window today',
            compact: true,
          ),
        ],
      ),
    );
  }
}
