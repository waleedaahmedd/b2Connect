import 'package:b2connect_flutter/model/models/wifi_plan_model.dart';
import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/view/screens/main_dashboard_screen.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/no_data_screen.dart';
import 'package:b2connect_flutter/view/widgets/no_internet.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/models/userinfo_model.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:b2connect_flutter/view_model/providers/wifi_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
//import 'package:readmore/readmore.dart';

class WifiPlanScreen extends StatefulWidget {
  WifiPlanScreen({Key? key}) : super(key: key);

  @override
  _WifiPlanScreenState createState() => _WifiPlanScreenState();
}

class _WifiPlanScreenState extends State<WifiPlanScreen> {
  //List<WifiModel> wifiData = [];
  //List<WifiModel> recommendedDevices = [];
  //List<WifiModel> lovedDevices = [];
  //List<WifiModel> affordableDevices = [];
  //UserInfoModel? _userinfo;
  bool? _showLoader;
  bool _connectedToInternet = true;
  WifiPlanModel? _wifiPlanModel;
  bool wifiFree = true;
  UserInfoModel? _userData;

  //PackageOrdersModel? _packageOrderData1;

  //bool showNoData=false;
  //DateTime? _expiry;

  getData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      await Provider.of<WifiProvider>(context, listen: false)
          .callWifiPlan()
          .then((value) {
        print('value$value');

        if (value == "failed") {
          setState(() {
            _showLoader = true;
          });
        } else {
          setState(() {
            _wifiPlanModel = value;
            _wifiPlanModel!.packageName == 'Free'
                ? wifiFree = false
                : wifiFree = true;
          });
        }

        // setState(() {
        //   _userinfo = Provider.of<AuthProvider>(context, listen: false).userInfoData;
        // });
      });
    } else {
      setState(() {
        _connectedToInternet = false;
      });
    }
  }

  @override
  void initState() {
    _userData = Provider.of<AuthProvider>(context, listen: false).userInfoData;
    getData();
    super.initState();
  }

  @override
  void dispose() {
    print('screen disposed');
    super.dispose();
  }

//   getLogic(){
//     DateTime now = DateTime.now();
//     print('this is now---$now');
//
//     for(int i=0;i<packageOrderData1!.items!.length;i++){
//
//
//       double val = packageOrderData1!.items![i].packageValidSeconds / 86400;
//       print('this is value--$val');
//       String days = val.toStringAsFixed(0);
//
//
//       DateTime apiTime=DateTime.parse(DateFormat('yyyy-MM-dd kk:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(packageOrderData1!.items![i].time)));
//
//       DateTime d = Jiffy(DateTime(apiTime.year,apiTime.month,apiTime.day, apiTime.hour,apiTime.minute,apiTime.second)).add(days: int.parse(days)).dateTime;
//
//
//       print('${d.compareTo(now)}');
//
//       if(d.compareTo(now)==1){
//         print('yes');
//         setState(() {
//           activePlanData.add(packageOrderData1!.items![i].packageName);
//           activePlanData.add(packageOrderData1!.items![i].total);
//           activePlanData.add(packageOrderData1!.items![i].packageValidSeconds);
//           activePlanData.add(packageOrderData1!.items![i].currency);
//           activePlanData.add(d);
//
//           print('active package is${activePlanData.length}');
//           print('active package is${packageOrderData1!.items![i].packageName}');
//         });
//       }
//
//
//       // if(now.isBefore(d)==true){
//       //   if(difference<int.parse(days)){
//       //     print('active add it');
//       //   }
//       // }
// }
//     if(activePlanData.isEmpty){
//       setState(() {
//         print('i get into package expired');
//         showNoData=true;
//         showLoader=true;
//       });
//     }
//
//   }

  // getData() async{
  //   Future.delayed(Duration.zero, () async {
  //     Provider.of<WifiProvider>(context, listen: false).wifiData.clear();
  //
  //     await Provider.of<WifiProvider>(context, listen: false)
  //         .callWifi()
  //         .then((value) {
  //       setState(() {
  //         if (value == "failed") {
  //           setState(() {
  //             showLoader = true;
  //           });
  //         } else {
  //           value.forEach((element) {
  //             if (element.name == "PLATINUM+" || element.name == "GOLD+") {
  //               recommendedDevices.add(element);
  //             }
  //             if (element.name == "PLATINUM" || element.name == "GOLD") {
  //               lovedDevices.add(element);
  //             }
  //             if (element.name == "CRYSTAL" ||
  //                 element.name == "BLUE" ||
  //                 element.name == "SILVER") {
  //               affordableDevices.add(element);
  //             }
  //           });
  //           wifiData.addAll(value);
  //         }
  //       });
  //     });
  //   });
  // }

  //final CarouselController _controller = CarouselController();
  // List _imgList = [
  // ];
  //int _current = 0;

  NavigationService navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return _connectedToInternet
        ? Consumer<WifiProvider>(builder: (context, i, _) {
            return _showLoader == null
                ? Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBarWithBackIconAndLanguage(
                      onTapIcon: () {
                        Navigator.pop(context);
                      },
                    ),
                    // appBar: AppBar(
                    //   toolbarHeight: ScreenSize.appbarHeight,
                    //   automaticallyImplyLeading: false,
                    //   elevation: 0,
                    //   leading: IconButton(
                    //     onPressed: (){
                    //       navigationService.closeScreen();
                    //     },
                    //     icon: Icon(Icons.arrow_back_ios),
                    //   ),
                    //   title: Text(
                    //     AppLocalizations.of(context)!.translate('wifi')!,
                    //     style: TextStyle(
                    //       fontSize: ScreenSize.appbarText,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //   ),
                    //   flexibleSpace: Container(
                    //     decoration: BoxDecoration(
                    //       gradient: LinearGradient(
                    //         colors: [
                    //           Color.fromRGBO(224, 69, 123, 1),
                    //           Color.fromRGBO(212, 69, 224, 1),
                    //         ],
                    //         stops: [0.5, 1.0],
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    body: _wifiPlanModel != null
                        ? Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .translate('wifi_plan')!,
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 40),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.1),
                                          border: Border.all(
                                              color: Color(0xFFFFEBF2)),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          children: [
                                            Visibility(
                                              visible: wifiFree,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      //color: Color(0xFFB99013),
                                                      gradient: LinearGradient(
                                                        colors: i.wifiPlanData!
                                                                    .packageName ==
                                                                "BLUE"
                                                            ? [
                                                                Color(
                                                                    0xFF5787E3),
                                                                Color(
                                                                    0xFF5787E3),
                                                              ]
                                                            : i.wifiPlanData!.packageName ==
                                                                        "PLATINUM+" ||
                                                                    i.wifiPlanData!.packageName ==
                                                                        "PLATINUM"
                                                                ? [
                                                                    Color(
                                                                        0xFF1A1A1A),
                                                                    Color(
                                                                        0xFF1A1A1A),
                                                                  ]
                                                                : i.wifiPlanData!
                                                                            .packageName ==
                                                                        "CRYSTAL"
                                                                    ? [
                                                                        Color(
                                                                            0xFF5787E3),
                                                                        Color(
                                                                            0xFF5787E3),
                                                                      ]
                                                                    : i.wifiPlanData!.packageName ==
                                                                            "SILVER"
                                                                        ? [
                                                                            Color(0xFFC8C5BD),
                                                                            Color(0xFF3D3C3A),
                                                                          ]
                                                                        : i.wifiPlanData!.packageName == "GOLD+" ||
                                                                                i.wifiPlanData!.packageName ==
                                                                                    "GOLD"
                                                                            ? [
                                                                                Color(0xFFF4C73E),
                                                                                Color(0xFFB99013),
                                                                              ]
                                                                            : i.wifiPlanData!.packageName == "CRYSTAL+" &&
                                                                                    i.wifiPlanData!.status ==
                                                                                        'inactive'
                                                                                ? [
                                                                                    Colors.grey,
                                                                                    Colors.grey
                                                                                  ]
                                                                                : [
                                                                                    Color(0xFF5787E3),
                                                                                    Color(0xFF5787E3),
                                                                                  ],
                                                        begin:
                                                            const FractionalOffset(
                                                                0.2, 0.0),
                                                        end:
                                                            const FractionalOffset(
                                                                1.1, 0.0),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(50.r),
                                                      ),
                                                    ),
                                                    // height: 30.h,
                                                    // width: 100.w,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10,
                                                          vertical: 10),
                                                      child: Row(
                                                        /*mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .center,*/
                                                        children: [
                                                          Image.asset(
                                                            i.wifiPlanData!
                                                                            .packageName ==
                                                                        "SILVER" ||
                                                                    i.wifiPlanData!
                                                                            .packageName ==
                                                                        "CRYSTAL" ||
                                                                    i.wifiPlanData!
                                                                            .packageName ==
                                                                        "BLUE" ||
                                                                    i.wifiPlanData!
                                                                            .packageName ==
                                                                        "CRYSTAL+"
                                                                ? "assets/images/wifi_icon.png"
                                                                : "assets/images/crown.png",
                                                            color: Colors.white,
                                                            height: 12,
                                                            // scale: 8,
                                                          ),
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                          Center(
                                                            child: Text(
                                                              i.wifiPlanData!
                                                                  .packageName!.replaceAll("_", " "),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 12.sp,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  i.wifiPlanData!.status ==
                                                          "active"
                                                      ? Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .verified_outlined,
                                                              color: Color(
                                                                  0xFF3FCC54),
                                                              size: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 3,
                                                            ),
                                                            Text(
                                                              'Active',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF3FCC54),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      : Text(
                                                          'Inactive',
                                                          style: TextStyle(
                                                            color: Colors.grey,
                                                          ),
                                                        ), /*Row(
                                                    children: [
                                                      Icon(
                                                        Icons.unpublished_outlined,
                                                        color: Colors.grey,
                                                        size: 18,
                                                      ),
                                                      SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        'Inactive',
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                        ),
                                                      )
                                                    ],
                                                  ),*/
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible: wifiFree,
                                              child: SizedBox(
                                                height: 20,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                wifiFree
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Package Name',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF757575),
                                                                fontSize: 12),
                                                          ),
                                                          Text(
                                                            '${i.wifiPlanData!.packageName!.replaceAll("_", " ")}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                          )
                                                        ],
                                                      )
                                                    : Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.grey,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                50.r),
                                                          ),
                                                        ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                                    child: Text('No Active Wifi Plan',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400),),
                                                  ),
                                                      ),
                                                Visibility(
                                                  visible: _userData!
                                                      .isCorporate!,
                                                  child: Image.network(
                                                    '${_userData!.siteLogo}',
                                                    height: 40.h,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Visibility(
                                              visible: wifiFree,
                                              child: Row(
                                                mainAxisAlignment: i.wifiPlanData!
                                                            .packagePrice ==
                                                        0.0
                                                    ? MainAxisAlignment.start
                                                    : MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Visibility(
                                                    visible: i.wifiPlanData!
                                                                .packagePrice ==
                                                            0.0
                                                        ? false
                                                        : true,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Price',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF757575)),
                                                        ),
                                                        Text(
                                                          '${i.wifiPlanData!.packageCurrency} ${i.wifiPlanData!.packagePrice!.toStringAsFixed(2)}',
                                                          style: TextStyle(
                                                              color: priceColor,
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Expiry Date',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xFF757575)),
                                                      ),
                                                      Visibility(
                                                        visible: i.wifiPlanData!
                                                                .expirationTime !=
                                                            null,
                                                        child: Text(
                                                          //'${i.wifiPlanData!.expirationTime}',
                                                          '${Jiffy(DateTime(i.wifiPlanData!.expirationTime![0], i.wifiPlanData!.expirationTime![1], i.wifiPlanData!.expirationTime![2])).yMMMMd}',
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible: wifiFree,
                                              child: SizedBox(
                                                height: 20,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Phone',
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFF757575)),
                                                    ),
                                                    Text(
                                                      '+${_userData!.uid}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                /* Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Validity',
                                                      style: TextStyle(
                                                          color: Color(0xFF757575)),
                                                    ),
                                                    Text(
                                                      //'${i.wifiPlanData!.expirationTime}',
                                                      '${Jiffy(DateTime(i.wifiPlanData!.expirationTime![0], i.wifiPlanData!.expirationTime![1], i.wifiPlanData!.expirationTime![2])).yMMMMd}',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                )*/
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainDashBoard(
                                                      selectedIndex:
                                                      1,
                                                    )));
                                      },
                                      child: Align(
                                        alignment:
                                        Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            'Need help? Reach us',
                                            style: TextStyle(
                                                color: Theme.of(
                                                    context)
                                                    .primaryColor),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    // Container(
                                    //   height: height * 0.32,
                                    //   width: width,
                                    //   decoration: BoxDecoration(
                                    //     color: Theme.of(context).primaryColor.withOpacity(0.1),
                                    //       border: Border.all(color: Color(0xFFFFEBF2)),
                                    //       borderRadius: BorderRadius.circular(12)),
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(20.0),
                                    //     child: Column(
                                    //       children: [
                                    //         Row(
                                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    //           children: [
                                    //             Container(
                                    //               decoration: BoxDecoration(
                                    //                 //color: Color(0xFFB99013),
                                    //
                                    //                 gradient: LinearGradient(
                                    //                   colors: i.wifiPlanData!.packageName == "BLUE" ? [Color(0xFF5787E3), Color(0xFF5787E3),]
                                    //                       : i.wifiPlanData!.packageName == "PLATINUM+"|| i.wifiPlanData!.packageName == "PLATINUM"? [Color(0xFF1A1A1A), Color(0xFF1A1A1A),]
                                    //                       : i.wifiPlanData!.packageName == "CRYSTAL" ? [Color(0xFF7BA2D0), Color(0xFFB4B7D8),]
                                    //                       : i.wifiPlanData!.packageName == "SILVER" ? [Color(0xFFC8C5BD), Color(0xFF3D3C3A),]
                                    //                       : i.wifiPlanData!.packageName == "GOLD+" ? [Color(0xFFF4C73E), Color(0xFFB99013),]
                                    //                       : [Color(0xFFEFC851), Color(0xFFFAD76D),],
                                    //                   begin:
                                    //                   const FractionalOffset(
                                    //                       0.2, 0.0),
                                    //                   end: const FractionalOffset(
                                    //                       1.1, 0.0),
                                    //                 ),
                                    //
                                    //
                                    //                 borderRadius: BorderRadius.all(
                                    //                   Radius.circular(50.r),
                                    //                 ),
                                    //               ),
                                    //               // height: 30.h,
                                    //               // width: 100.w,
                                    //               child: Padding(
                                    //                 padding: const EdgeInsets.only(left: 10,right: 10,top: 5.0,bottom: 5.0),
                                    //                 child: Row(
                                    //                   mainAxisAlignment:
                                    //                   MainAxisAlignment.center,
                                    //                   crossAxisAlignment:
                                    //                   CrossAxisAlignment.center,
                                    //                   children: [
                                    //                     Image.asset(
                                    //                       i.wifiPlanData!.packageName == "SILVER" || i.wifiPlanData!.packageName == "CRYSTAL" || i.wifiPlanData!.packageName == "BLUE" ? "assets/images/wifi_icon.png"
                                    //
                                    //                           : "assets/images/crown.png",
                                    //                       color: Colors.white,
                                    //                       height: 20,
                                    //                      // scale: 8,
                                    //                     ),
                                    //                     SizedBox(
                                    //                       width: 5.w,
                                    //                     ),
                                    //                     Text(
                                    //                       i.wifiPlanData!.packageName!,
                                    //                       style: TextStyle(
                                    //                         color: Colors.white,
                                    //                         fontWeight: FontWeight.w500,
                                    //                         fontSize: 12.sp,
                                    //                         height: 1.8,
                                    //                       ),
                                    //                       textAlign: TextAlign.center,
                                    //                     ),
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //             Row(
                                    //               children: [
                                    //                 Icon(
                                    //                   Icons.verified_outlined,
                                    //                   color: Color(0xFF3FCC54),
                                    //                 ),
                                    //                 SizedBox(
                                    //                   width: 3,
                                    //                 ),
                                    //                 Text(
                                    //                   'Active',
                                    //                   style: TextStyle(
                                    //                     color: Color(0xFF3FCC54),
                                    //                   ),
                                    //                 )
                                    //               ],
                                    //             ),
                                    //           ],
                                    //         ),
                                    //         SizedBox(
                                    //           height: 10.h,
                                    //         ),
                                    //         Row(
                                    //           mainAxisAlignment:
                                    //           MainAxisAlignment.spaceBetween,
                                    //           children: [
                                    //             Column(
                                    //               crossAxisAlignment:
                                    //               CrossAxisAlignment.start,
                                    //               children: [
                                    //                 Text(
                                    //                   'Package Name',
                                    //                   style: TextStyle(
                                    //                       color: Color(0xFF757575),
                                    //                       fontSize: 12),
                                    //                 ),
                                    //                 Text(
                                    //                   '${i.wifiPlanData!.packageName}',
                                    //                   style: TextStyle(
                                    //                       color: Colors.black,
                                    //                       fontWeight: FontWeight.bold,
                                    //                       fontSize: 18),
                                    //                 )
                                    //               ],
                                    //             ),
                                    //           ],
                                    //         ),
                                    //         SizedBox(
                                    //           height: 10.h,
                                    //         ),
                                    //         Row(
                                    //           children: [
                                    //             Container(
                                    //               height: height * 0.14,
                                    //               width: width / 2.24,
                                    //               //color: Colors.red,
                                    //               child: Column(
                                    //                 mainAxisAlignment:
                                    //                 MainAxisAlignment.spaceBetween,
                                    //                 crossAxisAlignment:
                                    //                 CrossAxisAlignment.start,
                                    //                 children: [
                                    //                   Column(
                                    //                     crossAxisAlignment:
                                    //                     CrossAxisAlignment.start,
                                    //                     children: [
                                    //                       Text(
                                    //                         'Price',
                                    //                         style: TextStyle(
                                    //                             color: Color(0xFF757575)),
                                    //                       ),
                                    //                       Text(
                                    //                         '${i.wifiPlanData!.packageCurrency} ${i.wifiPlanData!.packagePrice!.toStringAsFixed(2)}',
                                    //                         style: TextStyle(
                                    //                             color: priceColor,
                                    //                             fontSize: 17,
                                    //                             fontWeight: FontWeight.bold),
                                    //                       )
                                    //                     ],
                                    //                   ),
                                    //
                                    //                   // Column(
                                    //                   //   crossAxisAlignment:
                                    //                   //   CrossAxisAlignment.start,
                                    //                   //   children: [
                                    //                   //     Text(
                                    //                   //       'Price',
                                    //                   //       style: TextStyle(
                                    //                   //           color: Color(0xFF757575)),
                                    //                   //     ),
                                    //                   //     Text(
                                    //                   //       '${_packageOrderData1!.items![0].currency} ${_packageOrderData1!.items![0].total}',
                                    //                   //       style: TextStyle(
                                    //                   //           color: Color(0xFFE0457B)),
                                    //                   //     )
                                    //                   //   ],
                                    //                   // ),
                                    //                   Column(
                                    //                     crossAxisAlignment:
                                    //                     CrossAxisAlignment.start,
                                    //                     children: [
                                    //                       Text(
                                    //                         'Phone',
                                    //                         style: TextStyle(
                                    //                             color: Color(0xFF757575)),
                                    //                       ),
                                    //                       Text(
                                    //                         '+${i.wifiPlanData!.contactNumber}',
                                    //                         style: TextStyle(
                                    //                             color: Colors.black,
                                    //                             fontWeight: FontWeight.bold),
                                    //                       )
                                    //                     ],
                                    //                   ),
                                    //                 ],
                                    //               ),
                                    //             ),
                                    //             Container(
                                    //                 height: height * 0.14,
                                    //                // width: width / 2.24,
                                    //                 //color: Colors.green,
                                    //                 child: Column(
                                    //                   mainAxisAlignment:
                                    //                   MainAxisAlignment.spaceBetween,
                                    //                   crossAxisAlignment:
                                    //                   CrossAxisAlignment.start,
                                    //                   children: [
                                    //                     Column(
                                    //                       crossAxisAlignment:
                                    //                       CrossAxisAlignment.start,
                                    //                       children: [
                                    //                         Text(
                                    //                           'Expiry Date',
                                    //                           style: TextStyle(
                                    //                               color: Color(0xFF757575)),
                                    //                         ),
                                    //                         Text(
                                    //                           //'${i.wifiPlanData!.expirationTime}',
                                    //                           '${Jiffy(DateTime(i.wifiPlanData!.expirationTime![0], i.wifiPlanData!.expirationTime![1], i.wifiPlanData!.expirationTime![2])).yMMMMd}',
                                    //                           style: TextStyle(
                                    //                               color: Colors.black,
                                    //                               fontWeight:
                                    //                               FontWeight.bold),
                                    //                         )
                                    //                       ],
                                    //                     ),
                                    //                     // Column(
                                    //                     //   crossAxisAlignment:
                                    //                     //   CrossAxisAlignment.start,
                                    //                     //   children: [
                                    //                     //     Text(
                                    //                     //       'Address',
                                    //                     //       style: TextStyle(
                                    //                     //           color: Color(0xFF757575)),
                                    //                     //     ),
                                    //                     //     Text(
                                    //                     //       '${Provider.of<AuthProvider>(context, listen: false).userInfoData!.incomingZoneLabel}',
                                    //                     //       style: TextStyle(
                                    //                     //           color: Colors.black,
                                    //                     //           fontWeight:
                                    //                     //           FontWeight.bold),
                                    //                     //     )
                                    //                     //   ],
                                    //                     // ),
                                    //                   ],
                                    //                 ))
                                    //           ],
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),


                              Container(
                                height: double.infinity,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: CustomButton(
                                      height: 62,
                                      width: 500,
                                      text: wifiFree? 'UPGRADE NOW' : 'Get Wifi Now!',
                                      onPressed: () async {
                                        navigationService
                                            .navigateTo(WifiScreenRoute);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                            ),
                          ))
                : NoDataScreen(
                    title:
                        AppLocalizations.of(context)!.translate('wifi_plan')!,
                    desc: "Seems, there is no active wifi plan!",
                    buttontxt: "Get Wifi, Today!",
                    ontap: () async {
                      navigationService.navigateTo(WifiScreenRoute);
                    },
                  );
          })
        : NoInternet();
  }
}

// Container(
// padding: EdgeInsets.only(
// left: 10.w,
// right: 10.w,
// ),
// child: SingleChildScrollView(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
//
// SizedBox(
// height: 20.h,
// ),
//
//
// Container(
// height: height*0.32,
// width: width,
// decoration: BoxDecoration(
// border: Border.all(color: Color(0xFFFFEBF2)),
// borderRadius: BorderRadius.circular(12)
// ),
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Container(
// decoration: BoxDecoration(
// color: Color(0xFFB99013),
// borderRadius: BorderRadius.all(
// Radius.circular(50.r),
// ),
// ),
// height: 30.h,
// width: 100.w,
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.center,
// crossAxisAlignment:
// CrossAxisAlignment.center,
// children: [
// Image.asset(
// "assets/images/crown.png",
// color: Colors.white,
// height: 16.h,
// scale: 8,
// ),
// SizedBox(
// width: 5.w,
// ),
// Text(
// "${activePlanData[2]}",
// style: TextStyle(
// color: Colors.white,
// fontWeight: FontWeight.w500,
// fontSize: 12.sp,
// height: 1.8,
// ),
// textAlign: TextAlign.center,
// ),
// ],
// ),
// ),
// Row(
// children: [
// Icon(Icons.verified_outlined,color: Color(0xFF3FCC54),),
// SizedBox(width: 3,),
// Text('Active',style: TextStyle(color: Color(0xFF3FCC54),),)
// ],
// ),
//
// ],
// ),
// SizedBox(height: 10.h,),
//
//
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text('Package Name',style: TextStyle(color: Color(0xFF757575),fontSize: 12),),
// Text('${activePlanData[2]}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),)
// ],
// ),
//
// ],
// ),
// SizedBox(height: 10.h,),
// Row(
// children: [
// Container(
// height: height*0.14,
// width: width/2.24,
// //color: Colors.red,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text('Price',style: TextStyle(color: Color(0xFF757575)),),
// Text('${activePlanData[6]} ${activePlanData[3]}',style: TextStyle(color: Color(0xFFE0457B)),)
// ],
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text('Phone',style: TextStyle(color: Color(0xFF757575)),),
// Text('+971 3287 32788',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
// ],
// ),
//
// ],
// ),
// ),
//
//
// Container(
// height: height*0.14,
// width: width/2.24,
// //color: Colors.green,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text('Expiry Date',style: TextStyle(color: Color(0xFF757575)),),
// Text('${DateFormat('yyyy-MM-dd kk:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(activePlanData[5]))}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
// ],
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text('Address',style: TextStyle(color: Color(0xFF757575)),),
// Text('Dubai, UAE',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
// ],
// ),
// ],
// )
// )
// ],
// ),
//
//
//
// ],
// ),
// ),
// ),
//
//
//
// ],
// ),
// ),
// )
