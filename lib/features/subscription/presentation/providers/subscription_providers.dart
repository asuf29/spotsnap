import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/subscription_service.dart';

final subscriptionServiceProvider = Provider<SubscriptionService>(
  (ref) => throw UnimplementedError('Override in AppBootstrap'),
);

final isPremiumProvider = FutureProvider<bool>((ref) async {
  final service = ref.watch(subscriptionServiceProvider);
  return service.isPremium();
});

final purchasePremiumProvider = Provider<Future<bool> Function()>((ref) {
  return () => ref.read(subscriptionServiceProvider).purchaseDefaultPackage();
});

final restorePurchasesProvider = Provider<Future<bool> Function()>((ref) {
  return () => ref.read(subscriptionServiceProvider).restorePurchases();
});
