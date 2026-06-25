import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entities/auth_session.dart';

class AuthPersistence {
  AuthPersistence(this._prefs);

  static const _keyOnboarding = 'snapspot_onboarding_done_v1';
  static const _keyAuthenticated = 'snapspot_authenticated_v1';
  static const _keyGuest = 'snapspot_guest_v1';
  static const _keyEmail = 'snapspot_email_v1';

  final SharedPreferences _prefs;

  Future<AuthSession> load() async {
    return AuthSession(
      hasCompletedOnboarding: _prefs.getBool(_keyOnboarding) ?? false,
      isAuthenticated: _prefs.getBool(_keyAuthenticated) ?? false,
      isGuest: _prefs.getBool(_keyGuest) ?? true,
      email: _prefs.getString(_keyEmail),
    );
  }

  Future<void> save(AuthSession session) async {
    await _prefs.setBool(_keyOnboarding, session.hasCompletedOnboarding);
    await _prefs.setBool(_keyAuthenticated, session.isAuthenticated);
    await _prefs.setBool(_keyGuest, session.isGuest);
    if (session.email != null) {
      await _prefs.setString(_keyEmail, session.email!);
    } else {
      await _prefs.remove(_keyEmail);
    }
  }

  Future<void> clear() async {
    await _prefs.remove(_keyOnboarding);
    await _prefs.remove(_keyAuthenticated);
    await _prefs.remove(_keyGuest);
    await _prefs.remove(_keyEmail);
  }
}
