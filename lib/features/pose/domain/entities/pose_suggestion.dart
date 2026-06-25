import '../../../spot/domain/entities/spot.dart';

class PoseSuggestion {
  const PoseSuggestion({
    required this.id,
    required this.title,
    required this.vibe,
    required this.cameraAngle,
    required this.handPose,
    required this.faceDirection,
    required this.lensRecommendation,
    this.tip,
    this.suitableCategories = const [],
  });

  final String id;
  final String title;
  final VibeTag vibe;
  final String cameraAngle;
  final String handPose;
  final String faceDirection;
  final String lensRecommendation;
  final String? tip;
  final List<SpotCategory> suitableCategories;

  String get referenceImageUrl =>
      'https://picsum.photos/seed/pose-$id/400/500';
}
