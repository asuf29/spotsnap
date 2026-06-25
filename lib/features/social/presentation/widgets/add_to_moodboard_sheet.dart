import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../providers/social_providers.dart';

void showAddToMoodboardSheet(BuildContext context, WidgetRef ref, String spotId) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    builder: (ctx) => _AddToMoodboardSheet(spotId: spotId),
  );
}

class _AddToMoodboardSheet extends ConsumerWidget {
  const _AddToMoodboardSheet({required this.spotId});

  final String spotId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final boards = ref.watch(moodboardsProvider);
    final repo = ref.read(socialRepositoryProvider.notifier);

    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        top: AppSpacing.md,
        bottom: MediaQuery.paddingOf(context).bottom + AppSpacing.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Add to moodboard', style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.md),
          ...boards.map(
            (b) => ListTile(
              leading: const Icon(Icons.grid_view_outlined),
              title: Text(b.title),
              subtitle: Text('${b.itemCount} spots'),
              onTap: () {
                repo.addSpotToMoodboard(b.id, spotId);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added to ${b.title}')),
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Create new moodboard'),
            onTap: () async {
              Navigator.pop(context);
              final title = await _promptNewBoard(context);
              if (title != null && title.isNotEmpty && context.mounted) {
                final board = repo.createMoodboard(title);
                repo.addSpotToMoodboard(board.id, spotId);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Created "$title" and added spot')),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Future<String?> _promptNewBoard(BuildContext context) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New moodboard'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Board name'),
          autofocus: true,
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
  }
}
