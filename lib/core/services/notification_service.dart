import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'package:firebase_messaging/firebase_messaging.dart';

import '../config/app_config.dart';
import '../firebase/firebase_bootstrap.dart';

class NotificationService {
  NotificationService(this._prefs);

  static const _enabledKey = 'snapspot_notifications_v1';
  static const _goldenHourId = 1001;

  final SharedPreferences _prefs;
  final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tz_data.initializeTimeZones();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _local.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );

    if (AppConfig.useFirebase && FirebaseBootstrap.isReady) {
      await _initFirebaseMessaging();
    }
  }

  Future<void> _initFirebaseMessaging() async {
    try {
      final messaging = FirebaseMessaging.instance;
      await messaging.requestPermission();
      final token = await messaging.getToken();
      debugPrint('FCM token: $token');
    } catch (e) {
      debugPrint('FCM init skipped: $e');
    }
  }

  bool get isEnabled => _prefs.getBool(_enabledKey) ?? false;

  Future<bool> requestPermissionAndEnable() async {
    final granted = await _local
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(alert: true, badge: true, sound: true) ??
        true;

    await _prefs.setBool(_enabledKey, granted);
    if (granted) await scheduleGoldenHourReminder();
    return granted;
  }

  Future<void> disable() async {
    await _prefs.setBool(_enabledKey, false);
    await _local.cancel(_goldenHourId);
  }

  Future<void> scheduleGoldenHourReminder() async {
    if (!isEnabled) return;

    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      18,
      30,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    const android = AndroidNotificationDetails(
      'golden_hour',
      'Golden hour',
      channelDescription: 'Best time to shoot reminders',
      importance: Importance.high,
      priority: Priority.high,
    );
    const ios = DarwinNotificationDetails();
    const details = NotificationDetails(android: android, iOS: ios);

    await _local.zonedSchedule(
      _goldenHourId,
      'Golden hour soon',
      'Best shoot window · 18:42 – 19:30. Open SnapSpot to plan your route.',
      scheduled,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
