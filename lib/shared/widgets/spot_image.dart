import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'design_system/shimmer_box.dart';

class SpotImage extends StatelessWidget {
  const SpotImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.borderRadius = AppSpacing.radiusMd,
    this.aspectRatio,
  });

  final String? imageUrl;
  final BoxFit fit;
  final double borderRadius;
  final double? aspectRatio;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget child;
    if (imageUrl == null || imageUrl!.isEmpty) {
      child = _placeholder(isDark);
    } else {
      child = CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: fit,
        placeholder: (context, url) => const ShimmerBox(
          borderRadius: AppSpacing.radiusMd,
        ),
        errorWidget: (context, url, error) => _placeholder(isDark),
      );
    }

    child = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: child,
    );

    if (aspectRatio != null) {
      return AspectRatio(aspectRatio: aspectRatio!, child: child);
    }
    return child;
  }

  Widget _placeholder(bool isDark) {
    return Container(
      color: isDark ? AppColors.darkCard : AppColors.beige.withValues(alpha: 0.5),
      child: const Center(
        child: Icon(Icons.photo_camera_outlined, color: AppColors.gold, size: 36),
      ),
    );
  }
}
