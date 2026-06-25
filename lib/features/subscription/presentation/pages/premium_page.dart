import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/design_system/design_system.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../providers/subscription_providers.dart';

class PremiumPage extends ConsumerWidget {
  const PremiumPage({super.key});

  static const _features = [
    ('Unlimited AI routes', Icons.route),
    ('All pose & outfit styles', Icons.face_retouching_natural),
    ('AI photo assistant', Icons.auto_awesome),
    ('Hidden gems & rooftops', Icons.diamond_outlined),
    ('Offline routes & export', Icons.download_outlined),
    ('Golden hour alerts', Icons.notifications_active_outlined),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final premiumAsync = ref.watch(isPremiumProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                children: [
                  const Center(child: SnapSpotPlusBadge()),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    l10n.premiumTitle,
                    style: theme.textTheme.displayMedium,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.premiumSubtitle,
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  GlassContainer(
                    child: Column(
                      children: _features
                          .map(
                            (f) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Icon(f.$2, color: AppColors.gold, size: 22),
                                  const SizedBox(width: AppSpacing.sm),
                                  Expanded(
                                    child: Text(
                                      f.$1,
                                      style: theme.textTheme.titleMedium,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.check_circle,
                                    color: AppColors.gold,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const _PlanCard(
                    title: 'Yearly',
                    price: '₺999 / year',
                    badge: 'Best value',
                    highlighted: true,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const _PlanCard(
                    title: 'Monthly',
                    price: '₺149 / month',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  premiumAsync.when(
                    data: (isPremium) {
                      if (isPremium) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: Text(
                            l10n.premiumActive,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: AppColors.gold,
                            ),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (e, st) => const SizedBox.shrink(),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _purchase(context, ref),
                      child: Text(l10n.startFreeTrial),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  TextButton(
                    onPressed: () => _restore(context, ref),
                    child: Text(l10n.restorePurchases),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Cancel anytime. Restore purchases on device.',
                    style: theme.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _purchase(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final ok = await ref.read(purchasePremiumProvider)();
    ref.invalidate(isPremiumProvider);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? l10n.demoPurchaseSuccess : l10n.demoPurchaseFailed),
      ),
    );
    if (ok) Navigator.of(context).pop();
  }

  Future<void> _restore(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context)!;
    final ok = await ref.read(restorePurchasesProvider)();
    ref.invalidate(isPremiumProvider);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok ? l10n.premiumActive : l10n.demoPurchaseFailed),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.price,
    this.badge,
    this.highlighted = false,
  });

  final String title;
  final String price;
  final String? badge;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        border: Border.all(
          color: highlighted
              ? AppColors.gold
              : (isDark ? AppColors.darkDivider : AppColors.beige),
          width: highlighted ? 2 : 1,
        ),
        color: highlighted
            ? AppColors.gold.withValues(alpha: 0.08)
            : theme.cardColor,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (badge != null) ...[
                  GoldBadge(label: badge!, size: GoldBadgeSize.small),
                  const SizedBox(height: 8),
                ],
                Text(title, style: theme.textTheme.titleLarge),
                Text(price, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
          Icon(
            highlighted ? Icons.radio_button_checked : Icons.radio_button_off,
            color: AppColors.gold,
          ),
        ],
      ),
    );
  }
}
