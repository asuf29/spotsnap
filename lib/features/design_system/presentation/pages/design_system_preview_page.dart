import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../features/spot/domain/entities/spot.dart';
import '../../../../shared/extensions/vibe_tag_extension.dart';
import '../../../../shared/providers/theme_mode_provider.dart';
import '../../../../shared/widgets/design_system/design_system.dart';
import '../../../../shared/widgets/glass_container.dart';

class DesignSystemPreviewPage extends ConsumerWidget {
  const DesignSystemPreviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System'),
        actions: [
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
            onPressed: () {
              ref.read(themeModeProvider.notifier).setMode(
                    themeMode == ThemeMode.dark
                        ? ThemeMode.light
                        : ThemeMode.dark,
                  );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _Section(
            title: 'Colors',
            child: Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                _ColorSwatch('Black', AppColors.black),
                _ColorSwatch('White', AppColors.white),
                _ColorSwatch('Beige', AppColors.beige),
                _ColorSwatch('Gold', AppColors.gold),
                _ColorSwatch('Blush', AppColors.pastelBlush),
                _ColorSwatch('Sage', AppColors.pastelSage),
                _ColorSwatch('Sky', AppColors.pastelSky),
              ],
            ),
          ),
          _Section(
            title: 'Typography',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Display', style: theme.textTheme.displayMedium),
                Text('Headline', style: theme.textTheme.headlineMedium),
                Text('Title', style: theme.textTheme.titleLarge),
                Text('Body', style: theme.textTheme.bodyLarge),
                Text('Caption', style: theme.textTheme.bodySmall),
                Text('LABEL TAG', style: theme.textTheme.labelSmall),
              ],
            ),
          ),
          _Section(
            title: 'Gold Badge',
            child: const Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SnapSpotPlusBadge(),
                SnapSpotPlusBadge(size: GoldBadgeSize.small),
                GoldBadge(label: 'Editor Pick', icon: Icons.star_outline),
              ],
            ),
          ),
          _Section(
            title: 'Vibe Chips',
            child: Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: VibeTag.values
                  .map(
                    (v) => VibeChip(
                      label: v.label,
                      variant: v.chipVariant,
                      selected: v == VibeTag.viral,
                    ),
                  )
                  .toList(),
            ),
          ),
          _Section(
            title: 'Golden Hour',
            child: const Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                GoldenHourChip(label: 'Sunset 19:42'),
                GoldenHourChip(
                  label: '18:42 – 19:30',
                  subtitle: 'Best shoot window',
                ),
                GoldenHourChip(label: 'Sunrise 06:12', compact: true),
              ],
            ),
          ),
          _Section(
            title: 'Crowd Indicator',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: CrowdLevel.values
                  .map((l) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                        child: CrowdIndicator(level: l),
                      ))
                  .toList(),
            ),
          ),
          _Section(
            title: 'Shimmer',
            child: const Column(
              children: [
                ShimmerBox(height: 80, borderRadius: AppSpacing.radiusMd),
                SizedBox(height: AppSpacing.sm),
                ShimmerBox(height: 160, borderRadius: AppSpacing.radiusLg),
              ],
            ),
          ),
          _Section(
            title: 'Glass Container',
            child: GlassContainer(
              child: Text(
                'Glassmorphism overlay with blur',
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ),
          _Section(
            title: 'Spot Preview Card',
            child: Row(
              children: [
                Expanded(
                  child: SpotPreviewCard(
                    title: 'Eiffel Viewpoint',
                    bestTimeLabel: 'Sunset 19:42',
                    crowd: CrowdLevel.medium,
                    vibes: const [VibeTag.viral],
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: SpotPreviewCard(
                    title: 'Hidden Rooftop',
                    bestTimeLabel: 'Golden 18:00',
                    crowd: CrowdLevel.low,
                    vibes: const [VibeTag.oldMoney],
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          _Section(
            title: 'Loading State',
            child: SpotPreviewCard(
              title: '',
              isLoading: true,
              onTap: () {},
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          child,
        ],
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch(this.name, this.color);

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            border: Border.all(
              color: AppColors.beige.withValues(alpha: 0.8),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(name, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
