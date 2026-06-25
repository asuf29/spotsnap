/// Runtime config via `--dart-define`.
class AppConfig {
  AppConfig._();

  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: '',
  );

  static const mapboxAccessToken = String.fromEnvironment(
    'MAPBOX_TOKEN',
    defaultValue: '',
  );

  static const revenueCatApiKey = String.fromEnvironment(
    'REVENUECAT_API_KEY',
    defaultValue: '',
  );

  static const useFirebase = bool.fromEnvironment(
    'USE_FIREBASE',
    defaultValue: false,
  );

  static bool get useRemoteApi => apiBaseUrl.isNotEmpty;

  static bool get useMapbox => mapboxAccessToken.isNotEmpty;

  static bool get useRevenueCat => revenueCatApiKey.isNotEmpty;
}
