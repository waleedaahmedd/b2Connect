import 'dart:async';
import 'dart:io';
import 'package:b2connect_flutter/model/utils/no_internet_dialog.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_store/open_store.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:show_up_animation/show_up_animation.dart';
import '../../screen_size.dart';
import '../../view_model/providers/auth_provider.dart';
import '../../model/utils/routes.dart';
import '../../model/utils/service_locator.dart';
import '../../model/services/storage_service.dart';
import '../../model/services/navigation_service.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@drawable/notification_icon');

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var _mediaHeight;
  var _mediaWidth;
  var navigationService = locator<NavigationService>();
  var storageService = locator<StorageService>();
  Object? liveVersion;
  int? finalLiveVersion;
  List liveVersionList = [];
  List<String> newFeaturesList = [];

  getAppData() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('B2Upgrade');
    if (Platform.isAndroid) {
      await ref.child('AndroidVersion').once().then((DatabaseEvent event) {
        liveVersion = event.snapshot.value;
        liveVersionList = liveVersion.toString().split('.');
        liveVersionList = liveVersionList.map((i) => int.parse(i)).toList();
        finalLiveVersion = (liveVersionList[0] * 10000 + liveVersionList[1] * 100 + liveVersionList[2]);


        print(liveVersionList);
        ref.child('Features').once().then((DatabaseEvent snapshot) {
          newFeaturesList = snapshot.snapshot.value.toString().split(',');

          getVersion();
        });
      });
    } else if (Platform.isIOS) {
      ref.child('iOSVersion').once().then((DatabaseEvent event) {
        liveVersion = event.snapshot.value;
        liveVersionList = liveVersion.toString().split('.');
        liveVersionList = liveVersionList.map((i) => int.parse(i)).toList();
        finalLiveVersion = (liveVersionList[0] * 10000 + liveVersionList[1] * 100 + liveVersionList[2]);

        print(liveVersionList);
        ref.child('Features').once().then((DatabaseEvent event) {
          newFeaturesList = event.snapshot.value.toString().split(',');

          getVersion();
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _mediaWidth = MediaQuery.of(context).size.width;
      _mediaHeight = MediaQuery.of(context).size.height;
      ScreenSize.screen(_mediaWidth, _mediaHeight);
    });

    NoInternetDialog.checkConnection().then((value) {
      if (value) {
        dataCalling();
      } else {
        NoInternetDialog.getInternetAlert(
            newContext: context, dataCalling: dataCalling());
      }
    });
  }

  Future<void> dataCalling() async {
    await getAppData();
    await finalizeData();
  }

  finalizeData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    if (!kIsWeb) {
      var token = await FirebaseMessaging.instance.getToken();
      print('this is the token--${token.toString()}');
      if (token!.isNotEmpty) {
        //Provider.of<AuthProvider>(context,listen: false).callFcmToken(token.toString());
        Provider.of<AuthProvider>(context, listen: false)
            .saveFcmToken(token.toString());
      }

      AndroidNotificationChannel channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        //'This channel is used for important notifications.', // description
        importance: Importance.high,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print(message.notification!.title);
      print(message.notification!.body);

      flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              //'This channel is used for important notifications.',
              importance: Importance.high,
              priority: Priority.high,
            ),
            iOS: IOSNotificationDetails(),
          ));
    });
  }

  navigateDecision() async {
    if (await storageService.getBoolData('isShowHome') == true) {
      navigationService.navigateTo(HomeScreenRoute);
      //await loadData1();
    } else {
      navigationService.navigateTo(OnBoardingRoute);
    }
  }

  void getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String code = packageInfo.buildNumber;
    Provider.of<AuthProvider>(context, listen: false)
        .saveAppVersion('$version($code)-QA-10032022-1930');

    List localVersion = version.split('.');
    localVersion = localVersion.map((i) => int.parse(i)).toList();
    var finalLocalVersion = (localVersion[0] * 10000 + localVersion[1] * 100 + localVersion[2]);


    if ( finalLiveVersion! > finalLocalVersion
    /*int.parse(liveVersionList[0]) > int.parse(localVersion[0]) ||
        int.parse(liveVersionList[1]) > int.parse(localVersion[1]) ||
        int.parse(liveVersionList[2]) > int.parse(localVersion[2])*/) {
      getUpdateAlert();
    } else {
      Timer(Duration(seconds: 3), () async {
        await navigateDecision();
      });
    }
  }

  getUpdateAlert() {
    showGeneralDialog(
      barrierLabel: 'Update Available',
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      context: context,
      pageBuilder: (_, __, ___) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Align(
            alignment: Alignment.center,
            child: Wrap(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            "assets/images/popup.png",
                            // scale: 8,
                            height: 150.h,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'New Version',
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            itemCount: newFeaturesList.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  '${newFeaturesList[index]}',
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              height: 40.h,
                              width: 250.w,
                              text: "Update Now",
                              onPressed: () {
                                OpenStore.instance.open(
                                  appStoreId: '1596908109',
                                  androidAppBundleId:
                                      'com.bsquaredwifi.app', // Android app bundle package name
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: null,
      child: Stack(
          // fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/splash1.jpg'),
                    fit: BoxFit.cover),
              ),
            ),
            Positioned(
              child: Align(
                alignment: FractionalOffset.center,
                child: Container(
                  child:
                      // Container(child: Image.asset('assets/images/logo.png')),
                      ShowUpAnimation(
                    delayStart: Duration(milliseconds: 100),
                    animationDuration: Duration(seconds: 2),
                    curve: Curves.bounceIn,
                    direction: Direction.vertical,
                    offset: 0.7,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.fill,
                            scale: 3,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'Connecting Communities Digitally',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
