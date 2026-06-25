import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/providers/create_context_provider.dart';
import '../../../discover/presentation/providers/discover_providers.dart';
import '../../../spot/domain/entities/spot.dart';
import '../../data/repositories/pose_repository_impl.dart';
import '../../domain/entities/pose_suggestion.dart';
import '../../domain/repositories/pose_repository.dart';

final poseRepositoryProvider = Provider<PoseRepository>(
  (ref) => const PoseRepositoryImpl(),
);

final selectedPoseVibeProvider = StateProvider<VibeTag?>((ref) => null);

final poseSuggestionsProvider = Provider<List<PoseSuggestion>>((ref) {
  final vibe = ref.watch(selectedPoseVibeProvider);
  final spotId = ref.watch(createContextSpotIdProvider);
  SpotCategory? category;
  if (spotId != null) {
    category = ref.watch(spotByIdProvider(spotId))?.category;
  }
  return ref.watch(poseRepositoryProvider).getPoses(
        vibe: vibe,
        spotCategory: category,
      );
});
