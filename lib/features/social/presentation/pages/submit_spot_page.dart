import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../discover/presentation/providers/discover_providers.dart';
import '../../domain/entities/spot_submission.dart';
import '../providers/social_providers.dart';

class SubmitSpotPage extends ConsumerStatefulWidget {
  const SubmitSpotPage({super.key});

  @override
  ConsumerState<SubmitSpotPage> createState() => _SubmitSpotPageState();
}

class _SubmitSpotPageState extends ConsumerState<SubmitSpotPage> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  String? _cityId;

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cities = ref.watch(discoverRepositoryProvider).getTrendingCities();
    final submissions = ref.watch(submissionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Share a Spot')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            'Submit a hidden gem for the community. Spots are reviewed before going live.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Spot name',
              hintText: 'e.g. Secret rooftop in Le Marais',
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          DropdownButtonFormField<String>(
            initialValue: _cityId,
            decoration: const InputDecoration(labelText: 'City'),
            items: cities
                .map(
                  (c) => DropdownMenuItem(value: c.id, child: Text(c.name)),
                )
                .toList(),
            onChanged: (v) => setState(() => _cityId = v),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _descController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Why is it Instagrammable?',
              hintText: 'Best time, vibe, tips…',
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton(
            onPressed: _cityId == null || _nameController.text.trim().isEmpty
                ? null
                : _submit,
            child: const Text('Submit for review'),
          ),
          if (submissions.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xl),
            Text('Your submissions', style: theme.textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            ...submissions.map(
              (s) => ListTile(
                title: Text(s.name),
                subtitle: Text('${statusLabel(s.status)} · ${s.cityId}'),
                leading: const Icon(Icons.hourglass_top_outlined),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String statusLabel(SubmissionStatus status) => switch (status) {
        SubmissionStatus.pending => 'Pending review',
        SubmissionStatus.approved => 'Approved',
        SubmissionStatus.rejected => 'Rejected',
      };

  void _submit() {
    ref.read(socialRepositoryProvider.notifier).submitSpot(
          name: _nameController.text.trim(),
          cityId: _cityId!,
          description: _descController.text.trim(),
        );
    _nameController.clear();
    _descController.clear();
    setState(() => _cityId = null);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Spot submitted — thanks!')),
    );
  }
}
