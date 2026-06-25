import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../features/subscription/presentation/providers/subscription_providers.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/design_system/design_system.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../social/presentation/providers/social_providers.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final profile = ref.watch(socialProfileProvider);
    final favorites = ref.watch(favoriteSpotIdsProvider).length;
    final bucket = ref.watch(bucketListCityIdsProvider).length;
    final boards = ref.watch(moodboardsProvider).length;
    final saved = ref.watch(savedCityIdsProvider).length;
    final isPremium = ref.watch(isPremiumProvider);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.navProfile,
                    style: theme.textTheme.headlineLarge,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings_outlined,
                    color: isDark
                        ? AppColors.textMutedOnDark
                        : AppColors.textSecondary,
                  ),
                  tooltip: l10n.settings,
                  onPressed: () => context.push(AppRoutes.settings),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            // Profile header
            Row(
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.gold.withValues(alpha: 0.15),
                    border: Border.all(
                      color: AppColors.gold.withValues(alpha: 0.35),
                      width: 2,
                    ),
                  ),
                  child: const Icon(Icons.person_rounded,
                      size: 36, color: AppColors.gold),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.displayName,
                        style: theme.textTheme.headlineMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text('@${profile.username}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: isDark
                                ? AppColors.textMutedOnDark
                                : AppColors.textSecondary,
                          )),
                      if (profile.instagramHandle != null) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.camera_alt_outlined,
                                size: 13, color: AppColors.gold),
                            const SizedBox(width: 4),
                            Text(
                              '@${profile.instagramHandle}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: AppColors.gold,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit_outlined,
                      size: 20,
                      color: isDark
                          ? AppColors.textMutedOnDark
                          : AppColors.textSecondary),
                  onPressed: () => _editInstagram(
                      context, ref, profile.instagramHandle),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // Stat chips
            Row(
              children: [
                _StatChip(label: l10n.favorites, value: '$favorites'),
                const SizedBox(width: AppSpacing.xs),
                _StatChip(label: 'Bucket', value: '$bucket'),
                const SizedBox(width: AppSpacing.xs),
                _StatChip(label: l10n.moodboards, value: '$boards'),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Premium banner
            GestureDetector(
              onTap: () => context.push(AppRoutes.premium),
              child: GlassContainer(
                child: Row(
                  children: [
                    const SnapSpotPlusBadge(),
                    const SizedBox(width: AppSpacing.sm - 4),
                    Expanded(
                      child: isPremium.when(
                        data: (premium) => Text(
                          premium ? l10n.premiumActive : l10n.unlockPremium,
                          style: theme.textTheme.bodySmall,
                        ),
                        loading: () => Text(l10n.unlockPremium,
                            style: theme.textTheme.bodySmall),
                        error: (e, st) => Text(l10n.unlockPremium,
                            style: theme.textTheme.bodySmall),
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: isDark
                          ? AppColors.textMutedOnDark
                          : AppColors.textSecondary,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Collections section
            _SectionHeader(title: l10n.collections),
            const SizedBox(height: AppSpacing.xs),
            _ProfileNavTile(
              icon: Icons.favorite_border_rounded,
              title: l10n.favorites,
              subtitle: l10n.spotsSaved(favorites),
              onTap: () => context.push(AppRoutes.favorites),
            ),
            _ProfileNavTile(
              icon: Icons.flight_takeoff_rounded,
              title: l10n.bucketList,
              subtitle: l10n.destinationsCount(bucket),
              onTap: () => context.push(AppRoutes.bucketList),
            ),
            _ProfileNavTile(
              icon: Icons.bookmark_border_rounded,
              title: l10n.savedCities,
              subtitle: l10n.citiesCount(saved),
              onTap: () => context.push(AppRoutes.savedCities),
            ),
            _ProfileNavTile(
              icon: Icons.grid_view_rounded,
              title: l10n.moodboards,
              subtitle: l10n.boardsCount(boards),
              onTap: () => context.push(AppRoutes.moodboards),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Community section
            _SectionHeader(title: l10n.community),
            const SizedBox(height: AppSpacing.xs),
            _ProfileNavTile(
              icon: Icons.add_location_alt_outlined,
              title: l10n.shareSpot,
              subtitle: l10n.submitHiddenGems,
              onTap: () => context.push(AppRoutes.submitSpot),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }

  Future<void> _editInstagram(
    BuildContext context,
    WidgetRef ref,
    String? current,
  ) async {
    final controller = TextEditingController(text: current);
    final handle = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Instagram handle'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            prefixText: '@',
            hintText: 'username',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              ref
                  .read(socialRepositoryProvider.notifier)
                  .updateInstagramHandle(null);
              Navigator.pop(ctx, '');
            },
            child: const Text('Remove'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (handle != null && handle.isNotEmpty) {
      ref
          .read(socialRepositoryProvider.notifier)
          .updateInstagramHandle(handle);
    }
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.sm - 4),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.beigeLight,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(
            color: isDark ? AppColors.darkDivider : AppColors.beige,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppColors.gold,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(fontSize: 11),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileNavTile extends StatelessWidget {
  const _ProfileNavTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: isDark ? AppColors.textMutedOnDark : AppColors.textSecondary,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(
        Icons.chevron_right_rounded,
        size: 20,
        color: isDark ? AppColors.textMutedOnDark : AppColors.textTertiary,
      ),
      onTap: onTap,
    );
  }
}
