import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/providers/create_context_provider.dart';
import '../../../route/presentation/providers/route_providers.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../features/discover/presentation/providers/discover_providers.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/extensions/vibe_tag_extension.dart';
import '../../../../shared/widgets/spot_image_gallery.dart';
import '../../../social/presentation/widgets/add_to_moodboard_sheet.dart';
import '../../../social/presentation/widgets/favorite_button.dart';
import '../../../../shared/widgets/design_system/design_system.dart';

class SpotDetailPage extends ConsumerStatefulWidget {
  const SpotDetailPage({super.key, required this.spotId});

  final String spotId;

  @override
  ConsumerState<SpotDetailPage> createState() => _SpotDetailPageState();
}

class _SpotDetailPageState extends ConsumerState<SpotDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(createContextSpotIdProvider.notifier).state = widget.spotId;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final spot = ref.watch(spotByIdProvider(widget.spotId));
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    if (spot == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(child: Text(l10n.spotNotFound)),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            actions: [
              FavoriteButton(spotId: widget.spotId),
              IconButton(
                icon: const Icon(Icons.grid_view_outlined),
                onPressed: () =>
                    showAddToMoodboardSheet(context, ref, widget.spotId),
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () => _shareSpot(context, spot.name),
              ),
              Padding(
                padding: const EdgeInsets.only(right: AppSpacing.xs),
                child: Center(
                  child: SnapSpotPlusBadge(size: GoldBadgeSize.small),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsetsDirectional.only(
                start: 56,
                bottom: 16,
                end: 16,
              ),
              title: Text(
                spot.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.white,
                  shadows: const [Shadow(blurRadius: 8, color: Colors.black54)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  SpotImageGallery(
                    spotId: spot.id,
                    imageUrls: spot.imageUrls,
                    heroTag: 'spot-image-${spot.id}',
                  ),
                  if (spot.bestTimeLabel != null)
                    Positioned(
                      top: MediaQuery.paddingOf(context).top + 56,
                      left: AppSpacing.md,
                      child: GoldenHourChip(label: spot.bestTimeLabel!),
                    ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CrowdIndicator(level: spot.crowd),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: spot.vibes
                        .map(
                          (v) => VibeChip(
                            label: v.label,
                            variant: v.chipVariant,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(l10n.overview, style: theme.textTheme.titleLarge),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    _descriptionFor(widget.spotId),
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () =>
                              context.push(AppRoutes.poseAssistant),
                          child: Text(l10n.pose),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () =>
                              context.push(AppRoutes.outfitPlanner),
                          child: Text(l10n.outfit),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () =>
                          context.push(AppRoutes.photoAssistant),
                      icon: const Icon(Icons.auto_awesome_outlined, size: 18),
                      label: Text(l10n.photoAssistant),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        toggleRouteSpot(ref, spot.id);
                        context.go(AppRoutes.plan);
                      },
                      child: Text(l10n.addToRoute),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _shareSpot(BuildContext context, String name) {
    final l10n = AppLocalizations.of(context)!;
    final text = l10n.shareSpotTitle(name);
    Share.share(text);
  }

  String _descriptionFor(String id) {
    return switch (id) {
      'paris-eiffel' =>
        'Panoramic Trocadéro view — perfect for sunset reels and wide-angle travel shots.',
      'istanbul-galata' =>
        'Iconic tower framing — shoot from the street below or café terraces nearby.',
      'tokyo-shibuya' =>
        'World-famous crossing — best from Starbucks overlook or street level at night.',
      'santorini-oia' =>
        'Classic blue dome composition — arrive 45 min before sunset for a front-row spot.',
      _ => 'Curated Instagrammable location with AI pose and outfit suggestions.',
    };
  }
}
