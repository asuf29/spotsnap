import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends StateNotifier<Locale?> {
  LocaleController(this._prefs, Locale? initial) : super(initial);

  final SharedPreferences _prefs;
  static const _key = 'snapspot_locale_v1';

  static Locale? loadFromPrefs(SharedPreferences prefs) {
    final code = prefs.getString(_key);
    if (code == null) return null;
    return Locale(code);
  }

  Future<void> setLocale(Locale? locale) async {
    state = locale;
    if (locale == null) {
      await _prefs.remove(_key);
    } else {
      await _prefs.setString(_key, locale.languageCode);
    }
  }
}

final localeProvider = StateNotifierProvider<LocaleController, Locale?>(
  (ref) => throw UnimplementedError('Override in AppBootstrap'),
);
