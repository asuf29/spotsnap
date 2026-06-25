import 'package:flutter_test/flutter_test.dart';
import 'package:snapspot/core/config/app_config.dart';

void main() {
  group('AppConfig', () {
    test('defaults have empty strings', () {
      expect(AppConfig.apiBaseUrl, isEmpty);
      expect(AppConfig.mapboxAccessToken, isEmpty);
      expect(AppConfig.revenueCatApiKey, isEmpty);
    });

    test('useRemoteApi is false by default', () {
      expect(AppConfig.useRemoteApi, false);
    });

    test('useMapbox is false by default', () {
      expect(AppConfig.useMapbox, false);
    });

    test('useRevenueCat is false by default', () {
      expect(AppConfig.useRevenueCat, false);
    });

    test('useFirebase is false by default', () {
      expect(AppConfig.useFirebase, false);
    });
  });
}
