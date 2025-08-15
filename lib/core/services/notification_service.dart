import 'dart:io';
import 'package:injectable/injectable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

@singleton
class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  
  static const String _channelId = 'duelo_metabolico_channel';
  static const String _channelName = 'Duelo Metabólico';
  static const String _channelDescription = 'Notificações do Duelo Metabólico';

  /// Initialize notification service
  Future<void> initialize() async {
    await _initializeFirebaseMessaging();
    await _initializeLocalNotifications();
    await _setupForegroundNotificationHandling();
  }

  /// Initialize Firebase Cloud Messaging
  Future<void> _initializeFirebaseMessaging() async {
    // Request permission for notifications
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission for notifications');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission for notifications');
    } else {
      print('User declined or has not accepted permission for notifications');
    }

    // Get the token
    final token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');

    // Handle token refresh
    _firebaseMessaging.onTokenRefresh.listen((token) {
      print('FCM Token refreshed: $token');
      // Send token to your server
    });
  }

  /// Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    // Android initialization
    const androidInitialization = AndroidInitializationSettings('@mipmap/ic_launcher');
    
    // iOS initialization
    const iosInitialization = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const initializationSettings = InitializationSettings(
      android: androidInitialization,
      iOS: iosInitialization,
      macOS: iosInitialization,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create notification channel for Android
    if (Platform.isAndroid) {
      await _createNotificationChannel();
    }
  }

  /// Create Android notification channel
  Future<void> _createNotificationChannel() async {
    const androidNotificationChannel = AndroidNotificationChannel(
      _channelId,
      _channelName,
      description: _channelDescription,
      importance: Importance.high,
      enableVibration: true,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification_sound'),
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  /// Setup foreground notification handling
  Future<void> _setupForegroundNotificationHandling() async {
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });

    // Handle background message taps
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationTap(message.data);
    });

    // Handle app launch from terminated state
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationTap(initialMessage.data);
    }
  }

  /// Show local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      enableVibration: true,
      playSound: true,
      icon: '@mipmap/ic_launcher',
      color: Color(0xFF6C5CE7),
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
    );

    const iosNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
      payload: message.data.toString(),
    );
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    if (response.payload != null) {
      // Parse payload and navigate accordingly
      print('Notification tapped with payload: ${response.payload}');
    }
  }

  /// Handle notification tap from Firebase
  void _handleNotificationTap(Map<String, dynamic> data) {
    final type = data['type'] as String?;
    final targetId = data['target_id'] as String?;

    switch (type) {
      case 'duel_invitation':
        // Navigate to duel screen
        break;
      case 'duel_result':
        // Navigate to results screen
        break;
      case 'achievement_unlocked':
        // Navigate to achievements screen
        break;
      case 'leaderboard_update':
        // Navigate to leaderboard screen
        break;
      default:
        // Navigate to home screen
        break;
    }
  }

  /// Schedule local notification
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosNotificationDetails = DarwinNotificationDetails();

    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await _localNotifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  /// Show immediate local notification
  Future<void> showLocalNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    NotificationPriority priority = NotificationPriority.high,
  }) async {
    final androidNotificationDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: _getAndroidImportance(priority),
      priority: _getAndroidPriority(priority),
      enableVibration: true,
      playSound: true,
    );

    const iosNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await _localNotifications.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  /// Cancel notification
  Future<void> cancelNotification(int id) async {
    await _localNotifications.cancel(id);
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _localNotifications.cancelAll();
  }

  /// Get FCM token
  Future<String?> getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }

  /// Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  /// Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  /// Helper methods
  Importance _getAndroidImportance(NotificationPriority priority) {
    switch (priority) {
      case NotificationPriority.low:
        return Importance.low;
      case NotificationPriority.normal:
        return Importance.defaultImportance;
      case NotificationPriority.high:
        return Importance.high;
      case NotificationPriority.max:
        return Importance.max;
    }
  }

  Priority _getAndroidPriority(NotificationPriority priority) {
    switch (priority) {
      case NotificationPriority.low:
        return Priority.low;
      case NotificationPriority.normal:
        return Priority.defaultPriority;
      case NotificationPriority.high:
        return Priority.high;
      case NotificationPriority.max:
        return Priority.max;
    }
  }
}

enum NotificationPriority { low, normal, high, max }

/// Notification types for the app
class NotificationTypes {
  static const String duelInvitation = 'duel_invitation';
  static const String duelResult = 'duel_result';
  static const String achievementUnlocked = 'achievement_unlocked';
  static const String leaderboardUpdate = 'leaderboard_update';
  static const String dailyChallenge = 'daily_challenge';
  static const String weeklyReport = 'weekly_report';
}

/// Pre-defined notification IDs
class NotificationIds {
  static const int duelInvitation = 1;
  static const int duelResult = 2;
  static const int achievementUnlocked = 3;
  static const int leaderboardUpdate = 4;
  static const int dailyChallenge = 5;
  static const int weeklyReport = 6;
}