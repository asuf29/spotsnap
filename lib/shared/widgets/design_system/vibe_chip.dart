import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

enum VibeChipVariant {
  viral,
  oldMoney,
  cleanGirl,
  pinterest,
  travel,
  custom,
}

class VibeChip extends StatelessWidget {
  const VibeChip({
    super.key,
    required this.label,
    this.variant = VibeChipVariant.custom,
    this.selected = false,
    this.onTap,
  });

  final String label;
  final VibeChipVariant variant;
  final bool selected;
  final VoidCallback? onTap;

  Color get _lightBackground => switch (variant) {
        VibeChipVariant.viral => AppColors.pastelBlush,
        VibeChipVariant.oldMoney => AppColors.pastelAmber,
        VibeChipVariant.cleanGirl => AppColors.pastelSage,
        VibeChipVariant.pinterest => AppColors.pastelBlush,
        VibeChipVariant.travel => AppColors.pastelSky,
        VibeChipVariant.custom =>
          AppColors.beige.withValues(alpha: 0.8),
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bg = isDark
        ? (selected
            ? AppColors.gold.withValues(alpha: 0.28)
            : AppColors.darkCardElevated)
        : (selected
            ? AppColors.gold.withValues(alpha: 0.22)
            : _lightBackground);

    final textColor = selected
        ? AppColors.gold
        : (isDark ? AppColors.textOnDark : AppColors.textPrimary);

    final child = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm - 4,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected
              ? AppColors.gold.withValues(alpha: 0.7)
              : (isDark
                  ? AppColors.darkDivider
                  : Colors.transparent),
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Text(
        label.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          fontSize: 10,
          letterSpacing: 0.8,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    if (onTap == null) return child;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: child,
    );
  }
}
