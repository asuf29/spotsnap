import 'package:flutter/material.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = 48,
    this.showTagline = false,
  });

  final double size;
  final bool showTagline;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.camera_alt_outlined,
              size: size * 0.6,
              color: AppColors.gold,
            ),
            const SizedBox(width: 8),
            Text(
              AppConstants.appName,
              style: theme.textTheme.displayMedium?.copyWith(
                fontSize: size * 0.55,
                fontWeight: FontWeight.w700,
                letterSpacing: -1,
              ),
            ),
          ],
        ),
        if (showTagline) ...[
          const SizedBox(height: 8),
          Text(
            'Shoot. Plan. Share.',
            style: theme.textTheme.bodySmall?.copyWith(
              letterSpacing: 2,
            ),
          ),
        ],
      ],
    );
  }
}
