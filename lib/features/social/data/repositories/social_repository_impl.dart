import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/moodboard.dart';
import '../../domain/entities/social_profile.dart';
import '../../domain/entities/spot_submission.dart';
import '../../domain/repositories/social_repository.dart';
import '../social_persistence.dart';
import '../social_state.dart';

class SocialRepositoryImpl extends StateNotifier<SocialState>
    implements SocialRepository {
  SocialRepositoryImpl(this._persistence, SocialState initial)
      : super(initial);

  final SocialPersistence _persistence;

  void _commit(SocialState next) {
    state = next;
    _persistence.save(next);
  }

  @override
  SocialProfile getProfile() => state.profile;

  @override
  void updateInstagramHandle(String? handle) {
    _commit(
      state.copyWith(
        profile: state.profile.copyWith(instagramHandle: handle),
      ),
    );
  }

  @override
  Set<String> getFavoriteSpotIds() => state.favoriteSpotIds;

  @override
  bool isFavorite(String spotId) => state.favoriteSpotIds.contains(spotId);

  @override
  void toggleFavorite(String spotId) {
    final next = Set<String>.from(state.favoriteSpotIds);
    if (next.contains(spotId)) {
      next.remove(spotId);
    } else {
      next.add(spotId);
    }
    _commit(state.copyWith(favoriteSpotIds: next));
  }

  @override
  Set<String> getBucketListCityIds() => state.bucketListCityIds;

  @override
  void toggleBucketListCity(String cityId) {
    final next = Set<String>.from(state.bucketListCityIds);
    if (next.contains(cityId)) {
      next.remove(cityId);
    } else {
      next.add(cityId);
    }
    _commit(state.copyWith(bucketListCityIds: next));
  }

  @override
  Set<String> getSavedCityIds() => state.savedCityIds;

  @override
  void toggleSavedCity(String cityId) {
    final next = Set<String>.from(state.savedCityIds);
    if (next.contains(cityId)) {
      next.remove(cityId);
    } else {
      next.add(cityId);
    }
    _commit(state.copyWith(savedCityIds: next));
  }

  @override
  List<Moodboard> getMoodboards() => state.moodboards;

  @override
  Moodboard? getMoodboard(String id) {
    try {
      return state.moodboards.firstWhere((m) => m.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Moodboard createMoodboard(String title) {
    final board = Moodboard(
      id: 'mb-${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      createdAt: DateTime.now(),
      items: const [],
    );
    _commit(state.copyWith(moodboards: [...state.moodboards, board]));
    return board;
  }

  @override
  void addSpotToMoodboard(String moodboardId, String spotId, {String? note}) {
    final boards = state.moodboards.map((board) {
      if (board.id != moodboardId) return board;
      if (board.items.any((i) => i.spotId == spotId)) return board;
      return Moodboard(
        id: board.id,
        title: board.title,
        coverSpotId: board.coverSpotId ?? spotId,
        createdAt: board.createdAt,
        items: [
          ...board.items,
          MoodboardItem(spotId: spotId, note: note, addedAt: DateTime.now()),
        ],
      );
    }).toList();
    _commit(state.copyWith(moodboards: boards));
  }

  @override
  void removeMoodboardItem(String moodboardId, String spotId) {
    final boards = state.moodboards.map((board) {
      if (board.id != moodboardId) return board;
      final items = board.items.where((i) => i.spotId != spotId).toList();
      return Moodboard(
        id: board.id,
        title: board.title,
        coverSpotId: items.isEmpty ? null : board.coverSpotId,
        createdAt: board.createdAt,
        items: items,
      );
    }).toList();
    _commit(state.copyWith(moodboards: boards));
  }

  @override
  List<SpotSubmission> getSubmissions() => state.submissions;

  @override
  SpotSubmission submitSpot({
    required String name,
    required String cityId,
    required String description,
  }) {
    final submission = SpotSubmission(
      id: 'sub-${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      cityId: cityId,
      description: description,
      submittedAt: DateTime.now(),
    );
    _commit(
      state.copyWith(submissions: [submission, ...state.submissions]),
    );
    return submission;
  }
}
