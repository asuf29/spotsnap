import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            l10n.createTitle,
            style: theme.textTheme.headlineLarge,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(l10n.createSubtitle, style: theme.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.lg),
          _CreateToolCard(
            icon: Icons.face_retouching_natural_outlined,
            title: l10n.poseAssistant,
            subtitle: l10n.poseAssistantSubtitle,
            accentColor: AppColors.pastelBlush,
            iconColor: const Color(0xFFD4728A),
            onTap: () => context.push(AppRoutes.poseAssistant),
          ),
          const SizedBox(height: AppSpacing.sm - 4),
          _CreateToolCard(
            icon: Icons.checkroom_outlined,
            title: l10n.outfitPlanner,
            subtitle: l10n.outfitPlannerSubtitle,
            accentColor: AppColors.pastelSage,
            iconColor: const Color(0xFF5BA87F),
            onTap: () => context.push(AppRoutes.outfitPlanner),
          ),
          const SizedBox(height: AppSpacing.sm - 4),
          _CreateToolCard(
            icon: Icons.photo_camera_outlined,
            title: l10n.photoAssistant,
            subtitle: l10n.photoAssistantSubtitle,
            accentColor: AppColors.pastelSky,
            iconColor: const Color(0xFF4A8AC4),
            onTap: () => context.push(AppRoutes.photoAssistant),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _CreateToolCard extends StatelessWidget {
  const _CreateToolCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.iconColor,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accentColor;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          color: isDark ? AppColors.darkCard : AppColors.white,
          border: Border.all(
            color: isDark ? AppColors.darkDivider : AppColors.beige,
            width: 1,
          ),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark
                    ? iconColor.withValues(alpha: 0.18)
                    : accentColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: isDark ? iconColor.withValues(alpha: 0.9) : iconColor,
                size: 26,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(subtitle, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: isDark
                  ? AppColors.textMutedOnDark
                  : AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
