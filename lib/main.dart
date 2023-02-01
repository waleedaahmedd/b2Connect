// @dart=2.9
import 'dart:io';

import 'package:b2connect_flutter/view/screens/splash_screen.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:b2connect_flutter/view_model/providers/fortune_provider.dart';
import 'package:b2connect_flutter/view_model/providers/blogs_provider.dart';
import 'package:b2connect_flutter/view_model/providers/job_provider.dart';
import 'package:b2connect_flutter/view_model/providers/location_provider.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:b2connect_flutter/view_model/providers/order_provider.dart';
import 'package:b2connect_flutter/view_model/providers/pay_by_provider.dart';
import 'package:b2connect_flutter/view_model/providers/points_provider.dart';
import 'package:b2connect_flutter/view_model/providers/scanner_provider.dart';
import 'package:b2connect_flutter/view_model/providers/web_view_provider.dart';
import 'package:b2connect_flutter/view_model/providers/wifi_provider.dart';
import 'package:b2connect_flutter/view_model/providers/wish_list_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/view_model/providers/app_language_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'environment_variable/environment.dart';
import 'model/utils/routes.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  await dotenv.load(fileName: Environment.fileName);
  await Firebase.initializeApp();

  // WidgetsFlutterBinding.ensureInitialized();
  // //FirebaseApp.configure();
  // await Firebase.initializeApp();

  // if (Platform.isAndroid) {
  //   await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  //
  //   var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
  //       AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
  //   var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
  //       AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);
  //
  //   if (swAvailable && swInterceptAvailable) {
  //     AndroidServiceWorkerController serviceWorkerController =
  //     AndroidServiceWorkerController.instance();
  //
  //     serviceWorkerController.serviceWorkerClient = AndroidServiceWorkerClient(
  //       shouldInterceptRequest: (request) async {
  //         print(request);
  //         return null;
  //       },
  //     );
  //   }
  // }

  //
  //
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  //
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  // final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid,);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // if (!kIsWeb) {
  //     var token= await FirebaseMessaging.instance.getToken();
  //     print('this is the token--${token.toString()}');
  //     if(token!.isNotEmpty){
  //
  //       //Provider.of<AuthProvider>(context,listen: false).callFcmToken(token.toString());
  //     }
  //
  //   AndroidNotificationChannel channel = const AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // title
  //     //'This channel is used for important notifications.', // description
  //     importance: Importance.high,
  //   );
  //
  //   await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
  //   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );
  // }
  //
  //
  //
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
  //   print(message.notification!.title);
  //   print(message.notification!.body);
  //
  //
  //   if (Platform.isAndroid)
  //     flutterLocalNotificationsPlugin.show(
  //         0,
  //         message.notification!.title,
  //         message.notification!.body,
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             'high_importance_channel',
  //             'High Importance Notifications',
  //             //'This channel is used for important notifications.',
  //             importance: Importance.high,
  //             priority: Priority.high,
  //           ),
  //           iOS: IOSNotificationDetails(
  //
  //           ),
  //         ));
  // });

  // WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();

  await appLanguage.fetchLocale();
  configLoading();
  setupLocator();
  runApp(
    // DevicePreview(
    // enabled: !kReleaseMode,
    // builder: (context) =>
    App(
      appLanguage: appLanguage,
    ), // Wrap your app

    // )
  );
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.dualRing
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Color.fromRGBO(224, 69, 123, 1.0)
    ..backgroundColor = Colors.white
    ..indicatorColor = Color.fromRGBO(224, 69, 123, 1.0)
    ..textColor = Colors.black
    ..maskColor = Colors.black.withOpacity(0.5)
    ..maskType = EasyLoadingMaskType.custom
    ..userInteractions = false
    ..toastPosition = EasyLoadingToastPosition.bottom
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class App extends StatelessWidget {
  final AppLanguage appLanguage;

  App({this.appLanguage});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppLanguage>(
          create: (_) => appLanguage,
        ),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<FortuneProvider>(
            create: (_) => FortuneProvider()),
        ChangeNotifierProvider<OffersProvider>(create: (_) => OffersProvider()),
        ChangeNotifierProvider<ScannerProvider>(
            create: (_) => ScannerProvider()),
        ChangeNotifierProvider<WifiProvider>(create: (_) => WifiProvider()),
        ChangeNotifierProvider<WishListProvider>(
            create: (_) => WishListProvider()),
        ChangeNotifierProvider<JobProvider>(create: (_) => JobProvider()),
        ChangeNotifierProvider<PayByProvider>(create: (_) => PayByProvider()),
        ChangeNotifierProvider<BlogsProvider>(create: (_) => BlogsProvider()),
        ChangeNotifierProvider<OrderProvider>(create: (_) => OrderProvider()),
        ChangeNotifierProvider<WebViewProvider>(
            create: (_) => WebViewProvider()),
        ChangeNotifierProvider<LocationProvider>(
            create: (_) => LocationProvider()),
        ChangeNotifierProvider<PointsProvider>(create: (_) => PointsProvider()),
      ],
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return ScreenUtilInit(
          designSize: Size(360, 690),
          builder: () => RefreshConfiguration(
            footerTriggerDistance: 15,
            dragSpeedRatio: 0.91,
            headerBuilder: () => ClassicHeader(
              refreshingIcon: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(224, 69, 123, 1.0),
                    strokeWidth: 2,
                  )),
            ),
            footerBuilder: () => ClassicFooter(),
            enableLoadingWhenNoData: false,
            enableRefreshVibrate: false,
            enableLoadMoreVibrate: false,
            shouldFooterFollowWhenNotFull: (state) {
              // If you want load more with noMoreData state ,may be you should return false
              return false;
            },
            child: MaterialApp(
              home: SplashScreen(),
              supportedLocales: [
                Locale('en', 'US'),
                // Locale('ar', ''),
                // Locale('ms', ''),
                Locale('hi', 'IND')
              ],
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              // builder: DevicePreview.appBuilder,
              title: 'B2 Connect',
              color: Theme.of(context).backgroundColor,
              debugShowCheckedModeBanner: false,
              locale: model.appLocal,
              navigatorKey: locator<NavigationService>().navigatorKey,
              theme: ThemeData(
                colorScheme: ThemeData().colorScheme.copyWith(
                      primary: Color.fromRGBO(224, 69, 123, 1.0),
                    ),
                //  iconTheme: IconThemeData(color:Color.fromRGBO(224, 69, 123, 1)),
                fontFamily: "Lexend",
                // primarySwatch:  Color.fromRGBO(224, 69, 123, 1),
                primaryColor: Color.fromRGBO(224, 69, 123, 1.0),
                visualDensity: VisualDensity.adaptivePlatformDensity,
/*                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: Color.fromRGBO(172, 182, 190, 1)),*/
                textSelectionTheme: TextSelectionThemeData(
                    cursorColor: Color.fromRGBO(224, 69, 123, 1)),
              ),
              /*darkTheme: ThemeData.dark(),
              themeMode: ThemeMode.system,*/
              useInheritedMediaQuery: true,

              builder: EasyLoading.init(),
              onGenerateRoute: onGenerateRoute,
              // initialRoute: SplashScreenRoute,

              //home: Example(),
            ),
          ),
        );
      }),
    );
  }
}

// void getVersion()async{
//   final newVersion=NewVersion(
//     androidId: "com.eurisko.azadea",
//   );
//   final status=await newVersion.getVersionStatus();
//   newVersion.showUpdateDialog(context: context, versionStatus: status!);
//
//   print("Device: ${status.localVersion}");
//   print("Store: ${status.storeVersion}");
// }

// import 'dart:convert';
// import 'dart:async';
//
// import 'package:b2connect_flutter/view/screens/notifications_list_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// //import 'package:firebase_messaging_example/firebase_config.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// // import 'message.dart';
// // import 'message_list.dart';
// // import 'permissions.dart';
// // import 'token_monitor.dart';
//
// /// Define a top-level named handler which background/terminated messages will
// /// call.
// ///
// /// To verify things are working, check out the native platform logs.
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }
//
// /// Create a [AndroidNotificationChannel] for heads up notifications
// late AndroidNotificationChannel channel;
//
// /// Initialize the [FlutterLocalNotificationsPlugin] package.
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     // options: const FirebaseOptions(
//     //   apiKey: 'AIzaSyAHAsf51D0A407EklG1bs-5wA7EbyfNFg0',
//     //   appId: '1:448618578101:ios:2bc5c1fe2ec336f8ac3efc',
//     //   messagingSenderId: '448618578101',
//     //   projectId: 'react-native-firebase-testing',
//     // ),
//   );
//
//   // Set the background messaging handler early on, as a named top-level function
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//   if (!kIsWeb) {
//     channel = const AndroidNotificationChannel(
//       'high_importance_channel', // id
//       'High Importance Notifications', // title
//       //'This channel is used for important notifications.', // description
//       importance: Importance.high,
//     );
//
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//     /// Create an Android Notification Channel.
//     ///
//     /// We use this channel in the `AndroidManifest.xml` file to override the
//     /// default FCM channel to enable heads up notifications.
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);
//
//     /// Update the iOS foreground notification presentation options to allow
//     /// heads up notifications.
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }
//
//   runApp(MessagingExampleApp());
// }
//
// /// Entry point for the example application.
// class MessagingExampleApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Messaging Example App',
//       theme: ThemeData.dark(),
//       routes: {
//         '/': (context) => Application(),
//         '/message': (context) => NotificationsScreen(),
//       },
//     );
//   }
// }
//
// // Crude counter to make messages unique
// int _messageCount = 0;
//
// /// The API endpoint here accepts a raw FCM payload for demonstration purposes.
// String constructFCMPayload(String? token) {
//   _messageCount++;
//   return jsonEncode({
//     'token': token,
//     'data': {
//       'via': 'FlutterFire Cloud Messaging!!!',
//       'count': _messageCount.toString(),
//     },
//     'notification': {
//       'title': 'Hello FlutterFire!',
//       'body': 'This notification (#$_messageCount) was created via FCM!',
//     },
//   });
// }
//
// /// Renders the example application.
// class Application extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _Application();
// }
//
// class _Application extends State<Application> {
//   String? _token;
//
//   @override
//   void initState() {
//     super.initState();
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) {
//       if (message != null) {
//         print('message data--${message.data}');
//         // Navigator.pushNamed(
//         //   context,
//         //   '/message',
//         //   arguments: MessageArguments(message, true),
//         // );
//       }
//     });
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification?.android;
//       if (notification != null && android != null && !kIsWeb) {
//         flutterLocalNotificationsPlugin.show(
//           notification.hashCode,
//           notification.title,
//           notification.body,
//           NotificationDetails(
//             android: AndroidNotificationDetails(
//               channel.id,
//               channel.name,
//               //channel.description,
//               //      one that already exists in example app.
//               icon: 'launch_background',
//             ),
//           ),
//         );
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//       // Navigator.pushNamed(
//       //   context,
//       //   '/message',
//       //   arguments: MessageArguments(message, true),
//       // );
//     });
//   }
//
//   Future<void> sendPushMessage() async {
//     _token = await FirebaseMessaging.instance.getToken();
//
//     if (_token == null) {
//       print('Unable to send FCM message, no token exists.');
//       return;
//     }
//
//     try {
//       await http.post(
//         Uri.parse('https://api.rnfirebase.io/messaging/send'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: constructFCMPayload(_token),
//       );
//       print('FCM request for device sent!');
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   Future<void> onActionSelected(String value) async {
//     switch (value) {
//       case 'subscribe':
//         {
//           print(
//             'FlutterFire Messaging Example: Subscribing to topic "fcm_test".',
//           );
//           await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
//           print(
//             'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.',
//           );
//         }
//         break;
//       case 'unsubscribe':
//         {
//           print(
//             'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".',
//           );
//           await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
//           print(
//             'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.',
//           );
//         }
//         break;
//       case 'get_apns_token':
//         {
//           if (defaultTargetPlatform == TargetPlatform.iOS ||
//               defaultTargetPlatform == TargetPlatform.macOS) {
//             print('FlutterFire Messaging Example: Getting APNs token...');
//             String? token = await FirebaseMessaging.instance.getAPNSToken();
//             print('FlutterFire Messaging Example: Got APNs token: $token');
//           } else {
//             print(
//               'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.',
//             );
//           }
//         }
//         break;
//       default:
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cloud Messaging'),
//         actions: <Widget>[
//           PopupMenuButton(
//             onSelected: onActionSelected,
//             itemBuilder: (BuildContext context) {
//               return [
//                 const PopupMenuItem(
//                   value: 'subscribe',
//                   child: Text('Subscribe to topic'),
//                 ),
//                 const PopupMenuItem(
//                   value: 'unsubscribe',
//                   child: Text('Unsubscribe to topic'),
//                 ),
//                 const PopupMenuItem(
//                   value: 'get_apns_token',
//                   child: Text('Get APNs token (Apple only)'),
//                 ),
//               ];
//             },
//           ),
//         ],
//       ),
//       floatingActionButton: Builder(
//         builder: (context) => FloatingActionButton(
//           onPressed: sendPushMessage,
//           backgroundColor: Colors.white,
//           child: const Icon(Icons.send),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             //MetaCard('Permissions', Permissions()),
//             // MetaCard(
//             //   'FCM Token',
//             //   TokenMonitor((token) {
//             //     _token = token;
//             //     return token == null
//             //         ? const CircularProgressIndicator()
//             //         : Text(token, style: const TextStyle(fontSize: 12));
//             //   }),
//             // ),
//             // MetaCard('Message Stream', MessageList()),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// UI Widget for displaying metadata.
// class MetaCard extends StatelessWidget {
//   final String _title;
//   final Widget _children;
//
//   // ignore: public_member_api_docs
//   MetaCard(this._title, this._children);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(bottom: 16),
//                 child: Text(_title, style: const TextStyle(fontSize: 18)),
//               ),
//               _children,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
