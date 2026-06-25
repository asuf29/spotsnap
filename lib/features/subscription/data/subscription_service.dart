import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/config/app_config.dart';

/// RevenueCat when configured; otherwise local demo premium flag.
class SubscriptionService {
  SubscriptionService(this._prefs);

  static const _demoPremiumKey = 'snapspot_demo_premium_v1';

  final SharedPreferences _prefs;
  bool _configured = false;

  Future<void> initialize() async {
    if (!AppConfig.useRevenueCat) return;
    try {
      await Purchases.setLogLevel(kDebugMode ? LogLevel.debug : LogLevel.warn);
      await Purchases.configure(
        PurchasesConfiguration(AppConfig.revenueCatApiKey),
      );
      _configured = true;
    } catch (e) {
      debugPrint('RevenueCat init failed: $e');
      _configured = false;
    }
  }

  Future<bool> isPremium() async {
    if (_configured) {
      try {
        final info = await Purchases.getCustomerInfo();
        return info.entitlements.active.containsKey('premium') ||
            info.entitlements.active.isNotEmpty;
      } catch (_) {
        return _prefs.getBool(_demoPremiumKey) ?? false;
      }
    }
    return _prefs.getBool(_demoPremiumKey) ?? false;
  }

  Future<bool> purchaseDefaultPackage() async {
    if (_configured) {
      try {
        final offerings = await Purchases.getOfferings();
        final package = offerings.current?.annual ?? offerings.current?.monthly;
        if (package == null) return _setDemoPremium(true);
        final info = await Purchases.purchasePackage(package);
        return info.entitlements.active.isNotEmpty;
      } catch (e) {
        debugPrint('Purchase failed: $e');
        return false;
      }
    }
    return _setDemoPremium(true);
  }

  Future<bool> restorePurchases() async {
    if (_configured) {
      try {
        final info = await Purchases.restorePurchases();
        return info.entitlements.active.isNotEmpty;
      } catch (_) {
        return false;
      }
    }
    return _prefs.getBool(_demoPremiumKey) ?? false;
  }

  Future<bool> _setDemoPremium(bool value) async {
    await _prefs.setBool(_demoPremiumKey, value);
    return value;
  }
}
