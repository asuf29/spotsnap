import '../../../spot/domain/entities/spot.dart';
import '../../domain/entities/pose_suggestion.dart';
import '../../domain/repositories/pose_repository.dart';
import '../datasources/pose_seed_data.dart';

class PoseRepositoryImpl implements PoseRepository {
  const PoseRepositoryImpl();

  @override
  List<VibeTag> getVibes() => VibeTag.values;

  @override
  List<PoseSuggestion> getPoses({VibeTag? vibe, SpotCategory? spotCategory}) {
    var list = PoseSeedData.poses;
    if (vibe != null) {
      list = list.where((p) => p.vibe == vibe).toList();
    }
    if (spotCategory != null) {
      list = list
          .where(
            (p) =>
                p.suitableCategories.isEmpty ||
                p.suitableCategories.contains(spotCategory),
          )
          .toList();
    }
    return list;
  }
}
