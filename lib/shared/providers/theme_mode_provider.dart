import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeController extends StateNotifier<ThemeMode> {
  ThemeModeController(this._prefs, ThemeMode initial) : super(initial);

  final SharedPreferences _prefs;

  Future<void> setMode(ThemeMode mode) async {
    state = mode;
    await _prefs.setString('snapspot_theme_v1', mode.name);
  }
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeController, ThemeMode>(
  (ref) => throw UnimplementedError('Override in AppBootstrap.load()'),
);
