import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../discover/presentation/providers/discover_providers.dart';
import '../../data/repositories/social_repository_impl.dart';
import '../providers/social_providers.dart';

class MoodboardsPage extends ConsumerWidget {
  const MoodboardsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final boards = ref.watch(moodboardsProvider);
    final repo = ref.read(socialRepositoryProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.moodboards),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _createBoard(context, repo),
          ),
        ],
      ),
      body: boards.isEmpty
          ? EmptyState(
              icon: Icons.grid_view_outlined,
              title: l10n.moodboards,
              subtitle: 'Create a moodboard to collect shoot inspiration.',
              actionLabel: 'New board',
              onAction: () => _createBoard(context, repo),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: boards.length,
              itemBuilder: (context, index) {
                final board = boards[index];
                final coverSpot = board.coverSpotId != null
                    ? ref.watch(spotByIdProvider(board.coverSpotId!))
                    : null;
                final isDark = Theme.of(context).brightness == Brightness.dark;

                return GestureDetector(
                  onTap: () =>
                      context.push(AppRoutes.moodboardDetailPath(board.id)),
                  child: Card(
                    margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                    clipBehavior: Clip.antiAlias,
                    child: SizedBox(
                      height: 120,
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isDark
                                    ? [
                                        AppColors.gold.withValues(alpha: 0.15),
                                        AppColors.darkCard,
                                      ]
                                    : [
                                        AppColors.pastelBlush,
                                        AppColors.beige,
                                      ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '${board.itemCount}',
                                style: theme.textTheme.headlineMedium
                                    ?.copyWith(color: AppColors.gold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(AppSpacing.md),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    board.title,
                                    style: theme.textTheme.titleLarge,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    coverSpot?.name ??
                                        '${board.itemCount} spots',
                                    style: theme.textTheme.bodySmall,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: AppSpacing.md),
                            child: Icon(Icons.chevron_right),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 300.ms, delay: (60 * index).ms)
                    .slideY(
                      begin: 0.08,
                      end: 0,
                      duration: 300.ms,
                      delay: (60 * index).ms,
                      curve: Curves.easeOut,
                    );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createBoard(context, repo),
        icon: const Icon(Icons.add),
        label: const Text('New board'),
      ),
    );
  }

  Future<void> _createBoard(
    BuildContext context,
    SocialRepositoryImpl repo,
  ) async {
    final controller = TextEditingController();
    final title = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New moodboard'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'e.g. Paris Dream'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('Create'),
          ),
        ],
      ),
    );
    if (title != null && title.isNotEmpty && context.mounted) {
      repo.createMoodboard(title);
    }
  }
}
