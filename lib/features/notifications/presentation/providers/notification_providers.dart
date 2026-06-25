import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/notification_service.dart';

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => throw UnimplementedError('Override in AppBootstrap'),
);

final notificationsEnabledProvider = Provider<bool>((ref) {
  return ref.watch(notificationServiceProvider).isEnabled;
});
