import '../domain/entities/moodboard.dart';
import '../domain/entities/social_profile.dart';
import '../domain/entities/spot_submission.dart';

class SocialState {
  const SocialState({
    required this.profile,
    this.favoriteSpotIds = const {},
    this.bucketListCityIds = const {},
    this.savedCityIds = const {},
    this.moodboards = const [],
    this.submissions = const [],
  });

  final SocialProfile profile;
  final Set<String> favoriteSpotIds;
  final Set<String> bucketListCityIds;
  final Set<String> savedCityIds;
  final List<Moodboard> moodboards;
  final List<SpotSubmission> submissions;

  SocialState copyWith({
    SocialProfile? profile,
    Set<String>? favoriteSpotIds,
    Set<String>? bucketListCityIds,
    Set<String>? savedCityIds,
    List<Moodboard>? moodboards,
    List<SpotSubmission>? submissions,
  }) {
    return SocialState(
      profile: profile ?? this.profile,
      favoriteSpotIds: favoriteSpotIds ?? this.favoriteSpotIds,
      bucketListCityIds: bucketListCityIds ?? this.bucketListCityIds,
      savedCityIds: savedCityIds ?? this.savedCityIds,
      moodboards: moodboards ?? this.moodboards,
      submissions: submissions ?? this.submissions,
    );
  }
}
