import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/design_system/design_system.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../discover/presentation/providers/discover_providers.dart';
import '../../../spot/domain/entities/spot_extensions.dart';
import '../providers/social_providers.dart';

class MoodboardDetailPage extends ConsumerWidget {
  const MoodboardDetailPage({super.key, required this.moodboardId});

  final String moodboardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board = ref.watch(moodboardProvider(moodboardId));
    final repo = ref.read(socialRepositoryProvider.notifier);

    if (board == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Moodboard not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(board.title)),
      body: board.items.isEmpty
          ? const EmptyState(
              icon: Icons.photo_library_outlined,
              title: 'Empty board',
              subtitle: 'Add spots from Discover or Spot Detail.',
            )
          : GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.sm - 4,
                crossAxisSpacing: AppSpacing.sm - 4,
                childAspectRatio: AppSpacing.spotCardAspectRatio,
              ),
              itemCount: board.items.length,
              itemBuilder: (context, index) {
                final item = board.items[index];
                final spot = ref.watch(spotByIdProvider(item.spotId));
                if (spot == null) return const SizedBox.shrink();

                return Stack(
                  children: [
                    SpotPreviewCard(
                      title: spot.name,
                      imageUrl: spot.primaryImageUrl,
                      bestTimeLabel: spot.bestTimeLabel,
                      crowd: spot.crowd,
                      vibes: spot.vibes,
                      onTap: () =>
                          context.push(AppRoutes.spotDetailPath(spot.id)),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor:
                              Colors.black.withValues(alpha: 0.4),
                        ),
                        icon: const Icon(Icons.close, size: 18,
                            color: Colors.white),
                        onPressed: () =>
                            repo.removeMoodboardItem(board.id, spot.id),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
