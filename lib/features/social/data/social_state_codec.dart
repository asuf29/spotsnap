import 'dart:convert';

import '../domain/entities/moodboard.dart';
import '../domain/entities/social_profile.dart';
import '../domain/entities/spot_submission.dart';
import 'social_state.dart';

class SocialStateCodec {
  SocialStateCodec._();

  static String encode(SocialState state) {
    return jsonEncode(_toMap(state));
  }

  static SocialState? decode(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return _fromMap(map);
    } catch (_) {
      return null;
    }
  }

  static Map<String, dynamic> _toMap(SocialState state) => {
        'profile': {
          'displayName': state.profile.displayName,
          'username': state.profile.username,
          'instagramHandle': state.profile.instagramHandle,
          'bio': state.profile.bio,
        },
        'favoriteSpotIds': state.favoriteSpotIds.toList(),
        'bucketListCityIds': state.bucketListCityIds.toList(),
        'savedCityIds': state.savedCityIds.toList(),
        'moodboards': state.moodboards.map(_moodboardToMap).toList(),
        'submissions': state.submissions.map(_submissionToMap).toList(),
      };

  static SocialState _fromMap(Map<String, dynamic> map) {
    final profileMap = map['profile'] as Map<String, dynamic>? ?? {};
    return SocialState(
      profile: SocialProfile(
        displayName: profileMap['displayName'] as String? ?? 'Guest',
        username: profileMap['username'] as String? ?? 'snapspot_user',
        instagramHandle: profileMap['instagramHandle'] as String?,
        bio: profileMap['bio'] as String?,
      ),
      favoriteSpotIds:
          (map['favoriteSpotIds'] as List<dynamic>? ?? []).cast<String>().toSet(),
      bucketListCityIds:
          (map['bucketListCityIds'] as List<dynamic>? ?? []).cast<String>().toSet(),
      savedCityIds:
          (map['savedCityIds'] as List<dynamic>? ?? []).cast<String>().toSet(),
      moodboards: (map['moodboards'] as List<dynamic>? ?? [])
          .map((e) => _moodboardFromMap(e as Map<String, dynamic>))
          .toList(),
      submissions: (map['submissions'] as List<dynamic>? ?? [])
          .map((e) => _submissionFromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  static Map<String, dynamic> _moodboardToMap(Moodboard b) => {
        'id': b.id,
        'title': b.title,
        'coverSpotId': b.coverSpotId,
        'createdAt': b.createdAt.toIso8601String(),
        'items': b.items
            .map(
              (i) => {
                'spotId': i.spotId,
                'note': i.note,
                'addedAt': i.addedAt.toIso8601String(),
              },
            )
            .toList(),
      };

  static Moodboard _moodboardFromMap(Map<String, dynamic> map) => Moodboard(
        id: map['id'] as String,
        title: map['title'] as String,
        coverSpotId: map['coverSpotId'] as String?,
        createdAt: DateTime.parse(map['createdAt'] as String),
        items: (map['items'] as List<dynamic>? ?? [])
            .map(
              (e) => MoodboardItem(
                spotId: (e as Map)['spotId'] as String,
                note: e['note'] as String?,
                addedAt: DateTime.parse(e['addedAt'] as String),
              ),
            )
            .toList(),
      );

  static Map<String, dynamic> _submissionToMap(SpotSubmission s) => {
        'id': s.id,
        'name': s.name,
        'cityId': s.cityId,
        'description': s.description,
        'submittedAt': s.submittedAt.toIso8601String(),
        'status': s.status.name,
      };

  static SpotSubmission _submissionFromMap(Map<String, dynamic> map) =>
      SpotSubmission(
        id: map['id'] as String,
        name: map['name'] as String,
        cityId: map['cityId'] as String,
        description: map['description'] as String? ?? '',
        submittedAt: DateTime.parse(map['submittedAt'] as String),
        status: SubmissionStatus.values.firstWhere(
          (e) => e.name == map['status'],
          orElse: () => SubmissionStatus.pending,
        ),
      );
}
