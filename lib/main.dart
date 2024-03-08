import 'dart:async';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

///TODO: 1.

///Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  log('A Background message : ${message.messageId}');
  log('A Background message Data : ${message.data}');
  log('A Background message routeName : ${message.data['routeName']}');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'high_importance_channel',
  description: 'Repore',
  importance: Importance.high,
  playSound: true,
);

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  // await dotenv.load(fileName: '.env');
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initializeCore(environment: Environment.dev);
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(const ProviderScope(child: MyApp()));
  // runZonedGuarded(() async {
  //   await SentryFlutter.init(
  //     (options) {
  //       options.dsn =
  //           'https://4f9421eef62f4f5ab317f2e805cf9d9a@o4505065621422080.ingest.sentry.io/4505076160790528';
  //     },
  //   );

  //   runApp(const ProviderScope(child: MyApp()));
  // }, (exception, stackTrace) async {
  //   await Sentry.captureException(exception, stackTrace: stackTrace);
  //   log('Sentry excepton $exception');
  //   log('Sentry stackTrace $stackTrace');
  // });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  actionOnMessage(BuildContext context, RemoteMessage message) {
    final route = message.data['routeName'];
    //TODO: Uncomment and implement deeplinking routing
    // if (route == "ticket") {
    //   //TODO: Remove refremce, ask him to return subject
    //   context.pushNamed(
    //     AppRoute.viewTicketScreen.name,
    //     queryParams: {
    //       'id': message.data['ticketID'],
    //       'ref': '',
    //       'title': '',
    //     },
    //   );
    // }
  }

  void requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (Platform.isIOS) {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        log('User granted ios notification  permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        log('User granted provisional ios notification permission');
      } else {
        log('User declined or has not accepted ios notification permission');
      }
    }
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () async {
      FlutterNativeSplash.remove();
    });
    LocalNotificationService.initialize(context);
    requestNotificationPermission();
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        actionOnMessage(context, message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
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
      }
    });

    ///Foregroundnotification, when the app is currently runing
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification!;
      log('A Foreground message routeName : ${message.data['routeName']}');
      // AndroidNotification android = message.notification!.android!;
      if (message.notification != null) {
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
      }

      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: goRouter,
          debugShowCheckedModeBanner: false,
          title: 'Repore Agent Staging',
          theme: ThemeData(
            textTheme: GoogleFonts.interTextTheme(
              Theme.of(context).textTheme,
            ),
            appBarTheme: const AppBarTheme(
              // iconTheme: IconThemeData(color: Colors.black),
              // color: Colors.deepPurpleAccent,
              foregroundColor: AppColors.primaryColor,
              systemOverlayStyle: SystemUiOverlayStyle(
                //<-- SEE HERE
                // Status bar color
                statusBarColor: AppColors.primaryColor,
                statusBarIconBrightness: Brightness.light,
                statusBarBrightness: Brightness.light,
              ),
            ),

            // bottomSheetTheme: BottomSheetThemeData(
            //   modalBackgroundColor: AppColors.primaryTextColor.withOpacity(0.7),
            // ),
            // textTheme: GoogleFonts.outfitTextTheme(
            //   Theme.of(context).textTheme,
            // ),
          ),

          // home: const OnBoardingScreen(),
        );
      },
    );
  }
}
