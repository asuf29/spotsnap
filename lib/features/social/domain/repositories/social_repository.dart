import '../entities/moodboard.dart';
import '../entities/social_profile.dart';
import '../entities/spot_submission.dart';

abstract class SocialRepository {
  SocialProfile getProfile();

  void updateInstagramHandle(String? handle);

  Set<String> getFavoriteSpotIds();

  bool isFavorite(String spotId);

  void toggleFavorite(String spotId);

  Set<String> getBucketListCityIds();

  void toggleBucketListCity(String cityId);

  Set<String> getSavedCityIds();

  void toggleSavedCity(String cityId);

  List<Moodboard> getMoodboards();

  Moodboard? getMoodboard(String id);

  Moodboard createMoodboard(String title);

  void addSpotToMoodboard(String moodboardId, String spotId, {String? note});

  void removeMoodboardItem(String moodboardId, String spotId);

  List<SpotSubmission> getSubmissions();

  SpotSubmission submitSpot({
    required String name,
    required String cityId,
    required String description,
  });
}
