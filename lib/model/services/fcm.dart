// // import 'dart:io';
// //
// // import 'package:firebase_messaging/firebase_messaging.dart';
// //
// // class PushNotificationService {
// //
// //   FirebaseMessaging messaging = FirebaseMessaging.instance;
// //
// //   //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
// //
// //
// //
// //
// //
// //   Future initialise() async {
// //     // if (Platform.isIOS) {
// //     //   _fcm.requestNotificationPermissions(IosNotificationSettings());
// //     // }
// //
// //     NotificationSettings settings = await messaging.requestPermission(
// //       alert: true,
// //       announcement: false,
// //       badge: true,
// //       carPlay: false,
// //       criticalAlert: false,
// //       provisional: false,
// //       sound: true,
// //     );
// //
// //     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
// //       print('Got a message whilst in the foreground!');
// //       print('Message data: ${message.data}');
// //
// //       if (message.notification != null) {
// //         print('Message also contained a notification: ${message.notification}');
// //       }
// //     });
// //
// //     var token = await messaging.getToken();
// //
// //
// //   }
// // }
//
//
// import 'package:Laybull/API/API.dart';
// import 'package:Laybull/Model/notification_model.dart';
// import 'package:Laybull/locale/app_localization.dart';
// import 'package:Laybull/providers/app_language_provider.dart';
// import 'package:Laybull/providers/currency_provider.dart';
// import 'package:Laybull/service_locator.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:Laybull/screens/splashscreen.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
// }
// /// Create a AndroidNotificationChannel for heads up notifications
// AndroidNotificationChannel channel;
// /// Initialize the FlutterLocalNotificationsPlugin package.
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
// const AndroidInitializationSettings initializationSettingsAndroid =
// AndroidInitializationSettings('app_icon');
// final IOSInitializationSettings initializationSettingsIOS =
// IOSInitializationSettings();
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   AppLanguage appLanguage = AppLanguage();
//   setupLocator();
//   await appLanguage.fetchLocale();
//   await Firebase.initializeApp();
//   // Set the background messaging handler early on, as a named top-level function
//   FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
//   const AndroidInitializationSettings initializationSettingsAndroid =
//   AndroidInitializationSettings('@mipmap/ic_launcher');
//   final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   if (!kIsWeb) {
//     channel = const AndroidNotificationChannel(
//       'high_importance_channel', // id
//       'High Importance Notifications', // title
//       'This channel is used for important notifications.', // description
//       importance: Importance.high,
//     );
//     /// Create an Android Notification Channel.
//     ///
//     /// We use this channel in the `AndroidManifest.xml` file to override the
//     /// default FCM channel to enable heads up notifications.
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//     /// Update the iOS foreground notification presentation options to allow
//     /// heads up notifications.
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
//     print('-----------------------------');
//     print(message.notification.title);
//     print(message.notification.body);
//     await API.getRecivedBids();
//     await API.getSentBids();
//     if (Platform.isAndroid)
//       flutterLocalNotificationsPlugin.show(
//           0,
//           message.notification.title,
//           message.notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               'high_importance_channel',
//               'High Importance Notifications',
//               'This channel is used for important notifications.',
//               importance: Importance.high,
//               priority: Priority.high,
//             ),
//             iOS: IOSNotificationDetails(),
//           ));
//     print('-----------------------------');
//   });
//   runApp(MyApp(
//     appLanguage: appLanguage,
//   ));
// }
// // const MaterialColor primaryBlack = MaterialColor(
// //   _blackPrimaryValue,
// //   <int, Color>{
// //     50: Color(0xFF000000),
// //     100: Color(0xFF000000),
// //     200: Color(0xFF000000),
// //     300: Color(0xFF000000),
// //     400: Color(0xFF000000),
// //     500: Color(_blackPrimaryValue),
// //     600: Color(0xFF000000),
// //     700: Color(0xFF000000),
// //     800: Color(0xFF000000),
// //     900: Color(0xFF000000),
// //   },
// // );
// // const int _blackPrimaryValue = 0xFF000000;
// class MyApp extends StatelessWidget {
//   final AppLanguage appLanguage;
//   MyApp({this.appLanguage});
//   static SharedPreferences sharedPreferences;
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider.value(
//           value: NotificationProvider(),
//         ),
//         ChangeNotifierProvider<AppLanguage>(
//           create: (_) => appLanguage,
//         ),
//         //currency provider
//         ChangeNotifierProvider<CurrencyProvider>(
//           create: (_) => CurrencyProvider(),
//         ),
//       ],
//       child: Consumer<AppLanguage>(builder: (context, model, child) {
//         return MaterialApp(
//           supportedLocales: [
//             Locale('en', 'US'),
//             Locale('ar', ''),
//           ],
//           localizationsDelegates: [
//             AppLocalizations.delegate,
//             GlobalMaterialLocalizations.delegate,
//             GlobalWidgetsLocalizations.delegate,
//             GlobalCupertinoLocalizations.delegate
//           ],
//           locale: model.appLocal,
//           title: 'Laybull',
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(
//             fontFamily: 'Metropolis',
//             //primarySwatch: primaryBlack,
//             primaryColor: Color(0xFF000000),
//           ),
//           initialRoute: LaybullRoute.initialRoute,
//           onGenerateRoute: onGenerateRoute,
//           home: SplashScreen(),
//         );
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
const CHANNEL = "com.bsquaredwifi.b2connect";


class abcdef extends StatefulWidget {


  const abcdef({Key? key}) : super(key: key);

  @override
  _abcdefState createState() => _abcdefState();
}



class _abcdefState extends State<abcdef> {
  static const platform = const MethodChannel('flutter.native/helper');
  String _responseFromNativeCode = 'Waiting for Response...';
  Future<void> responseFromNativeCode() async {
    String response = "";
    try {
      final String result = await platform.invokeMethod('helloFromNativeCode');
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to Invoke: '${e.message}'.";
    }
    setState(() {
      _responseFromNativeCode = response;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Call Native Method'),
              onPressed: responseFromNativeCode,
            ),
            Text(_responseFromNativeCode),
          ],
        ),
      ),
    );
  }
}