import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/extensions/vibe_tag_extension.dart';
import '../../../../shared/widgets/design_system/design_system.dart';
import '../../../../shared/widgets/spot_image.dart';
import '../../domain/entities/pose_suggestion.dart';

class PoseCard extends StatefulWidget {
  const PoseCard({super.key, required this.pose});

  final PoseSuggestion pose;

  @override
  State<PoseCard> createState() => _PoseCardState();
}

class _PoseCardState extends State<PoseCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pose = widget.pose;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: InkWell(
        onTap: () => setState(() => _expanded = !_expanded),
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(pose.title, style: theme.textTheme.titleMedium),
                  ),
                  VibeChip(
                    label: pose.vibe.label,
                    variant: pose.vibe.chipVariant,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              _PoseReferenceImage(url: pose.referenceImageUrl),
              if (_expanded) ...[
                const SizedBox(height: AppSpacing.md),
                _DetailRow(
                  icon: Icons.camera_alt_outlined,
                  label: 'Camera angle',
                  value: pose.cameraAngle,
                ),
                _DetailRow(
                  icon: Icons.back_hand_outlined,
                  label: 'Hand / arm',
                  value: pose.handPose,
                ),
                _DetailRow(
                  icon: Icons.face_retouching_natural_outlined,
                  label: 'Face direction',
                  value: pose.faceDirection,
                ),
                _DetailRow(
                  icon: Icons.lens_outlined,
                  label: 'Lens',
                  value: pose.lensRecommendation,
                ),
                if (pose.tip != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.gold.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.lightbulb_outline,
                            size: 18, color: AppColors.gold),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            pose.tip!,
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ] else ...[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Tap for camera, hands & lens details',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PoseReferenceImage extends StatelessWidget {
  const _PoseReferenceImage({required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: Stack(
          fit: StackFit.expand,
          children: [
            SpotImage(imageUrl: url, fit: BoxFit.cover, borderRadius: 0),
            Positioned(
              bottom: AppSpacing.sm,
              left: AppSpacing.sm,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person_outline,
                        size: 14, color: AppColors.white),
                    SizedBox(width: 4),
                    Text(
                      'Reference',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.gold),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: theme.textTheme.labelSmall),
                Text(value, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
