import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:repore_agent/lib.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const channelId = "123";

  static void initialize(BuildContext context) {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: IOSInitializationSettings(),
    );

    tz.initializeTimeZones();

    ///TODO: check flutter local notification dic
//TODO: Ios setting must be set
    ///TODO: Unhandled Exception: Invalid argument(s): iOS settings must be set when targeting iOS platform.
    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? route) async {
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        final route = message.data['routeName'];
        if (route == "ticket") {
          //TODO: Remove refremce, ask him to return subject
          //TODO: Uncomment and implement deeplinking routing
          // context.pushNamed(
          //   AppRoute.viewTicketScreen.name,
          //   queryParams: {
          //     'id': message.data['ticketID'],
          //     'ref': '',
          //     'title': '',
          //   },
          // );
        }
        LocalNotificationService.display(message);
      });
    });
  }

  static void display(RemoteMessage message) async {
    final FirebaseMessaging messaging;
    messaging = FirebaseMessaging.instance;
    final NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      try {
        final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        final RemoteNotification? notify = message.notification;
        final AndroidNotification? android = message.notification?.android;
        final AppleNotification? ios = message.notification?.apple;

        const NotificationDetails notificationDetails = NotificationDetails(
            android: AndroidNotificationDetails(
          "Repore",
          "Repore",
          importance: Importance.high,
          priority: Priority.high,
        ));
        const NotificationDetails iosNotification = NotificationDetails(
          iOS: IOSNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            badgeNumber: 1,
          ),
        );
        if (notify != null && android != null) {
          await _notificationsPlugin.show(
            id,
            message.notification!.title,
            message.notification!.body,
            notificationDetails,
            payload: message.data["route"],
          );
        }
        if (notify != null && ios != null) {
          _notificationsPlugin.show(
            notify.hashCode,
            notify.title,
            notify.body,
            iosNotification,
            payload: message.data["route"],
          );
        }
      } on Exception {
        log('error on exception');
      }
    }
  }

  void cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  // Future<bool> _wasApplicationLaunchedFromNotification() async {
  //   final NotificationAppLaunchDetails? notificationAppLaunchDetails =
  //       await _notificationsPlugin.getNotificationAppLaunchDetails();

  //   return notificationAppLaunchDetails!.didNotificationLaunchApp;
  // }
}
