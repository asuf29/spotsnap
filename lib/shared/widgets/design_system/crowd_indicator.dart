import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../features/spot/domain/entities/spot.dart';
import '../../extensions/vibe_tag_extension.dart';
import '../../../core/theme/app_spacing.dart';

class CrowdIndicator extends StatelessWidget {
  const CrowdIndicator({
    super.key,
    required this.level,
    this.showLabel = true,
    this.compact = false,
  });

  final CrowdLevel level;
  final bool showLabel;
  final bool compact;

  int get _filledBars => switch (level) {
        CrowdLevel.low => 1,
        CrowdLevel.medium => 2,
        CrowdLevel.high => 3,
      };

  Color get _activeColor => switch (level) {
        CrowdLevel.low => AppColors.crowdLow,
        CrowdLevel.medium => AppColors.crowdMedium,
        CrowdLevel.high => AppColors.crowdHigh,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final inactive = isDark
        ? AppColors.darkDivider
        : AppColors.beige;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(3, (i) {
          final filled = i < _filledBars;
          return Container(
            width: compact ? 4 : 5,
            height: compact ? (10 + i * 2.0) : (12 + i * 2.0),
            margin: EdgeInsets.only(right: i < 2 ? 3 : 0),
            decoration: BoxDecoration(
              color: filled ? _activeColor : inactive,
              borderRadius: BorderRadius.circular(2),
            ),
          );
        }),
        if (showLabel) ...[
          SizedBox(width: compact ? 6 : AppSpacing.xs),
          Text(
            level.label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: compact ? 11 : 12,
              color: isDark ? AppColors.textMutedOnDark : AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
