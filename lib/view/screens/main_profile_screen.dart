
import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/screens/qr_code_screen.dart';
import 'package:b2connect_flutter/view/widgets/main_profile_widget.dart';
import 'package:b2connect_flutter/view/widgets/no_internet.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//import 'package:in_app_review/in_app_review.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:salesiq_mobilisten/salesiq_mobilisten.dart';

import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

class MainProfileScreen extends StatefulWidget {
  const MainProfileScreen({Key? key}) : super(key: key);

  @override
  _MainProfileScreenState createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {
  var navigationService = locator<NavigationService>();

  bool _connectedToInternet = true;

  callData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
    } else {
      setState(() {
        _connectedToInternet = false;
      });
      //utilsService.showToast("Sorry! but you don't seem to connected to any internet connection");
    }
  }

  @override
  void initState() {
    super.initState();
    callData();
    //loadData();
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: _connectedToInternet
            ? Consumer<AuthProvider>(builder: (context, i, _) {
                return i.userInfoData != null
                    ? Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Consumer<AuthProvider>(
                                builder: (context, i, _) {
                              return Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  gradient: gradientColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                await Provider.of<
                                                            AuthProvider>(
                                                        context,
                                                        listen: false)
                                                    .callNotifications(
                                                        context, '1', '30')
                                                    .then((value) {
                                                  setState(() {
                                                    //  _notificationData.addAll(value);
                                                    navigationService
                                                        .navigateTo(
                                                            NotificationsListScreenRoute);
                                                  });
                                                });
                                              },
                                              child: Container(
                                                height: 30.h,
                                                width: 30.w,
                                                // color: Colors.red,
                                                margin: EdgeInsets.only(
                                                  //right: 5.w,
                                                  top: 5.h,
                                                ),
                                                child: Icon(
                                                  Icons
                                                      .notifications_outlined,
                                                  color: Colors.white,
                                                  size: 25
                                                      .sp, //ScreenSize.appbarIconSize,
                                                ),
                                              ),
                                            ),
                                            // Positioned(
                                            //   left: 10.w,
                                            //   top: 10.h,
                                            //   child: Provider.of<AuthProvider>(context, listen: false).notificationSeen
                                            //       ? Container(
                                            //           width: width * 0.018,
                                            //           height: height * 0.018,
                                            //           decoration: BoxDecoration(
                                            //             shape: BoxShape.circle,
                                            //             color: Colors.red,
                                            //           ),
                                            //         )
                                            //       : Text(' '),
                                            // )
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                height: 80.h,
                                                width: 80.w,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      "assets/images/profile_placeholder.png",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                           /*   Positioned.fill(
                                                child: Align(
                                                  alignment: Alignment
                                                      .bottomCenter,
                                                  child: Wrap(
                                                    children: [
                                                      Container(
                                                        // width: 60.w,
                                                        // height: 15.h,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          // color: Color.fromRGBO(136, 167, 210, 1,),
                                                          gradient:
                                                              LinearGradient(
                                                            colors: i.userInfoData!
                                                                        .profileName ==
                                                                    "SILVER"
                                                                ? [
                                                                    Color(
                                                                        0xFF3D3C3A),
                                                                    Color(
                                                                        0xFFC8C5BD),
                                                                  ]
                                                                : i.userInfoData!.profileName ==
                                                                            "PLATINUM" ||
                                                                        i.userInfoData!.profileName ==
                                                                            "PLATINUM+"
                                                                    ? [
                                                                        Color(0xFF1A1A1A),
                                                                        Color(0xFF1A1A1A),
                                                                      ]
                                                                    : i.userInfoData!.profileName ==
                                                                            "CRYSTAL"
                                                                        ? [
                                                                            Color(0xFF7BA2D0),
                                                                            Color(0xFFB4B7D8),
                                                                          ]
                                                                        : i.userInfoData!.profileName == "GOLD"
                                                                            ? [
                                                                                Color(0xFFEFC851),
                                                                                Color(0xFFFAD76D),
                                                                              ]
                                                                            : i.userInfoData!.profileName == "GOLD+"
                                                                                ? [
                                                                                    Color(0xFFF4C73E),
                                                                                    Color(0xFFB99013),
                                                                                  ]
                                                                                : i.userInfoData!.profileName == "CRYSTAL+" && i.userInfoData!.isCorporate == true && i.userInfoData!.availableActivations == 0
                                                                                    ? [
                                                                                        Colors.grey,
                                                                                        Colors.grey,
                                                                                      ]
                                                                                    : [
                                                                                        Color(0xFF5787E3),
                                                                                        Color(0xFF5787E3),
                                                                                      ],
                                                            begin:
                                                                const FractionalOffset(
                                                                    0.2,
                                                                    0.0),
                                                            end:
                                                                const FractionalOffset(
                                                                    1.1,
                                                                    0.0),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets
                                                                  .symmetric(
                                                              horizontal:
                                                                  10,
                                                              vertical: 5),
                                                          child: Row(
                                                            *//*mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,*//*
                                                            children: [
                                                              Image.asset(
                                                                i.userInfoData!.profileName == "GOLD" ||
                                                                        i.userInfoData!.profileName ==
                                                                            "GOLD+" ||
                                                                        i.userInfoData!.profileName ==
                                                                            "PLATINUM" ||
                                                                        i.userInfoData!.profileName ==
                                                                            "PLATINUM+"
                                                                    ? "assets/images/crown.png"
                                                                    : "assets/images/wifi_icon.png",
                                                                color: Colors
                                                                    .white,
                                                                height:
                                                                    10.h,
                                                                //scale: 5,
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  child:
                                                                      Text(
                                                                    "${i.userInfoData!.profileName}",
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          Colors.white,
                                                                      fontSize:
                                                                          9.sp,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )*/
                                            ],
                                          ),
                                        /*  SizedBox(
                                            width: 20.w,
                                          ),*/
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${i.userInfoData!.firstName} ${i.userInfoData!.lastName}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.sp,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      print(
                                                          'data${i.userInfoData!.profileValidToUT}');
                                                    },
                                                    child: Text(
                                                      "+${i.userInfoData!.uid}",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    /*mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,*/
                                                    children: [
                                                      Text('Plan: ',  style:
                                                      TextStyle(
                                                        color:
                                                        Colors.white,
                                                        fontSize:
                                                        12.sp,
                                                      ),),
                                                    /*  Image.asset(
                                                        i.userInfoData!.profileName == "GOLD" ||
                                                            i.userInfoData!.profileName ==
                                                                "GOLD+" ||
                                                            i.userInfoData!.profileName ==
                                                                "PLATINUM" ||
                                                            i.userInfoData!.profileName ==
                                                                "PLATINUM+"
                                                            ? "assets/images/crown.png"
                                                            : "assets/images/wifi_icon.png",
                                                        color: Colors
                                                            .white,
                                                        height:
                                                        10.h,
                                                        //scale: 5,
                                                      ),
                                                      SizedBox(width: 10.w,),*/
                                                      Text(
                                                        "${i.userInfoData!.profileName}",
                                                        style:
                                                        TextStyle(
                                                          color:
                                                          Colors.white,
                                                          fontSize:
                                                          12.sp,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    i.userInfoData!
                                                                .profileValidToUT !=
                                                            null
                                                        ? "${AppLocalizations.of(context)!.translate('valid_until')!}${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(i.userInfoData!.profileValidToUT * 1000))} "
                                                        : ' ',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 30.h,
                                            height: 30.h,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: IconButton(
                                                onPressed: () {
                                                  print('ontap');
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          QRCodeScreen(
                                                        url: i.userInfoData!
                                                            .qrCodeLink
                                                            .toString(),
                                                        title: "QR code",
                                                      ),
                                                    ),
                                                  );
                                                },
                                                icon: Padding(
                                                  padding: const EdgeInsets.all(0.0),
                                                  child: Icon(
                                                    Icons.widgets_outlined,
                                                    color: Color.fromRGBO(
                                                        224, 69, 123, 1),
                                                    size: 16.h,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    /*  SizedBox(
                                        height: 10.h,
                                      ),*/
                                    ],
                                  ),
                                ),
                              );
                            }),
                           /* SizedBox(
                              height:
                                  10.h,
                            ),*/
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: 200.h,
                                maxHeight: 500.h
                              ),
                              child: ListView(
                                padding: const EdgeInsets.only(top: 10.0),
                                shrinkWrap: true,
                                children: [
                                  //orders_icon
                                  MainProfileWidget(
                                      onTap: () {
                                        navigationService.navigateTo(
                                            PersonalInformationScreenRoute);
                                      },
                                      title: AppLocalizations.of(context)!
                                          .translate(
                                              'personal_information')!,
                                      icon: ImageIcon(
                                        AssetImage(
                                            'assets/images/person_icon.png'),
                                        color: Colors.black,
                                        size: 15.h,
                                      )
                                      // Icon(
                                      //   Icons.person_outline,
                                      //   color: Color.fromRGBO(55, 60, 65, 1),
                                      //   size: 27.0,
                                      // ),
                                      ),
                                  MainProfileWidget(
                                      onTap: () {
                                        navigationService
                                            .navigateTo(OrdersScreenRoute);
                                      },
                                      title: AppLocalizations.of(context)!
                                          .translate('orders')!,
                                      icon: ImageIcon(
                                        AssetImage(
                                            'assets/images/orders_icon.png'),
                                        color: Colors.black,
                                        size: 15.h,
                                      )
                                      // Icon(
                                      //   Icons.person_outline,
                                      //   color: Color.fromRGBO(55, 60, 65, 1),
                                      //   size: 27.0,
                                      // ),
                                      ),
                                  MainProfileWidget(
                                      onTap: () {
                                        navigationService.navigateTo(
                                            WifiPlanScreenRoute);
                                      },
                                      title: AppLocalizations.of(context)!
                                          .translate('wifi_plan')!,
                                      icon: ImageIcon(
                                        AssetImage(
                                            'assets/images/icon_wifi.png'),
                                        color:
                                            Color.fromRGBO(55, 60, 65, 1),
                                        size: 15.h,
                                      )

                                      // Icon(Icons.wifi_outlined,
                                      //   color: Color.fromRGBO(55, 60, 65, 1),
                                      //   size: 27.0,
                                      // ),
                                      ),
                                  MainProfileWidget(
                                      onTap: () {
                                        navigationService.navigateTo(
                                            TransactionsScreenRoute);
                                      },
                                      title: AppLocalizations.of(context)!
                                          .translate('transaction')!,
                                      icon: ImageIcon(
                                        AssetImage(
                                            'assets/images/transaction_icon.png'),
                                        color:
                                            Color.fromRGBO(55, 60, 65, 1),
                                        size: 15.h,
                                      )
                                      //
                                      // Container(
                                      //   height: 23,
                                      //   child:
                                      //   Image.asset('assets/images/transaction_icon.png'),
                                      // ),
                                      ),
                                  MainProfileWidget(
                                      onTap: () {
                                        //TransactionsScreenRoute
                                        navigationService.navigateTo(
                                            SettingsScreenRoute);
                                      },
                                      title: AppLocalizations.of(context)!
                                          .translate('setting')!,
                                      icon: ImageIcon(
                                        AssetImage(
                                            'assets/images/settings_icon.png'),
                                        color:
                                            Color.fromRGBO(55, 60, 65, 1),
                                        size: 15.h,
                                      )

                                      // Icon(
                                      //   Icons.settings_outlined,
                                      //   color: Color.fromRGBO(55, 60, 65, 1),
                                      //   size: 27.0,
                                      // ),
                                      ),
                                  MainProfileWidget(
                                      onTap: () {
                                        navigationService.navigateTo(
                                            WishlistScreenRoute);
                                      },
                                      title: AppLocalizations.of(context)!
                                          .translate('wishlist')!,
                                      icon: ImageIcon(
                                        AssetImage(
                                            'assets/images/wishlist_icon.png'),
                                        color:
                                            Color.fromRGBO(55, 60, 65, 1),
                                        size: 15.h,
                                      )

                                      // Icon(
                                      //   Icons.settings_outlined,
                                      //   color: Color.fromRGBO(55, 60, 65, 1),
                                      //   size: 27.0,
                                      // ),
                                      ),
                                  MainProfileWidget(
                                      onTap: () async {
                                        /*  if (Platform.isAndroid) {*/
                                        // Android-specific code
                                        _showRatingAppDialog();
/*
                                         } else if (Platform.isIOS) {
                                        if (await inAppReview
                                            .isAvailable()) {
                                        inAppReview.requestReview();
                                        }*/
                                        // iOS-specific code
                                        /*  _launchURL(
                                    "https://apps.apple.com/us/app/b2connect/id1596908109");*/
                                        /*  }*/
                                      },
                                      title: AppLocalizations.of(context)!
                                          .translate('rate')!,
                                      icon: ImageIcon(
                                        AssetImage(
                                            'assets/images/rating_icon.png'),
                                        color:
                                            Color.fromRGBO(55, 60, 65, 1),
                                        size: 15.h,
                                      )
                                      //   Icon(
                                      //   Icons.star_border_outlined,
                                      //   color: Color.fromRGBO(55, 60, 65, 1),
                                      //   size: 27.0,
                                      // ),
                                      ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Container(
                                    child: Center(
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          ZohoSalesIQ.unregisterVisitor();
                                          await logOutConset(context);

                                          //navigationService.navigateTo(SignupScreenRoute);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          textStyle: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                10.0.r),
                                          ),
                                          primary: Colors.white,
                                        ),
                                        child: new Text(
                                          AppLocalizations.of(context)!
                                              .translate('logout')!,
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                              247,
                                              128,
                                              121,
                                              1,
                                            ),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                 /* SizedBox(
                                    height: 20.h,
                                  ),*/
                                ],
                              ),
                            ),

                          ],
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      );
              })
            : NoInternet());
  }

  void _showRatingAppDialog() {
    // final InAppReview inAppReview = InAppReview.instance;

    final _ratingDialog = RatingDialog(
      enableComment: false,
      starColor: Colors.amber,
      title: Text(
        'Rate Us Now',
        textAlign: TextAlign.center,
      ),
      message: Text(
        'Select Number of Stars 1 - 5 to Rate This App',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
      ),
      image: Image.asset(
        "assets/images/app_icon.png",
        height: 60,
      ),
      submitButtonText: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) async {
        print('rating: ${response.rating}, '
            'comment: ${response.comment}');

        if (response.rating < 3.0) {
          print('response.rating: ${response.rating}');
        } else {
          /*inAppReview.openStoreListing(
              appStoreId: 'shri.complete.fitness.gymtrainingapp',
              microsoftStoreId: '1596908109');*/
          StoreRedirect.redirect(
              androidAppId: 'com.bsquaredwifi.app', iOSAppId: '1596908109');
        }
      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }
}

// class RatingDialog extends StatefulWidget {
//   @override
//   _RatingDialogState createState() => _RatingDialogState();
// }
//
// class _RatingDialogState extends State<RatingDialog> {
//   int _stars = 0;
//
//   Widget _buildStar(int starCount) {
//     return InkWell(
//       child: Icon(
//         Icons.star,
//         // size: 30.0,
//         color: _stars >= starCount ? Colors.orange : Colors.grey,
//       ),
//       onTap: () {
//         setState(() {
//           _stars = starCount;
//         });
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Center(child: Text('Rate this post'),),
//       content: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: <Widget>[
//           _buildStar(1),
//           _buildStar(2),
//           _buildStar(3),
//           _buildStar(4),
//           _buildStar(5),
//         ],
//       ),
//       actions: <Widget>[
//         FlatButton(
//           child: Text('CANCEL'),
//           onPressed: Navigator.of(context).pop,
//         ),
//         FlatButton(
//           child: Text('OK'),
//           onPressed: () {
//             Navigator.of(context).pop(_stars);
//           },
//         )
//       ],
//     );
//   }
// }

// Widget rating(context){
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text("AlertDialog"),
//         content: Text("Would you like to continue learning how to use Flutter alerts?"),
//         actions: [
//          // cancelButton,
//           //continueButton,
//         ],
//       );
//     },
//   );
// }
