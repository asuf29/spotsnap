import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/extensions/spot_category_extension.dart';
import '../../../spot/domain/entities/spot.dart';
import '../providers/discover_providers.dart';

class CategoryFilterBar extends ConsumerWidget {
  const CategoryFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedCategoryProvider);

    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        children: [
          _FilterChip(
            label: 'All',
            icon: Icons.apps,
            selected: selected == null,
            onTap: () =>
                ref.read(selectedCategoryProvider.notifier).state = null,
          ),
          ...SpotCategory.values.map(
            (cat) => _FilterChip(
              label: cat.label,
              icon: cat.icon,
              selected: selected == cat,
              onTap: () =>
                  ref.read(selectedCategoryProvider.notifier).state = cat,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.xs),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: selected
                ? AppColors.gold.withValues(alpha: isDark ? 0.25 : 0.35)
                : (isDark ? AppColors.darkCard : AppColors.beige.withValues(alpha: 0.5)),
            borderRadius: BorderRadius.circular(20),
            border: selected
                ? Border.all(color: AppColors.gold, width: 1.5)
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: selected ? AppColors.goldDark : theme.iconTheme.color,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontSize: 13,
                  color: selected
                      ? AppColors.goldDark
                      : theme.textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
