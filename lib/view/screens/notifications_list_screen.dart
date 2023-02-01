import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../view/widgets/notifications_widget.dart';

class NotificationsListScreen extends StatefulWidget {
  const NotificationsListScreen({Key? key}) : super(key: key);

  @override
  _NotificationsListScreenState createState() => _NotificationsListScreenState();
}

class _NotificationsListScreenState extends State<NotificationsListScreen> {
  //List<NotificationModel> notificationData = [];
  var navigationService = locator<NavigationService>();
  //var storageService = locator<StorageService>();

  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  // fcm()async{
  //
  //   // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   //   alert: true, // Required to display a heads up notification
  //   //   badge: true,
  //   //   sound: true,
  //   // );
  //
  //  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //
  //
  //   //
  //   //   if (message.notification != null) {
  //   //     print('Message also contained a notification: ${message.notification!.title}');
  //   //     print('Message data: ${message.notification!.body}');
  //   //   }
  //   // });
  //
  //   // var token = await messaging.getToken();
  //   //print('token:---${token.toString()}');
  // bool show=false;
  bool _allRead = false;

  //int _messageCount = 0;

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
  // Future<void> sendPushMessage(String _token) async {
  //   if (_token == null) {
  //     print('Unable to send FCM message, no token exists.');
  //     return;
  //   }
  //
  //   try {
  //     await http.post(
  //       Uri.parse('https://api.rnfirebase.io/messaging/send'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: constructFCMPayload(_token),
  //     );
  //     print('FCM request for device sent!');
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // }

  // @override
  // void initState() {
  //   super.initState();
  //
  //
  //   // print('recieved token--${data.token}');
  //   // FirebaseMessaging.instance.sendMessage(
  //   //   to: "${data.token}",
  //   //
  //   //   data: {
  //   //     "hello": "message from someone",
  //   //   }
  //   //
  //   // );
  //
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithBackIconAndLanguage(
          onTapIcon: () {
            navigationService.closeScreen();
          },
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 13.0, right: 13, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.020.h,
              ),
              Text(
                AppLocalizations.of(context)!.translate('notifications')!,
                style: TextStyle(
                    fontFamily: 'Lexend',
                    color: Colors.black,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 7.h,),
              // InkWell(
              //   onTap: (){
              //     setState(() {
              //       Provider.of<AuthProvider>(context, listen: false).notificationSeen=true;
              //     });
              //
              //
              //
              //   },
              //   child:Provider.of<AuthProvider>(context, listen: false).notificationSeen? Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Text('All read',style: TextStyle(color: pink),),
              //       SizedBox(width: 2,),
              //       Icon(Icons.check_circle,color: pink,size: 15,)
              //     ],
              //   ):Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Text('Mark all as read',style: TextStyle(color: pink),),
              //       SizedBox(width: 2,),
              //       Icon(Icons.check_circle_outline,color: pink,size: 15,)
              //     ],
              //   ),
              // ),
              SizedBox(
                height: height * 0.015.h,
              ),
              Consumer<AuthProvider>(
                builder: (context, i, _) {
                  return i.notificationData.isNotEmpty
                      ? Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        // physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: i.notificationData.length,
                        itemBuilder: (ctx, index) {
                          return NotificationsWidget(
                            data:
                            " ${i.notificationData[index].title}",
                            dateTime:
                            "${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(i.notificationData[index].timestamp!))} ${DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(i.notificationData[index].timestamp!))}",
                            description:
                            i.notificationData[index].message,
                          );
                        }),
                  )
                      : noNotifications(context);
                },
              ),
              Column(
                children: [
                  CustomButton(
                    height: height * 0.07,
                    width: double.infinity,
                    onPressed: () {
                      navigationService.navigateTo(HomeScreenRoute);
                    },
                    text: AppLocalizations.of(context)!.translate('back')!,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

Widget noNotifications(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: 40.h,
      ),
      Container(
        width: double.infinity,
        child: Center(
          child: Image(
            image: AssetImage(
              "assets/images/notification.png",
            ),
            width: 200.w,
            height: 200.h,
            fit: BoxFit.fill,
          ),
        ),
      ),
      SizedBox(
        height: 40.h,
      ),
      /*  Text(
        "Oh No!",
        style: TextStyle(
            color: Colors.black,
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            height: 1.5),
      ),*/
      Text(
        "Its took like you don't have any \nnotification",
        style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            height: 1.3),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
