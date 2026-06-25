import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entities/moodboard.dart';
import '../domain/entities/social_profile.dart';
import 'social_state.dart';
import 'social_state_codec.dart';

class SocialPersistence {
  SocialPersistence(this._prefs);

  static const _keySocial = 'snapspot_social_v1';

  final SharedPreferences _prefs;

  static SocialState defaultState() => SocialState(
        profile: const SocialProfile(
          displayName: 'Guest',
          username: 'snapspot_user',
          bio: 'Shoot. Plan. Share.',
        ),
        moodboards: [
          Moodboard(
            id: 'mb-paris',
            title: 'Paris Dream',
            coverSpotId: 'paris-eiffel',
            createdAt: DateTime(2025, 3, 1),
            items: [
              MoodboardItem(
                spotId: 'paris-eiffel',
                addedAt: DateTime(2025, 3, 1),
              ),
              MoodboardItem(
                spotId: 'paris-marais',
                addedAt: DateTime(2025, 3, 2),
              ),
            ],
          ),
        ],
        favoriteSpotIds: {'paris-eiffel'},
        bucketListCityIds: {'tokyo'},
        savedCityIds: {'paris'},
      );

  Future<SocialState?> load() async {
    final raw = _prefs.getString(_keySocial);
    return SocialStateCodec.decode(raw);
  }

  Future<void> save(SocialState state) async {
    await _prefs.setString(_keySocial, SocialStateCodec.encode(state));
  }
}
