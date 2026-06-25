import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../providers/social_providers.dart';

class FavoriteButton extends ConsumerWidget {
  const FavoriteButton({
    super.key,
    required this.spotId,
    this.iconSize = 24,
    this.color,
  });

  final String spotId;
  final double iconSize;
  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(isFavoriteProvider(spotId));
    final defaultColor = color ?? Theme.of(context).iconTheme.color;

    return IconButton(
      onPressed: () {
        toggleFavorite(ref, spotId);
        HapticFeedback.lightImpact();
      },
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        size: iconSize,
        color: isFavorite ? AppColors.gold : defaultColor,
      ),
    );
  }
}
