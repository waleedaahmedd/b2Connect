// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../model/locale/app_localization.dart';
// import '../../model/models/userinfo_model.dart';
// import '../../model/models/wifi_package_model.dart';
// import '../../model/services/navigation_service.dart';
// import '../../model/services/storage_service.dart';
// import '../../model/services/util_service.dart';
// import '../../model/utils/routes.dart';
// import '../../model/utils/service_locator.dart';
// import '../../view/widgets/change_language_bottom_sheet.dart';
// import '../../view_model/providers/auth_provider.dart';
// import '../../view_model/providers/wifi_provider.dart';

// class WifiScreenV1 extends StatefulWidget {
//   const WifiScreenV1({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _WifiScreenV1State createState() => _WifiScreenV1State();
// }

// class _WifiScreenV1State extends State<WifiScreenV1> {
//   NavigationService navigationService = locator<NavigationService>();
//   UtilService utilsService = locator<UtilService>();
//   var storageService = locator<StorageService>();

//   List<WifiModel> wifiData = [];
//   UserInfoModel? userinfo;

//   getData() {
//     Future.delayed(Duration.zero, () async {
//       Provider.of<WifiProvider>(context, listen: false).wifiData.clear();

//       await Provider.of<WifiProvider>(context, listen: false)
//           .callWifi()
//           .then((value) {
//         setState(() {
//           wifiData.addAll(value);
//         });
//       });
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getData();
//     userinfo = Provider.of<AuthProvider>(context, listen: false).userInfoData;
//     print('from wifi screen--${userinfo!.incomingZoneLabel}');
//   }

// // List  cardList = [
// //     {
// //       "cardtype": "PLATIUM+",
// //       "bg": "assets/images/Card-1.png",
// //       "icon": "assets/images/crown.png",
// //       "price": "180 AED",
// //       "color": Color.fromRGBO(255, 121, 141, 1,),
// //       "colorbg": Color.fromRGBO(30, 30, 30, 1,),
// //     },
// //     {
// //       "cardtype": "PLATIUM",
// //       "bg": "assets/images/Card-2.png",
// //       "icon": "assets/images/crown.png",
// //       "price": "150 AED",
// //       "colorbg": Color.fromRGBO(30, 30, 30, 1,),
// //       "color": Color.fromRGBO(49, 147, 240, 1,)
// //     },
// //     {
// //       "cardtype": "GOLD+",
// //       "bg": "assets/images/Card-3.png",
// //       "icon": "assets/images/crown.png",
// //       "price": "120 AED",
// //       "colorbg": Color.fromRGBO(233, 192, 66, 1,),
// //       "color": Color.fromRGBO(81, 46, 158, 1,)
// //     },
// //     {
// //       "cardtype": "GOLD",
// //       "price": "100 AED",
// //       "bg": "assets/images/Card-4.png",
// //       "icon": "assets/images/wifi_icon.png",
// //       "colorbg": Color.fromRGBO(233, 192, 66, 1,),
// //       "color": Color.fromRGBO(173, 163, 75, 1,)
// //     },
// //     {
// //       "cardtype": "SILVER",
// //       "price": "80 AED",
// //       "bg": "assets/images/Card-5.png",
// //       "icon": "assets/images/wifi_icon.png",
// //       "colorbg": Color.fromRGBO(162, 160, 154, 1,),
// //       "color": Color.fromRGBO(66, 65, 66, 1,)
// //     },
// //     {
// //       "cardtype": "CRYSTAL",
// //       "price": "50 AED",
// //       "bg": "assets/images/Card-6.png",
// //       "icon": "assets/images/wifi_icon.png",
// //       "colorbg": Color.fromRGBO(131, 165, 210, 1,),
// //       "color": Color.fromRGBO(91, 176, 161, 1,)
// //     },
// //     {
// //       "cardtype": "BLUE",
// //       "price": "30 AED",
// //       "bg": "assets/images/Card-7.png",
// //       "icon": "assets/images/wifi_icon.png",
// //       "colorbg": Color.fromRGBO(119, 158, 233, 1,),
// //       "color": Color.fromRGBO(55, 124, 174, 1,)
// //     }
// //   ];

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: GestureDetector(
//           onTap: () {
//             navigationService.navigateTo(HomeScreenRoute);
//           },
//           child: Icon(
//             Icons.arrow_back_sharp,
//             color: Colors.black,
//             size: 25.h,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               _settingModalBottomSheet(context);
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5.r),
//                 color: Colors.grey.shade200,
//               ),
//               padding: EdgeInsets.all(8.h),
//               height: 30.h,
//               width: 110.w,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     AppLocalizations.of(context)!.translate('select')!,
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 10.sp,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Icon(
//                     Icons.arrow_drop_down,
//                     color: Colors.grey,
//                     size: 18.h,
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//       body: wifiData.isNotEmpty
//           ? SingleChildScrollView(
//               child: Container(
//                 padding: EdgeInsets.only(
//                   left: 15.w,
//                   right: 15.w,
//                   top: 10.h,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${AppLocalizations.of(context)!.translate('wifi_membership')!}',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 30.sp,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 15.h,
//                     ),
//                     Text(
//                       '${AppLocalizations.of(context)!.translate('choose_package')!}',
//                       style: TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 16.sp,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 8.h,
//                     ),
//                     RichText(
//                       text: TextSpan(
//                         text:
//                             '${AppLocalizations.of(context)!.translate('zone_name')!}',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           color: Colors.black45,
//                         ),
//                         children: <TextSpan>[
//                           TextSpan(
//                             text: '-',
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: Colors.black,
//                             ),
//                           ),
//                           TextSpan(
//                             text: '${userinfo!.incomingZoneLabel}',
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: Theme.of(context).primaryColor,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.h,
//                     ),
//                     ListView.builder(
//                         physics: NeverScrollableScrollPhysics(),
//                         shrinkWrap: true,
//                         itemCount: wifiData.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Container(
//                             child: Column(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {},
//                                   child: showCards(
//                                     cardType: wifiData[index].name,
//                                     img: wifiData[index].name == "BLUE"
//                                         ? "assets/images/Card-7.png"
//                                         : wifiData[index].name == "GOLD"
//                                             ? "assets/images/Card-4.png"
//                                             : wifiData[index].name == "GOLD+"
//                                                 ? "assets/images/Card-3.png"
//                                                 : wifiData[index].name ==
//                                                         "PLATINUM"
//                                                     ? "assets/images/Card-2.png"
//                                                     : "assets/images/Card-5.png",
//                                     price:
//                                         "${wifiData[index].price.toString()} ${wifiData[index].currency.toString()}",
//                                     icon: wifiData[index].name == "PLATINUM"
//                                         ? "assets/images/crown.png"
//                                         : wifiData[index].name == "GOLD+"
//                                             ? "assets/images/crown.png"
//                                             : "assets/images/wifi_icon.png",
//                                     color: wifiData[index].name == "BLUE"
//                                         ? Color.fromRGBO(
//                                             55,
//                                             124,
//                                             174,
//                                             1,
//                                           )
//                                         : wifiData[index].name == "GOLD"
//                                             ? Color.fromRGBO(
//                                                 233,
//                                                 192,
//                                                 66,
//                                                 1,
//                                               )
//                                             : wifiData[index].name == "GOLD+"
//                                                 ? Color.fromRGBO(
//                                                     233,
//                                                     192,
//                                                     66,
//                                                     1,
//                                                   )
//                                                 : wifiData[index].name ==
//                                                         "PLATINUM"
//                                                     ? Color.fromRGBO(
//                                                         30,
//                                                         30,
//                                                         30,
//                                                         1,
//                                                       )
//                                                     : Color.fromRGBO(
//                                                         162,
//                                                         160,
//                                                         154,
//                                                         1,
//                                                       ),
//                                     colorbuy: wifiData[index].name == "BLUE"
//                                         ? Color.fromRGBO(
//                                             119,
//                                             158,
//                                             233,
//                                             1,
//                                           )
//                                         : wifiData[index].name == "GOLD"
//                                             ? Color.fromRGBO(
//                                                 173,
//                                                 163,
//                                                 75,
//                                                 1,
//                                               )
//                                             : wifiData[index].name == "GOLD+"
//                                                 ? Color.fromRGBO(
//                                                     81,
//                                                     46,
//                                                     158,
//                                                     1,
//                                                   )
//                                                 : wifiData[index].name ==
//                                                         "PLATINUM"
//                                                     ? Color.fromRGBO(
//                                                         49,
//                                                         147,
//                                                         240,
//                                                         1,
//                                                       )
//                                                     : Color.fromRGBO(
//                                                         66,
//                                                         65,
//                                                         66,
//                                                         1,
//                                                       ),

//                                     // img, color, icon, cardType, price, colorbuy
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 10.h,
//                                 )
//                               ],
//                             ),
//                           );
//                         }),
//                     SizedBox(
//                       height: 20.h,
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           : Center(
//               child: CircularProgressIndicator(
//                 color: Colors.red,
//               ),
//             ),
//     );
//   }
// }

// void _settingModalBottomSheet(context) {
//   showModalBottomSheet(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(30.0),
//           topLeft: Radius.circular(30.0),
//         ),
//       ),
//       context: context,
//       builder: (BuildContext bc) {
//         return BottomModalSheet();
//       });
// }

// Widget showCards(
//     {String? img,
//     Color? color,
//     String? icon,
//     String? cardType,
//     String? price,
//     Color? colorbuy}) {
//   return Container(
//     decoration: BoxDecoration(
//       image: DecorationImage(
//         fit: BoxFit.fill,
//         image: AssetImage(img!),
//       ),
//     ),
//     height: 220.h,
//     padding: EdgeInsets.all(15.h),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.all(
//               Radius.circular(50.r),
//             ),
//           ),
//           height: 35.h,
//           width: 110.w,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(
//                 icon!,
//                 color: Colors.white,
//                 height: 15.h,
//               ),
//               SizedBox(
//                 width: 5.w,
//               ),
//               Text(
//                 cardType!,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14.sp,
//                 ),
//               )
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 18.h,
//         ),
//         Text(
//           "You'll get",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         SizedBox(
//           height: 10.h,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.check_outlined,
//               color: Colors.white,
//               size: 18.h,
//             ),
//             SizedBox(
//               width: 5.w,
//             ),
//             Text(
//               "30 Days validity",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 14.sp,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 8.h,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.check_outlined,
//               color: Colors.white,
//               size: 18.h,
//             ),
//             SizedBox(
//               width: 5.w,
//             ),
//             Text(
//               "200 Mbps speed",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 14.sp,
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 15.h,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               price!,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 25.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Container(
//               width: 90.w,
//               height: 35.h,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10.r),
//                 ),
//               ),
//               child: TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   "Buy Now",
//                   style: TextStyle(
//                     color: colorbuy,
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ],
//     ),
//   );
// }

library custom_switch;

import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color inactiveColor;
  final String activeText;
  final String inactiveText;
  final Color activeTextColor;
  final Color inactiveTextColor;

  const CustomSwitch(
      {Key? key,
        this.value,
        this.onChanged,
        this.activeColor,
        this.inactiveColor = Colors.grey,
        this.activeText = '',
        this.inactiveText = '',
        this.activeTextColor = Colors.white70,
        this.inactiveTextColor = Colors.white70})
      : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
        begin: widget.value! ? Alignment.centerRight : Alignment.centerLeft,
        end: widget.value! ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
        parent: _animationController!, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }
            widget.value == false
                ? widget.onChanged!(true)
                : widget.onChanged!(false);
          },
          child: Container(
            width: 69.0,
            height: 35.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              // I commented here.
              // color: _circleAnimation.value == Alignment.centerLeft
              //     ? widget.inactiveColor
              //     : widget.activeColor,

              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                // You can set your own colors in here!
                colors: [
                  const Color(0xFFE0457B),
                  const Color(0xFFAE45E0),
                  const Color(0xFFE0457B),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, right: 4.0, left: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _circleAnimation!.value == Alignment.centerRight
                      ? Padding(
                    padding: const EdgeInsets.only(left: 34.0, right: 0),
                    child: Text(
                      widget.activeText,
                      style: TextStyle(
                          color: widget.activeTextColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0),
                    ),
                  )
                      : Container(),
                  Align(
                    alignment: _circleAnimation!.value,
                    child: Container(
                      width: 27.0,
                      height: 27.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),
                  ),
                  _circleAnimation!.value == Alignment.centerLeft
                      ? Padding(
                    padding: const EdgeInsets.only(left: 0, right: 34.0),
                    child: Text(
                      widget.inactiveText,
                      style: TextStyle(
                          color: widget.inactiveTextColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 16.0),
                    ),
                  )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}