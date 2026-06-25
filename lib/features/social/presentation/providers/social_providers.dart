import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/social_repository_impl.dart';
import '../../data/social_state.dart';
import '../../domain/entities/moodboard.dart';
import '../../domain/entities/social_profile.dart';
import '../../domain/entities/spot_submission.dart';
import '../../domain/repositories/social_repository.dart';

final socialRepositoryProvider =
    StateNotifierProvider<SocialRepositoryImpl, SocialState>(
  (ref) => throw UnimplementedError('Override via AppBootstrap.load()'),
);

SocialRepository _repo(WidgetRef ref) =>
    ref.read(socialRepositoryProvider.notifier);

final socialProfileProvider = Provider<SocialProfile>((ref) {
  return ref.watch(socialRepositoryProvider).profile;
});

final favoriteSpotIdsProvider = Provider<Set<String>>((ref) {
  return ref.watch(socialRepositoryProvider).favoriteSpotIds;
});

final isFavoriteProvider = Provider.family<bool, String>((ref, spotId) {
  return ref.watch(favoriteSpotIdsProvider).contains(spotId);
});

final bucketListCityIdsProvider = Provider<Set<String>>((ref) {
  return ref.watch(socialRepositoryProvider).bucketListCityIds;
});

final isInBucketListProvider = Provider.family<bool, String>((ref, cityId) {
  return ref.watch(bucketListCityIdsProvider).contains(cityId);
});

final savedCityIdsProvider = Provider<Set<String>>((ref) {
  return ref.watch(socialRepositoryProvider).savedCityIds;
});

final isCitySavedProvider = Provider.family<bool, String>((ref, cityId) {
  return ref.watch(savedCityIdsProvider).contains(cityId);
});

final moodboardsProvider = Provider<List<Moodboard>>((ref) {
  return ref.watch(socialRepositoryProvider).moodboards;
});

final moodboardProvider = Provider.family<Moodboard?, String>((ref, id) {
  return ref.read(socialRepositoryProvider.notifier).getMoodboard(id);
});

final submissionsProvider = Provider<List<SpotSubmission>>((ref) {
  return ref.watch(socialRepositoryProvider).submissions;
});

void toggleFavorite(WidgetRef ref, String spotId) =>
    _repo(ref).toggleFavorite(spotId);

void toggleBucketList(WidgetRef ref, String cityId) =>
    _repo(ref).toggleBucketListCity(cityId);

void toggleSavedCity(WidgetRef ref, String cityId) =>
    _repo(ref).toggleSavedCity(cityId);
