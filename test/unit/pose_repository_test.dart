import 'package:flutter_test/flutter_test.dart';
import 'package:snapspot/features/pose/data/repositories/pose_repository_impl.dart';
import 'package:snapspot/features/spot/domain/entities/spot.dart';

void main() {
  late PoseRepositoryImpl repo;

  setUp(() {
    repo = const PoseRepositoryImpl();
  });

  group('PoseRepositoryImpl', () {
    test('getPoses returns all when no filters', () {
      final poses = repo.getPoses();
      expect(poses, isNotEmpty);
      expect(poses.length, greaterThanOrEqualTo(8));
    });

    test('getPoses filters by vibe', () {
      final viralPoses = repo.getPoses(vibe: VibeTag.viral);
      for (final pose in viralPoses) {
        expect(pose.vibe, VibeTag.viral);
      }
    });

    test('getPoses filters by spot category', () {
      final cafePoses = repo.getPoses(spotCategory: SpotCategory.cafe);
      for (final pose in cafePoses) {
        final matchesCategory = pose.suitableCategories.isEmpty ||
            pose.suitableCategories.contains(SpotCategory.cafe);
        expect(matchesCategory, true);
      }
    });

    test('getPoses filters by both vibe and category', () {
      final poses = repo.getPoses(
        vibe: VibeTag.cleanGirl,
        spotCategory: SpotCategory.cafe,
      );
      for (final pose in poses) {
        expect(pose.vibe, VibeTag.cleanGirl);
      }
    });

    test('getVibes returns all vibe tags', () {
      final vibes = repo.getVibes();
      expect(vibes, VibeTag.values);
    });

    test('every pose has a reference image URL', () {
      final poses = repo.getPoses();
      for (final pose in poses) {
        expect(pose.referenceImageUrl, contains('picsum.photos'));
        expect(pose.referenceImageUrl, contains(pose.id));
      }
    });
  });
}
