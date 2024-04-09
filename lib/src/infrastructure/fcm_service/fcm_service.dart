import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:music_app/main.dart';
import 'package:music_app/src/presentation/core/theme/colors.dart';

import 'fcm_navigation_service.dart';

class FcmService {
  /// Create a [AndroidNotificationChannel] for heads up notifications
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
      sound: RawResourceAndroidNotificationSound("notify"),
      playSound: true);

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize() async {
    getPermissions();
    _initializeBackgroundMsg();
    _initializeLocalNotification();
    _handleMesgOnTerminatedState();
    _foregroundNotification();
    getFirebaseTokken();
  }

  getPermissions() async {
    try {
      if (Platform.isIOS) {
        await _fcm.requestPermission();
      }
      await _fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: true,
        sound: true,
      );
    } catch (_) {}
  }

  Future<String> getFirebaseTokken() async {
    String token = "";
    try {
      token = (await _fcm.getToken())!;
      log("token $token");
    } catch (_) {}
    return token;
  }

  _initializeBackgroundMsg() async {
    // Set the background messaging handler early on, as a named top-level function
    try {
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    } catch (_) {}
  }

  _initializeLocalNotification() async {
    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  _foregroundNotification() async {
    try {
      FirebaseMessaging.onBackgroundMessage((message) async {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null && !kIsWeb) {
          var android = const AndroidInitializationSettings('launcher_icon');
          var ios = const DarwinInitializationSettings(
              defaultPresentSound: true, requestSoundPermission: true);
          var platform = InitializationSettings(android: android, iOS: ios);
          await _flutterLocalNotificationsPlugin.initialize(platform,
              onDidReceiveNotificationResponse: (details) {
            _onSelectLocalNotification(details.payload);
          }
              // onSelectNotification: _onSelectLocalNotification
              );
          await _flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'launcher_icon',
                priority: Priority.high,
                color: AppColors.blackColor,
                importance: Importance.high,
              ),
            ),
            payload: message.data["payload"],
          );
        }
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null && !kIsWeb) {
          var android = const AndroidInitializationSettings('launcher_icon');
          var ios = const DarwinInitializationSettings(
              defaultPresentSound: true, requestSoundPermission: true);
          //IOSInitializationSettings(defaultPresentSound: true, requestSoundPermission: true);
          var platform = InitializationSettings(android: android, iOS: ios);
          await _flutterLocalNotificationsPlugin.initialize(platform,
              onDidReceiveNotificationResponse: (details) {
            _onSelectLocalNotification(details.payload);
          }
              // onSelectNotification: _onSelectLocalNotification
              );
          await _flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'launcher_icon',
                priority: Priority.high,
                color: AppColors.blackColor,
                importance: Importance.high,
              ),
            ),
            payload: message.data["payload"],
          );
        }
      });
    } catch (_) {}

    try {
      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {
        FcmNavigationService(page: message.data["payload"]).navigateToPage();
      });
    } catch (_) {}
  }

  _handleMesgOnTerminatedState() async {
    _fcm.getInitialMessage().then((RemoteMessage? message) async {
      if (message != null) {
        log("${message.data["payload"]}");
        FcmNavigationService(page: message.data["payload"]).navigateToPage();
      }
    });
  }

  Future<dynamic> _onSelectLocalNotification(String? page) {
    return FcmNavigationService(page: page).navigateToPage();
  }
}
