import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/route_plan.dart';

class RouteTimeline extends StatelessWidget {
  const RouteTimeline({super.key, required this.plan});

  final RoutePlan plan;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: plan.stops.length,
      itemBuilder: (context, index) {
        final stop = plan.stops[index];
        final isLast = index == plan.stops.length - 1;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: AppColors.gold,
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        color: AppColors.gold.withValues(alpha: 0.3),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stop.arrivalLabel,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppColors.gold,
                        ),
                      ),
                      Text(stop.spot.name, style: theme.textTheme.titleMedium),
                      Text(
                        stop.spot.bestTimeLabel ?? '',
                        style: theme.textTheme.bodySmall,
                      ),
                      if (!isLast) ...[
                        const SizedBox(height: AppSpacing.xs),
                        Row(
                          children: [
                            Icon(
                              stop.modeToNext.icon,
                              size: 14,
                              color: isDark
                                  ? AppColors.textMutedOnDark
                                  : AppColors.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${stop.modeToNext.label} · ${stop.durationToNext.inMinutes} min',
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
