import '../../features/spot/domain/entities/spot.dart';
import '../../shared/widgets/design_system/vibe_chip.dart';

extension VibeTagX on VibeTag {
  String get label => switch (this) {
        VibeTag.viral => 'Viral vibe',
        VibeTag.oldMoney => 'Old money',
        VibeTag.cleanGirl => 'Clean girl',
        VibeTag.pinterestGirl => 'Pinterest girl',
        VibeTag.travelInfluencer => 'Travel influencer',
      };

  VibeChipVariant get chipVariant => switch (this) {
        VibeTag.viral => VibeChipVariant.viral,
        VibeTag.oldMoney => VibeChipVariant.oldMoney,
        VibeTag.cleanGirl => VibeChipVariant.cleanGirl,
        VibeTag.pinterestGirl => VibeChipVariant.pinterest,
        VibeTag.travelInfluencer => VibeChipVariant.travel,
      };
}

extension CrowdLevelX on CrowdLevel {
  String get label => switch (this) {
        CrowdLevel.low => 'Low crowd',
        CrowdLevel.medium => 'Medium crowd',
        CrowdLevel.high => 'High crowd',
      };
}
