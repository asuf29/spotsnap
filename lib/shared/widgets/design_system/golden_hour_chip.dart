import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class GoldenHourChip extends StatelessWidget {
  const GoldenHourChip({
    super.key,
    required this.label,
    this.subtitle,
    this.compact = false,
  });

  final String label;
  final String? subtitle;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? AppSpacing.sm - 4 : AppSpacing.sm,
        vertical: compact ? 5 : AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: isDark ? 0.22 : 0.16),
        borderRadius: BorderRadius.circular(compact ? 10 : 12),
        border: Border.all(
          color: AppColors.gold.withValues(alpha: isDark ? 0.5 : 0.45),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.wb_twilight_rounded,
            size: compact ? 12 : 15,
            color: AppColors.gold,
          ),
          const SizedBox(width: 5),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontSize: compact ? 11 : 12,
                    color: AppColors.goldDark,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
                ),
                if (subtitle != null && !compact) ...[
                  const SizedBox(height: 1),
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                      color: isDark
                          ? AppColors.textMutedOnDark
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
