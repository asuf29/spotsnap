import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
enum GoldBadgeSize { small, medium }

class GoldBadge extends StatelessWidget {
  const GoldBadge({
    super.key,
    required this.label,
    this.icon = Icons.workspace_premium_outlined,
    this.size = GoldBadgeSize.medium,
    this.compact = false,
  });

  final String label;
  final IconData icon;
  final GoldBadgeSize size;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSmall = size == GoldBadgeSize.small;
    final fontSize = isSmall ? 10.0 : 12.0;
    final iconSize = isSmall ? 12.0 : 14.0;
    final padding = compact
        ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
        : EdgeInsets.symmetric(
            horizontal: isSmall ? 10 : 12,
            vertical: isSmall ? 5 : 7,
          );

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isSmall ? 10 : 12),
        gradient: const LinearGradient(
          colors: [AppColors.gold, AppColors.goldDark],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: iconSize, color: AppColors.white),
            if (!compact) ...[
              const SizedBox(width: 4),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontSize: fontSize,
                  color: AppColors.white,
                  letterSpacing: 0.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Premium pill for cards and headers.
class SnapSpotPlusBadge extends StatelessWidget {
  const SnapSpotPlusBadge({super.key, this.size = GoldBadgeSize.medium});

  final GoldBadgeSize size;

  @override
  Widget build(BuildContext context) {
    return GoldBadge(
      label: 'SnapSpot+',
      size: size,
      icon: Icons.auto_awesome,
    );
  }
}
