import '../../../spot/domain/entities/spot.dart';
import '../entities/pose_suggestion.dart';

abstract class PoseRepository {
  List<PoseSuggestion> getPoses({VibeTag? vibe, SpotCategory? spotCategory});

  List<VibeTag> getVibes();
}
