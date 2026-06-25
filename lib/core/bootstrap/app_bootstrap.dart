import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/auth_persistence.dart';
import '../../features/auth/data/firebase_auth_repository.dart';
import '../../features/auth/presentation/providers/auth_providers.dart';
import '../../features/discover/data/discover_bootstrap.dart';
import '../../features/discover/presentation/providers/discover_providers.dart';
import '../../features/notifications/presentation/providers/notification_providers.dart';
import '../../features/social/data/repositories/social_repository_impl.dart';
import '../../features/social/data/social_persistence.dart';
import '../../features/social/presentation/providers/social_providers.dart';
import '../../features/subscription/data/subscription_service.dart';
import '../../features/subscription/presentation/providers/subscription_providers.dart';
import '../firebase/firebase_bootstrap.dart';
import '../services/notification_service.dart';
import '../../shared/providers/locale_provider.dart';
import '../../shared/providers/theme_mode_provider.dart';

class AppBootstrapResult {
  const AppBootstrapResult({required this.overrides});

  final List<Override> overrides;
}

class AppBootstrap {
  AppBootstrap._();

  static Future<AppBootstrapResult> load() async {
    final prefs = await SharedPreferences.getInstance();

    await FirebaseBootstrap.initialize();

    final subscription = SubscriptionService(prefs);
    await subscription.initialize();

    final notifications = NotificationService(prefs);
    await notifications.initialize();

    final socialPersistence = SocialPersistence(prefs);
    final socialState =
        await socialPersistence.load() ?? SocialPersistence.defaultState();

    final themeName = prefs.getString('snapspot_theme_v1');
    final initialTheme = _parseThemeMode(themeName);
    final initialLocale = LocaleController.loadFromPrefs(prefs);

    final discoverRepo = await DiscoverBootstrap.create();
    final authPersistence = AuthPersistence(prefs);
    final authSession = await authPersistence.load();
    final firebaseAuth = FirebaseAuthRepository();

    return AppBootstrapResult(
      overrides: [
        subscriptionServiceProvider.overrideWithValue(subscription),
        notificationServiceProvider.overrideWithValue(notifications),
        authSessionProvider.overrideWith(
          (ref) => AuthNotifier(
            authPersistence,
            authSession,
            firebase: firebaseAuth,
          ),
        ),
        socialRepositoryProvider.overrideWith(
          (ref) => SocialRepositoryImpl(socialPersistence, socialState),
        ),
        discoverRepositoryProvider.overrideWithValue(discoverRepo),
        themeModeProvider.overrideWith(
          (ref) => ThemeModeController(prefs, initialTheme),
        ),
        localeProvider.overrideWith(
          (ref) => LocaleController(prefs, initialLocale),
        ),
      ],
    );
  }

  static ThemeMode _parseThemeMode(String? name) {
    return switch (name) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }
}
