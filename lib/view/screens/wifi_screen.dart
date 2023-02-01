import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/models/userinfo_model.dart';
import 'package:b2connect_flutter/model/models/wifi_package_model.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/screen_size.dart';
import 'package:b2connect_flutter/view/screens/main_dashboard_screen.dart';
import 'package:b2connect_flutter/view/widgets/no_data_screen.dart';
import 'package:b2connect_flutter/view/widgets/no_internet.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:b2connect_flutter/view_model/providers/pay_by_provider.dart';
import 'package:b2connect_flutter/view_model/providers/wifi_provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../model/utils/no_internet_dialog.dart';
import '../widgets/appBar_with_cart_notification_widget.dart';
import '../widgets/custom_buttons/gradiant_color_button.dart';
//import 'package:readmore/readmore.dart';

class WifiScreen extends StatefulWidget {
  WifiScreen({Key? key}) : super(key: key);

  @override
  _WifiScreenState createState() => _WifiScreenState();
}

class _WifiScreenState extends State<WifiScreen> {
  UserInfoModel? _userData;
  List<WifiModel> _upgradePlans = [];
  List<WifiModel> _corporatePlans = [];
  List<WifiModel> _singleNormalDevices = [];
  List<WifiModel> _multipleNormalDevices = [];

/*
  List<WifiModel> _singleCorporateDevices = [];
*/
/*
  List<WifiModel> _multipleCorporateDevices = [];
*/
  NavigationService _navigationService = locator<NavigationService>();

 /* bool _noWifiScreen = false;
*/
  String _value = 'All';
  String deviceAvailable = '';

  void handleClick(int item, double height) {
    switch (item) {
      case 0:
        setState(() {
          deviceAvailable = ' ';
          _value = 'All';
        });
        break;
      case 1:
        setState(() {
          deviceAvailable = ' ';
          _value = 'single';
          deviceAvailable = 'No Single Device Packages Available';
        });
        break;
      case 2:
        setState(() {
          deviceAvailable = ' ';
          _value = 'multiple';
          deviceAvailable = 'No Multiple Device Packages Available';
        });
        break;
    }
  }

  Future<void> getData() async {
    await NoInternetDialog.checkConnection().then((value) async {
      if (value) {
        await Provider.of<AuthProvider>(context, listen: false)
            .callUserInfo(context);
        _userData =
            Provider.of<AuthProvider>(context, listen: false).userInfoData;
        _upgradePlans.clear();
        _corporatePlans.clear();
        _singleNormalDevices.clear();
        _multipleNormalDevices.clear();
        Provider.of<WifiProvider>(context, listen: false).wifiData.clear();
      await  Provider.of<WifiProvider>(context, listen: false)
            .callWifi()
            .then((value) {
            if (value == "failed") {
              EasyLoading.showError('Something went wrong');

            } else {
              value.forEach((element) {
                if (element.isBase == true && element.isCorporate == true) {
                  _corporatePlans.add(element);
                }
              });
              value.forEach((element) {
                if (element.isBase == false && element.isCorporate == true) {
                  _upgradePlans.add(element);
                }
              });
              Provider.of<WifiProvider>(context, listen: false)
                  .wifiData
                  .forEach((element) {
                if (element.devices == 1 && element.isCorporate == false) {
                  _singleNormalDevices.add(element);
                } else if (element.devices == 2 &&
                    element.isCorporate == false) {
                  _multipleNormalDevices.add(element);
                }
              });
              EasyLoading.dismiss();
            }

        });
      } else {
        NoInternetDialog.getInternetAlert(newContext: context, popCount: 2);
      }
    });
  }

  void _onRefresh() async {
    await getData();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
EasyLoading.show(status: 'Please Wait...');
    getData();

    /* _noInternetDialog = NoInternetDialog(newContext: context, dataCalling: {Navigator.pop(context, false)});
    final networkConnection =  _noInternetDialog!.checkConnection();
    networkConnection? getData() : _noInternetDialog!.getInternetAlert();*/

    context.read<PayByProvider>().getPayByDeviceId();
    /*   _noInternetDialog.checkConnection(context).then((value) {
      if (value) {
        getData();
      } else {
        */ /*_noInternetDialog
            .getInternetAlert(getApi: getData(), context: context)
            .then((value) {
          if (value) {
            getData();
          }
        });*/ /*
      }
    });*/
    // _noInternetDialog.checkConnection(callApi: , context: context);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Consumer<WifiProvider>(builder: (context, index, _) {
      return index.noWifiAvailable == false
          ? Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                leading: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      _navigationService.closeScreen();
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                toolbarHeight: ScreenSize.appbarHeight,
                automaticallyImplyLeading: false,
                centerTitle: false,
                elevation: 0,
                title: Text(
                  AppLocalizations.of(context)!.translate('wifi')!,
                  style: TextStyle(
                    fontSize: ScreenSize.appbarText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                actions: [
                  Visibility(
                    visible: _singleNormalDevices.isNotEmpty ||
                        _multipleNormalDevices.isNotEmpty,
                    child: PopupMenuButton<int>(
                      icon: Image.asset(
                        'assets/images/filter_icon.png',
                        color: Colors.white,
                        height: 20,
                      ),
                      onSelected: (item) => handleClick(item, height),
                      itemBuilder: (context) => [
                        PopupMenuItem<int>(value: 0, child: Text('All')),
                        PopupMenuItem<int>(
                            value: 1, child: Text('Single Device')),
                        PopupMenuItem<int>(
                            value: 2, child: Text('Multiple Devices')),
                      ],
                    ),
                  ),
                ],
                flexibleSpace: Container(
                  decoration: BoxDecoration(gradient: gradientColor),
                ),
              ),
              body: index.wifiData.isNotEmpty
                  ? Container(
                      padding: EdgeInsets.all(15.h),
                      child: SmartRefresher(
                        controller: _refreshController,
                        onRefresh: _onRefresh,
                        //onLoading: _onLoading,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                visible: _corporatePlans.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      child: ListView.builder(
                                        itemCount: _corporatePlans.length,
                                        // addRepaintBoundaries: false,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),

                                        itemBuilder: (context, i) {
                                          double val =
                                              _corporatePlans[i].validity /
                                                  86400;
                                          print('this is value--$val');
                                          String abc = val.toStringAsFixed(0);

                                          var parts = _corporatePlans[i]
                                              .description
                                              .split('2');
                                          var prefix = parts[0].trim();

                                          return Column(
                                            children: [
                                              Container(
                                                width: width,
                                                height: height * 0.20,
                                                decoration: _userData!
                                                            .availableActivations ==
                                                        1
                                                    ? BoxDecoration(
                                                        color: Colors
                                                            .green.shade800,
                                                        //color: Color(0xFFE0457B),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(17))
                                                    : BoxDecoration(
                                                        color: Colors.grey,
                                                        //color: Color(0xFFE0457B),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(17)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: height * 0.14,
                                                        width: width,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        17)),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      12.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Validity',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize: 12),
                                                                      ),
                                                                      Text(
                                                                        "$abc days",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize:
                                                                                16,
                                                                            color: _userData!.availableActivations == 1
                                                                                ? Colors.green.shade800
                                                                                : Colors.grey),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 30,
                                                                    width: 1,
                                                                    color: Colors
                                                                            .grey[
                                                                        300],
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Limit',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize: 12),
                                                                      ),
                                                                      Text(
                                                                        '${_corporatePlans[i].devices.toString()} Device',
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize:
                                                                                16,
                                                                            color: _userData!.availableActivations == 1
                                                                                ? Colors.green.shade800
                                                                                : Colors.grey),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 30,
                                                                    width: 1,
                                                                    color: Colors
                                                                            .grey[
                                                                        300],
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Speed',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize: 12),
                                                                      ),
                                                                      Text(
                                                                        '${_corporatePlans[i].bandwidth} Mbps',
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize:
                                                                                16,
                                                                            color: _userData!.availableActivations == 1
                                                                                ? Colors.green.shade800
                                                                                : Colors.grey),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Container(
                                                                        child: Image
                                                                            .network(
                                                                          '${_userData!.siteLogo}',
                                                                          height:
                                                                              40.h,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  width * 0.9,
                                                              height: 1,
                                                              color: Colors
                                                                  .grey[300],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10.0,
                                                                      right: 10,
                                                                      top: 11),
                                                              child: Container(
                                                                width: width,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        gradient:
                                                                            LinearGradient(
                                                                          colors:
                                                                              // [Color(0xFF1A1A1A), Color(0xFF1A1A1A),],
                                                                              _corporatePlans[i].name == "BLUE"
                                                                                  ? [
                                                                                      Color(0xFF5787E3),
                                                                                      Color(0xFF5787E3),
                                                                                    ]
                                                                                  : _corporatePlans[i].name == "SILVER"
                                                                                      ? [
                                                                                          Color(0xFF3D3C3A),
                                                                                          Color(0xFFC8C5BD),
                                                                                        ]
                                                                                      : _corporatePlans[i].name == "GOLD+"
                                                                                          ? [
                                                                                              Color(0xFFF4C73E),
                                                                                              Color(0xFFB99013),
                                                                                            ]
                                                                                          : _corporatePlans[i].name == "GOLD"
                                                                                              ? [
                                                                                                  Color(0xFFF4C73E),
                                                                                                  Color(0xFFB99013),
                                                                                                ]
                                                                                              : _corporatePlans[i].name == "CRYSTAL" && _userData!.availableActivations == 1
                                                                                                  ? [
                                                                                                      Color(0xFF5787E3),
                                                                                                      Color(0xFF5787E3),
                                                                                                    ]
                                                                                                  : _corporatePlans[i].name == "CRYSTAL" && _userData!.availableActivations == 0
                                                                                                      ? [Colors.grey, Colors.grey]
                                                                                                      : _corporatePlans[i].name == "CRYSTAL+" && _userData!.availableActivations == 1
                                                                                                          ? [
                                                                                                              Color(0xFF5787E3),
                                                                                                              Color(0xFF5787E3),
                                                                                                            ]
                                                                                                          : [Colors.grey, Colors.grey],
                                                                          begin: const FractionalOffset(
                                                                              0.2,
                                                                              0.0),
                                                                          end: const FractionalOffset(
                                                                              1.1,
                                                                              0.0),
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius.circular(
                                                                              40.r),
                                                                        ),
                                                                      ),
                                                                      height:
                                                                          21.h,
                                                                      //width: 100.w,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            //_singleDevices[i].name,
                                                                            "${_corporatePlans[i].name}",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 10.sp,
                                                                              //height: 1.8,
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 12.0,
                                                                right: 12,
                                                                top: 5),
                                                        child: InkWell(
                                                          onTap: _userData!
                                                                      .availableActivations ==
                                                                  1
                                                              ? () async {
                                                                  EasyLoading.show(
                                                                      status: AppLocalizations.of(
                                                                              context)!
                                                                          .translate(
                                                                              'please_wait')!);
                                                                  await index
                                                                      .activateCorporateWifi()
                                                                      .then(
                                                                          (response) =>
                                                                              {
                                                                                if (response == 'Success')
                                                                                  {
                                                                                    setState(() async {
                                                                                      await Provider.of<AuthProvider>(context, listen: false).callUserInfo(context);
                                                                                      getData();
                                                                                    })
                                                                                  }
                                                                              });
                                                                }
                                                              : () {},
                                                          child: Container(
                                                            height:
                                                                height * 0.05,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'Default' /*'AED ${_corporatePlans[i].price.toStringAsFixed(2)}'*/,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  _userData!.availableActivations ==
                                                                          1
                                                                      ? 'Activate Now'
                                                                      : 'Activated' /*_corporatePlans[i].isPaymentEnabled ? 'Buy Now' : 'Activate Now'*/,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.03,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainDashBoard(
                                                      selectedIndex: 1,
                                                    )));
                                      },
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'Need help on ${_userData != null ? _userData!.availableActivations == 1 ? 'activation' : 'upgrade' : ''}?',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.03,
                                    )
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: _upgradePlans.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Upgrade',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      child: ListView.builder(
                                        itemCount: _upgradePlans.length,
                                        // addRepaintBoundaries: false,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),

                                        itemBuilder: (context, i) {
                                          double val =
                                              _upgradePlans[i].validity / 86400;
                                          print('this is value--$val');
                                          String abc = val.toStringAsFixed(0);

                                          var parts = _upgradePlans[i]
                                              .description
                                              .split('2');
                                          var prefix = parts[0].trim();

                                          return Column(
                                            children: [
                                              Container(
                                                width: width,
                                                height: height * 0.20,
                                                decoration: BoxDecoration(
                                                    gradient: gradientColor,
                                                    //color: Color(0xFFE0457B),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            17)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: height * 0.14,
                                                        width: width,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        17)),
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      12.0),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Validity',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize: 12),
                                                                      ),
                                                                      Text(
                                                                        "$abc days",
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 16),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 30,
                                                                    width: 1,
                                                                    color: Colors
                                                                            .grey[
                                                                        300],
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Limit',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize: 12),
                                                                      ),
                                                                      Text(
                                                                        '${_upgradePlans[i].devices.toString()} Device',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 16),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Container(
                                                                    height: 30,
                                                                    width: 1,
                                                                    color: Colors
                                                                            .grey[
                                                                        300],
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        'Speed',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize: 12),
                                                                      ),
                                                                      Text(
                                                                        '${_upgradePlans[i].bandwidth} Mbps',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 16),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width:
                                                                  width * 0.9,
                                                              height: 1,
                                                              color: Colors
                                                                  .grey[300],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          10.0,
                                                                      right: 10,
                                                                      top: 11),
                                                              child: Container(
                                                                width: width,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              10,
                                                                          right:
                                                                              10),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        gradient:
                                                                            LinearGradient(
                                                                          colors:
                                                                              // [Color(0xFF1A1A1A), Color(0xFF1A1A1A),],
                                                                              _upgradePlans[i].name == "BLUE"
                                                                                  ? [
                                                                                      Color(0xFF5787E3),
                                                                                      Color(0xFF5787E3),
                                                                                    ]
                                                                                  : _upgradePlans[i].name == "SILVER"
                                                                                      ? [
                                                                                          Color(0xFF3D3C3A),
                                                                                          Color(0xFFC8C5BD),
                                                                                        ]
                                                                                      : _upgradePlans[i].name == "GOLD+"
                                                                                          ? [
                                                                                              Color(0xFFF4C73E),
                                                                                              Color(0xFFB99013),
                                                                                            ]
                                                                                          : _upgradePlans[i].name == "GOLD"
                                                                                              ? [
                                                                                                  Color(0xFFF4C73E),
                                                                                                  Color(0xFFB99013),
                                                                                                ]
                                                                                              : _upgradePlans[i].name == "CRYSTAL"
                                                                                                  ? [
                                                                                                      Color(0xFFF19164),
                                                                                                      Color(0xFFF19164),
                                                                                                    ]
                                                                                                  : [
                                                                                                      Color(0xFF1A1A1A),
                                                                                                      Color(0xFF1A1A1A),
                                                                                                    ],
                                                                          begin: const FractionalOffset(
                                                                              0.2,
                                                                              0.0),
                                                                          end: const FractionalOffset(
                                                                              1.1,
                                                                              0.0),
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius.circular(
                                                                              40.r),
                                                                        ),
                                                                      ),
                                                                      height:
                                                                          21.h,
                                                                      //width: 100.w,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            //_singleDevices[i].name,
                                                                            "${_upgradePlans[i].name}",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 10.sp,
                                                                              //height: 1.8,
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 12.0,
                                                                right: 12,
                                                                top: 5),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            EasyLoading.show(
                                                                status: AppLocalizations.of(
                                                                        context)!
                                                                    .translate(
                                                                        'please_wait')!);
                                                            _upgradePlans[i]
                                                                    .isPaymentEnabled
                                                                ? await context
                                                                    .read<
                                                                        PayByProvider>()
                                                                    .payByPackageOrder(
                                                                        context,
                                                                        _upgradePlans[i]
                                                                            .id)
                                                                : await index
                                                                    .activateCorporateWifi();
                                                          },
                                                          child: Container(
                                                            height:
                                                                height * 0.05,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  'AED ${_upgradePlans[i].price.toStringAsFixed(2)}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  _upgradePlans[
                                                                              i]
                                                                          .isPaymentEnabled
                                                                      ? 'Buy Now'
                                                                      : 'Activate Now',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.03,
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: _singleNormalDevices.isNotEmpty ||
                                    _multipleNormalDevices.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    if (_value == 'single') ...[
                                      _singleNormalDevices.isNotEmpty
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .translate(
                                                          'single_device')!,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18.sp,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Container(
                                                  child: ListView.builder(
                                                    itemCount:
                                                        _singleNormalDevices
                                                            .length,
                                                    // addRepaintBoundaries: false,
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),

                                                    itemBuilder: (context, i) {
                                                      double val =
                                                          _singleNormalDevices[
                                                                      i]
                                                                  .validity /
                                                              86400;
                                                      print(
                                                          'this is value--$val');
                                                      String abc = val
                                                          .toStringAsFixed(0);

                                                      var parts =
                                                          _singleNormalDevices[
                                                                  i]
                                                              .description
                                                              .split('2');
                                                      var prefix =
                                                          parts[0].trim();

                                                      return Column(
                                                        children: [
                                                          Container(
                                                            width: width,
                                                            height:
                                                                height * 0.20,
                                                            decoration:
                                                                BoxDecoration(
                                                                    gradient:
                                                                        gradientColor,
                                                                    //color: Color(0xFFE0457B),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            17)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(1.0),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        height *
                                                                            0.14,
                                                                    width:
                                                                        width,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(17)),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(12.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    'Validity',
                                                                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                  ),
                                                                                  Text(
                                                                                    "$abc days",
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Container(
                                                                                height: 30,
                                                                                width: 1,
                                                                                color: Colors.grey[300],
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    'Limit',
                                                                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                  ),
                                                                                  Text(
                                                                                    '${_singleNormalDevices[i].devices.toString()} Device',
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Container(
                                                                                height: 30,
                                                                                width: 1,
                                                                                color: Colors.grey[300],
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    'Speed',
                                                                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                  ),
                                                                                  Text(
                                                                                    '${_singleNormalDevices[i].bandwidth} Mbps',
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              width * 0.9,
                                                                          height:
                                                                              1,
                                                                          color:
                                                                              Colors.grey[300],
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 10.0,
                                                                              right: 10,
                                                                              top: 11),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                width,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                // Container(
                                                                                //   height: height * 0.05,
                                                                                //   width: width*0.55,
                                                                                //   //color: Colors.green,
                                                                                //   child: //ReadMore
                                                                                //   Text(
                                                                                //     prefix,
                                                                                //     overflow: TextOverflow.ellipsis,
                                                                                //     maxLines: 3,
                                                                                //     style: TextStyle(fontSize: 12),
                                                                                //   ),
                                                                                // ),

                                                                                Container(
                                                                                  padding: EdgeInsets.only(left: 10, right: 10),
                                                                                  decoration: BoxDecoration(
                                                                                    gradient: LinearGradient(
                                                                                      colors:
                                                                                          // [Color(0xFF1A1A1A), Color(0xFF1A1A1A),],
                                                                                          _singleNormalDevices[i].name == "BLUE"
                                                                                              ? [
                                                                                                  Color(0xFF5787E3),
                                                                                                  Color(0xFF5787E3),
                                                                                                ]
                                                                                              : _singleNormalDevices[i].name == "SILVER"
                                                                                                  ? [
                                                                                                      Color(0xFF3D3C3A),
                                                                                                      Color(0xFFC8C5BD),
                                                                                                    ]
                                                                                                  : _singleNormalDevices[i].name == "GOLD+"
                                                                                                      ? [
                                                                                                          Color(0xFFF4C73E),
                                                                                                          Color(0xFFB99013),
                                                                                                        ]
                                                                                                      : _singleNormalDevices[i].name == "GOLD"
                                                                                                          ? [
                                                                                                              Color(0xFFF4C73E),
                                                                                                              Color(0xFFB99013),
                                                                                                            ]
                                                                                                          : _singleNormalDevices[i].name == "CRYSTAL"
                                                                                                              ? [
                                                                                                                  Color(0xFFF19164),
                                                                                                                  Color(0xFFF19164),
                                                                                                                ]
                                                                                                              : [
                                                                                                                  Color(0xFF1A1A1A),
                                                                                                                  Color(0xFF1A1A1A),
                                                                                                                ],
                                                                                      begin: const FractionalOffset(0.2, 0.0),
                                                                                      end: const FractionalOffset(1.1, 0.0),
                                                                                    ),

                                                                                    // color: lovedDevices[i].name == "GOLD" ? Color(0xFFB99013)
                                                                                    //     :lovedDevices[i].name == "PLATINUM"? Color(0xFF1A1A1A)
                                                                                    //     :lovedDevices[i].name == "BLUE"?Color(0xFF5787E3):Color(0xFFC8C5BD),

                                                                                    borderRadius: BorderRadius.all(
                                                                                      Radius.circular(40.r),
                                                                                    ),
                                                                                  ),
                                                                                  height: 21.h,
                                                                                  //width: 100.w,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: [
                                                                                      /* Image.asset(
                                                                        _singleDevices[i].name == "GOLD" || _singleDevices[i].name == "GOLD+" || _singleDevices[i].name == "PLATINUM" || _singleDevices[i].name == "PLATINUM+" ? "assets/images/crown.png"
                                                                            :
                                                                        "assets/images/wifi_icon.png",
                                                                        color: Colors.white,
                                                                        height: 11.h,
                                                                        // scale: 8,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 5.w,
                                                                      ),*/
                                                                                      Text(
                                                                                        //_singleDevices[i].name,
                                                                                        "${_singleNormalDevices[i].name}",
                                                                                        style: TextStyle(
                                                                                          color: Colors.white,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontSize: 10.sp,
                                                                                          //height: 1.8,
                                                                                        ),
                                                                                        textAlign: TextAlign.center,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            12.0,
                                                                        right:
                                                                            12,
                                                                        top: 5),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        /* Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => PaymentMethod(
                                                                  price: '${_singleDevices[i].price.toStringAsFixed(2)}',
                                                                  id: _singleDevices[i].id,
                                                                  comingFrom: false,
                                                                )));*/
                                                                        EasyLoading.show(
                                                                            status:
                                                                                AppLocalizations.of(context)!.translate('please_wait')!);
                                                                        await context.read<PayByProvider>().payByPackageOrder(
                                                                            context,
                                                                            _singleNormalDevices[i].id);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height: height *
                                                                            0.05,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              'AED ${_singleNormalDevices[i].price.toStringAsFixed(2)}',
                                                                              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Text(
                                                                              'Buy Now',
                                                                              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                height * 0.03,
                                                          )
                                                        ],
                                                      );

                                                      //   Card(
                                                      //   elevation: 0,
                                                      //   shape: RoundedRectangleBorder(
                                                      //     side: BorderSide(
                                                      //       color: Colors.grey.shade300,
                                                      //       width: 1.w,
                                                      //     ),
                                                      //     borderRadius: BorderRadius.circular(10),
                                                      //   ),
                                                      //   // decoration: BoxDecoration(
                                                      //   //   borderRadius: BorderRadius.circular(10),
                                                      //   //   border: Border.all()
                                                      //   // ),
                                                      //   child: Column(
                                                      //     crossAxisAlignment: CrossAxisAlignment.start,
                                                      //     children: [
                                                      //       Container(
                                                      //         // width: double.infinity,
                                                      //         // height: 120.h,
                                                      //         decoration: BoxDecoration(
                                                      //           color: Colors.pink.shade50,
                                                      //           borderRadius: BorderRadius.only(
                                                      //             topLeft: Radius.circular(10.r),
                                                      //             topRight: Radius.circular(10.r),
                                                      //           ),
                                                      //         ),
                                                      //         child: Padding(
                                                      //           padding: EdgeInsets.all(8.0.h),
                                                      //           child: Column(
                                                      //             crossAxisAlignment:
                                                      //             CrossAxisAlignment.start,
                                                      //             children: [
                                                      //               Row(
                                                      //                 children: [
                                                      //                   Container(
                                                      //                     padding: EdgeInsets.only(left: 10,right: 10),
                                                      //                     decoration: BoxDecoration(
                                                      //                       gradient: LinearGradient(
                                                      //                         colors:
                                                      //                         _singleDevices[i].name == "BLUE" ? [Color(0xFF5787E3), Color(0xFF5787E3),]
                                                      //                             : _singleDevices[i].name == "SILVER" ? [Color(0xFF3D3C3A), Color(0xFFC8C5BD),]
                                                      //                             : _singleDevices[i].name == "GOLD+" ? [Color(0xFFF4C73E), Color(0xFFB99013),]
                                                      //                             : _singleDevices[i].name == "GOLD" ?   [Color(0xFFF4C73E), Color(0xFFB99013),]
                                                      //                             :_singleDevices[i].name == "CRYSTAL" ?  [Color(0xFFF19164), Color(0xFFF19164),]
                                                      //                             : [Color(0xFF1A1A1A), Color(0xFF1A1A1A),],
                                                      //                         begin: const FractionalOffset(
                                                      //                             0.2, 0.0),
                                                      //                         end: const FractionalOffset(
                                                      //                             1.1, 0.0),
                                                      //                       ),
                                                      //
                                                      //                       // color: lovedDevices[i].name == "GOLD" ? Color(0xFFB99013)
                                                      //                       //     :lovedDevices[i].name == "PLATINUM"? Color(0xFF1A1A1A)
                                                      //                       //     :lovedDevices[i].name == "BLUE"?Color(0xFF5787E3):Color(0xFFC8C5BD),
                                                      //
                                                      //                       borderRadius: BorderRadius.all(
                                                      //                         Radius.circular(50.r),
                                                      //                       ),
                                                      //                     ),
                                                      //                     height: 30.h,
                                                      //                     //width: 100.w,
                                                      //                     child: Row(
                                                      //                       mainAxisAlignment: MainAxisAlignment.center,
                                                      //                       crossAxisAlignment: CrossAxisAlignment.center,
                                                      //                       children: [
                                                      //                         Image.asset(
                                                      //                           _singleDevices[i].name == "GOLD" || _singleDevices[i].name == "GOLD+" || _singleDevices[i].name == "PLATINUM" || _singleDevices[i].name == "PLATINUM+" ? "assets/images/crown.png"
                                                      //                               : "assets/images/wifi_icon.png",
                                                      //                           color: Colors.white,
                                                      //                           height: 16.h,
                                                      //                           scale: 8,
                                                      //                         ),
                                                      //                         SizedBox(
                                                      //                           width: 5.w,
                                                      //                         ),
                                                      //                         Text(
                                                      //                           _singleDevices[i].name,
                                                      //                           style: TextStyle(
                                                      //                             color: Colors.white,
                                                      //                             fontWeight: FontWeight.w500,
                                                      //                             fontSize: 12.sp,
                                                      //                             height: 1.8,
                                                      //                           ),
                                                      //                           textAlign: TextAlign.center,
                                                      //                         ),
                                                      //                       ],
                                                      //                     ),
                                                      //                   ),
                                                      //                 ],
                                                      //               ),
                                                      //               SizedBox(
                                                      //                 height: 5,
                                                      //               ),
                                                      //               Container(
                                                      //                 height: height * 0.07,
                                                      //                 child: //ReadMore
                                                      //                 Text(
                                                      //                   prefix,
                                                      //                   overflow: TextOverflow.clip,
                                                      //                   maxLines: 3,
                                                      //                   style: TextStyle(fontSize: 12),
                                                      //                 ),
                                                      //               ),
                                                      //               SizedBox(
                                                      //                 height: 7.h,
                                                      //               ),
                                                      //               Text(
                                                      //                 "${_singleDevices[i].price.toString()} AED",
                                                      //                 style: TextStyle(
                                                      //                   fontSize: 28.sp,
                                                      //                   fontWeight: FontWeight.w600,
                                                      //                 ),
                                                      //               )
                                                      //             ],
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //       SizedBox(
                                                      //         height: 20.h,
                                                      //       ),
                                                      //       Padding(
                                                      //         padding: EdgeInsets.only(
                                                      //           left: 10.w,
                                                      //           right: 10.w,
                                                      //         ),
                                                      //         child: Row(
                                                      //           mainAxisAlignment:
                                                      //           MainAxisAlignment.spaceBetween,
                                                      //           children: [
                                                      //             Text(
                                                      //               "Validity",
                                                      //               style: TextStyle(
                                                      //                 color: Colors.grey.shade500,
                                                      //                 fontSize: 12.sp,
                                                      //               ),
                                                      //             ),
                                                      //             Text(
                                                      //               "$abc days",
                                                      //               style: TextStyle(
                                                      //                 color: Colors.black,
                                                      //                 fontWeight: FontWeight.w400,
                                                      //                 fontSize: 12.sp,
                                                      //               ),
                                                      //             ),
                                                      //           ],
                                                      //         ),
                                                      //       ),
                                                      //       SizedBox(
                                                      //         height: 10.h,
                                                      //       ),
                                                      //       Padding(
                                                      //         padding: EdgeInsets.only(
                                                      //           left: 10.w,
                                                      //           right: 10.w,
                                                      //         ),
                                                      //         child: Row(
                                                      //           mainAxisAlignment:
                                                      //           MainAxisAlignment.spaceBetween,
                                                      //           children: [
                                                      //             Text(
                                                      //               "# of Devices",
                                                      //               style: TextStyle(
                                                      //                 color: Colors.grey.shade500,
                                                      //                 fontSize: 12.sp,
                                                      //               ),
                                                      //             ),
                                                      //             Text(
                                                      //               "${_singleDevices[i].devices.toString()}",
                                                      //               style: TextStyle(
                                                      //                 color: Colors.black,
                                                      //                 fontWeight: FontWeight.w400,
                                                      //                 fontSize: 12.sp,
                                                      //               ),
                                                      //             ),
                                                      //           ],
                                                      //         ),
                                                      //       ),
                                                      //       SizedBox(
                                                      //         height: 10.h,
                                                      //       ),
                                                      //       Padding(
                                                      //         padding: EdgeInsets.only(
                                                      //           left: 10.w,
                                                      //           right: 10.w,
                                                      //         ),
                                                      //         child: Row(
                                                      //           mainAxisAlignment:
                                                      //           MainAxisAlignment.spaceBetween,
                                                      //           children: [
                                                      //             Text(
                                                      //               "Speed upto",
                                                      //               style: TextStyle(
                                                      //                 color: Colors.grey.shade500,
                                                      //                 fontSize: 12.sp,
                                                      //               ),
                                                      //             ),
                                                      //             Text(
                                                      //               "${_singleDevices[i].bandwidth.toString()}Mbps",
                                                      //               style: TextStyle(
                                                      //                 color: Colors.black,
                                                      //                 fontWeight: FontWeight.w400,
                                                      //                 fontSize: 12.sp,
                                                      //               ),
                                                      //             ),
                                                      //           ],
                                                      //         ),
                                                      //       ),
                                                      //       SizedBox(
                                                      //         height: 10.h,
                                                      //       ),
                                                      //       Divider(),
                                                      //       Container(
                                                      //         height:45,
                                                      //         //color:Colors.red,
                                                      //         child: Center(
                                                      //           child: CustomButton(
                                                      //             height: 40.h,
                                                      //             width: 140.w,
                                                      //             onPressed: () {
                                                      //               Navigator.push(
                                                      //                   context,
                                                      //                   MaterialPageRoute(
                                                      //                       builder: (context) => PaymentMethod(
                                                      //                         price: _singleDevices[i].price.toString(),
                                                      //                         id: _singleDevices[i].id.toString(),
                                                      //                       )));
                                                      //             },
                                                      //             text: AppLocalizations.of(context)!
                                                      //                 .translate('buy_now')!,
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //
                                                      //     ],
                                                      //   ),
                                                      // );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Text('$deviceAvailable'),
                                    ] else if (_value == 'multiple') ...[
                                      _multipleNormalDevices.isNotEmpty
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .translate(
                                                          'multiple_device')!,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18.sp,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Container(
                                                  child: ListView.builder(
                                                    itemCount:
                                                        _multipleNormalDevices
                                                            .length,
                                                    // addRepaintBoundaries: false,
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),

                                                    itemBuilder: (context, i) {
                                                      double val =
                                                          _multipleNormalDevices[
                                                                      i]
                                                                  .validity /
                                                              86400;
                                                      print(
                                                          'this is value--$val');
                                                      String abc = val
                                                          .toStringAsFixed(0);

                                                      var parts =
                                                          _multipleNormalDevices[
                                                                  i]
                                                              .description
                                                              .split('2');
                                                      var prefix =
                                                          parts[0].trim();

                                                      return Column(
                                                        children: [
                                                          Container(
                                                            width: width,
                                                            height:
                                                                height * 0.20,
                                                            decoration: BoxDecoration(
                                                                gradient:
                                                                    gradientColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            17)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(1.0),
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        height *
                                                                            0.14,
                                                                    width:
                                                                        width,
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        borderRadius:
                                                                            BorderRadius.circular(17)),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(12.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    'Validity',
                                                                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                  ),
                                                                                  Text(
                                                                                    "$abc days",
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Container(
                                                                                height: 30,
                                                                                width: 1,
                                                                                color: Colors.grey[300],
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    'Limit',
                                                                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                  ),
                                                                                  Text(
                                                                                    '${_multipleNormalDevices[i].devices.toString()} Devices',
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Container(
                                                                                height: 30,
                                                                                width: 1,
                                                                                color: Colors.grey[300],
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Text(
                                                                                    'Speed',
                                                                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                  ),
                                                                                  Text(
                                                                                    '${_multipleNormalDevices[i].bandwidth} Mbps',
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              width * 0.9,
                                                                          height:
                                                                              1,
                                                                          color:
                                                                              Colors.grey[300],
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              left: 10.0,
                                                                              right: 10,
                                                                              top: 11),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                width,
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                // Container(
                                                                                //   height: height * 0.05,
                                                                                //   width: width*0.55,
                                                                                //   //color: Colors.green,
                                                                                //   child: //ReadMore
                                                                                //   Text(
                                                                                //     prefix,
                                                                                //     overflow: TextOverflow.ellipsis,
                                                                                //     maxLines: 3,
                                                                                //     style: TextStyle(fontSize: 12),
                                                                                //   ),
                                                                                // ),

                                                                                Container(
                                                                                  padding: EdgeInsets.only(left: 10, right: 10),
                                                                                  decoration: BoxDecoration(
                                                                                    gradient: LinearGradient(
                                                                                      colors:
                                                                                          // [Color(0xFF1A1A1A), Color(0xFF1A1A1A),],
                                                                                          _multipleNormalDevices[i].name == "BLUE"
                                                                                              ? [
                                                                                                  Color(0xFF5787E3),
                                                                                                  Color(0xFF5787E3),
                                                                                                ]
                                                                                              : _multipleNormalDevices[i].name == "SILVER"
                                                                                                  ? [
                                                                                                      Color(0xFF3D3C3A),
                                                                                                      Color(0xFFC8C5BD),
                                                                                                    ]
                                                                                                  : _multipleNormalDevices[i].name == "GOLD+"
                                                                                                      ? [
                                                                                                          Color(0xFFF4C73E),
                                                                                                          Color(0xFFB99013),
                                                                                                        ]
                                                                                                      : _multipleNormalDevices[i].name == "GOLD"
                                                                                                          ? [
                                                                                                              Color(0xFFF4C73E),
                                                                                                              Color(0xFFB99013),
                                                                                                            ]
                                                                                                          : _multipleNormalDevices[i].name == "CRYSTAL"
                                                                                                              ? [
                                                                                                                  Color(0xFFF19164),
                                                                                                                  Color(0xFFF19164),
                                                                                                                ]
                                                                                                              : [
                                                                                                                  Color(0xFF1A1A1A),
                                                                                                                  Color(0xFF1A1A1A),
                                                                                                                ],
                                                                                      begin: const FractionalOffset(0.2, 0.0),
                                                                                      end: const FractionalOffset(1.1, 0.0),
                                                                                    ),

                                                                                    // color: lovedDevices[i].name == "GOLD" ? Color(0xFFB99013)
                                                                                    //     :lovedDevices[i].name == "PLATINUM"? Color(0xFF1A1A1A)
                                                                                    //     :lovedDevices[i].name == "BLUE"?Color(0xFF5787E3):Color(0xFFC8C5BD),

                                                                                    borderRadius: BorderRadius.all(
                                                                                      Radius.circular(40.r),
                                                                                    ),
                                                                                  ),
                                                                                  height: 21.h,
                                                                                  //width: 100.w,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(
                                                                                        //_singleDevices[i].name,
                                                                                        "${_multipleNormalDevices[i].name}",
                                                                                        style: TextStyle(
                                                                                          color: Colors.white,
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontSize: 10.sp,
                                                                                          //height: 1.8,
                                                                                        ),
                                                                                        textAlign: TextAlign.center,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            12.0,
                                                                        right:
                                                                            12),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () async {
                                                                        EasyLoading.show(
                                                                            status:
                                                                                AppLocalizations.of(context)!.translate('please_wait')!);
                                                                        await context.read<PayByProvider>().payByPackageOrder(
                                                                            context,
                                                                            _multipleNormalDevices[i].id);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height: height *
                                                                            0.05,
                                                                        //color: Colors.green,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              'AED ${_multipleNormalDevices[i].price.toStringAsFixed(2)}',
                                                                              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Text(
                                                                              'Buy Now',
                                                                              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                height * 0.03,
                                                          )
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Text('$deviceAvailable'),
                                    ] else ...[
                                      _singleNormalDevices.isNotEmpty
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .translate(
                                                          'single_device')!,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18.sp,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Container(
                                                  child: AnimationLimiter(
                                                    child: ListView.builder(
                                                      itemCount:
                                                          _singleNormalDevices
                                                              .length,
                                                      // addRepaintBoundaries: false,
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),

                                                      itemBuilder:
                                                          (context, i) {
                                                        double val =
                                                            _singleNormalDevices[
                                                                        i]
                                                                    .validity /
                                                                86400;
                                                        print(
                                                            'this is value--$val');
                                                        String abc = val
                                                            .toStringAsFixed(0);

                                                        var parts =
                                                            _singleNormalDevices[
                                                                    i]
                                                                .description
                                                                .split('2');
                                                        var prefix =
                                                            parts[0].trim();

                                                        return AnimationConfiguration
                                                            .staggeredList(
                                                          position: i,
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      1000),
                                                          child: ScaleAnimation(
                                                            scale: 1,
                                                            child:
                                                                FlipAnimation(
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    width:
                                                                        width,
                                                                    height:
                                                                        height *
                                                                            0.20,
                                                                    decoration: BoxDecoration(
                                                                        gradient: gradientColor,
                                                                        //color: Color(0xFFE0457B),
                                                                        borderRadius: BorderRadius.circular(17)),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              1.0),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                height * 0.14,
                                                                            width:
                                                                                width,
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17)),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(12.0),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(
                                                                                            'Validity',
                                                                                            style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                          ),
                                                                                          Text(
                                                                                            "$abc days",
                                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Container(
                                                                                        height: 30,
                                                                                        width: 1,
                                                                                        color: Colors.grey[300],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(
                                                                                            'Limit',
                                                                                            style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                          ),
                                                                                          Text(
                                                                                            '${_singleNormalDevices[i].devices.toString()} Device',
                                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Container(
                                                                                        height: 30,
                                                                                        width: 1,
                                                                                        color: Colors.grey[300],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(
                                                                                            'Speed',
                                                                                            style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                          ),
                                                                                          Text(
                                                                                            '${_singleNormalDevices[i].bandwidth} Mbps',
                                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: width * 0.9,
                                                                                  height: 1,
                                                                                  color: Colors.grey[300],
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 10.0, right: 10, top: 11),
                                                                                  child: Container(
                                                                                    width: width,
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        // Container(
                                                                                        //   height: height * 0.05,
                                                                                        //   width: width*0.55,
                                                                                        //   //color: Colors.green,
                                                                                        //   child: //ReadMore
                                                                                        //   Text(
                                                                                        //     prefix,
                                                                                        //     overflow: TextOverflow.ellipsis,
                                                                                        //     maxLines: 3,
                                                                                        //     style: TextStyle(fontSize: 12),
                                                                                        //   ),
                                                                                        // ),

                                                                                        Container(
                                                                                          padding: EdgeInsets.only(left: 10, right: 10),
                                                                                          decoration: BoxDecoration(
                                                                                            gradient: LinearGradient(
                                                                                              colors:
                                                                                                  // [Color(0xFF1A1A1A), Color(0xFF1A1A1A),],
                                                                                                  _singleNormalDevices[i].name == "BLUE"
                                                                                                      ? [
                                                                                                          Color(0xFF5787E3),
                                                                                                          Color(0xFF5787E3),
                                                                                                        ]
                                                                                                      : _singleNormalDevices[i].name == "SILVER"
                                                                                                          ? [
                                                                                                              Color(0xFF3D3C3A),
                                                                                                              Color(0xFFC8C5BD),
                                                                                                            ]
                                                                                                          : _singleNormalDevices[i].name == "GOLD+"
                                                                                                              ? [
                                                                                                                  Color(0xFFF4C73E),
                                                                                                                  Color(0xFFB99013),
                                                                                                                ]
                                                                                                              : _singleNormalDevices[i].name == "GOLD"
                                                                                                                  ? [
                                                                                                                      Color(0xFFF4C73E),
                                                                                                                      Color(0xFFB99013),
                                                                                                                    ]
                                                                                                                  : _singleNormalDevices[i].name == "CRYSTAL"
                                                                                                                      ? [
                                                                                                                          Color(0xFFF19164),
                                                                                                                          Color(0xFFF19164),
                                                                                                                        ]
                                                                                                                      : [
                                                                                                                          Color(0xFF1A1A1A),
                                                                                                                          Color(0xFF1A1A1A),
                                                                                                                        ],
                                                                                              begin: const FractionalOffset(0.2, 0.0),
                                                                                              end: const FractionalOffset(1.1, 0.0),
                                                                                            ),

                                                                                            // color: lovedDevices[i].name == "GOLD" ? Color(0xFFB99013)
                                                                                            //     :lovedDevices[i].name == "PLATINUM"? Color(0xFF1A1A1A)
                                                                                            //     :lovedDevices[i].name == "BLUE"?Color(0xFF5787E3):Color(0xFFC8C5BD),

                                                                                            borderRadius: BorderRadius.all(
                                                                                              Radius.circular(40.r),
                                                                                            ),
                                                                                          ),
                                                                                          height: 21.h,
                                                                                          //width: 100.w,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              /*  Image.asset(
                                                                                  _singleDevices[i].name == "GOLD" || _singleDevices[i].name == "GOLD+" || _singleDevices[i].name == "PLATINUM" || _singleDevices[i].name == "PLATINUM+" ? "assets/images/crown.png"
                                                                                      :
                                                                                  "assets/images/wifi_icon.png",
                                                                                  color: Colors.white,
                                                                                  height: 11.h,
                                                                                  // scale: 8,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5.w,
                                                                                ),*/
                                                                                              Text(
                                                                                                //_singleDevices[i].name,
                                                                                                "${_singleNormalDevices[i].name}",
                                                                                                style: TextStyle(
                                                                                                  color: Colors.white,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                  fontSize: 10.sp,
                                                                                                  //height: 1.8,
                                                                                                ),
                                                                                                textAlign: TextAlign.center,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(
                                                                                left: 12.0,
                                                                                right: 12,
                                                                                top: 5),
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () async {
                                                                                /* Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => PaymentMethod(
                                                                          price: '${_singleDevices[i].price.toStringAsFixed(2)}',
                                                                          id: _singleDevices[i].id,
                                                                          comingFrom: false,
                                                                        )));*/
                                                                                EasyLoading.show(status: AppLocalizations.of(context)!.translate('please_wait')!);
                                                                                await context.read<PayByProvider>().payByPackageOrder(context, _singleNormalDevices[i].id);
                                                                              },
                                                                              child: Container(
                                                                                height: height * 0.05,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Text(
                                                                                      'AED ${_singleNormalDevices[i].price.toStringAsFixed(2)}',
                                                                                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    Text(
                                                                                      'Buy Now',
                                                                                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        height *
                                                                            0.03,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );

                                                        //   Card(
                                                        //   elevation: 0,
                                                        //   shape: RoundedRectangleBorder(
                                                        //     side: BorderSide(
                                                        //       color: Colors.grey.shade300,
                                                        //       width: 1.w,
                                                        //     ),
                                                        //     borderRadius: BorderRadius.circular(10),
                                                        //   ),
                                                        //   // decoration: BoxDecoration(
                                                        //   //   borderRadius: BorderRadius.circular(10),
                                                        //   //   border: Border.all()
                                                        //   // ),
                                                        //   child: Column(
                                                        //     crossAxisAlignment: CrossAxisAlignment.start,
                                                        //     children: [
                                                        //       Container(
                                                        //         // width: double.infinity,
                                                        //         // height: 120.h,
                                                        //         decoration: BoxDecoration(
                                                        //           color: Colors.pink.shade50,
                                                        //           borderRadius: BorderRadius.only(
                                                        //             topLeft: Radius.circular(10.r),
                                                        //             topRight: Radius.circular(10.r),
                                                        //           ),
                                                        //         ),
                                                        //         child: Padding(
                                                        //           padding: EdgeInsets.all(8.0.h),
                                                        //           child: Column(
                                                        //             crossAxisAlignment:
                                                        //             CrossAxisAlignment.start,
                                                        //             children: [
                                                        //               Row(
                                                        //                 children: [
                                                        //                   Container(
                                                        //                     padding: EdgeInsets.only(left: 10,right: 10),
                                                        //                     decoration: BoxDecoration(
                                                        //                       gradient: LinearGradient(
                                                        //                         colors:
                                                        //                         _singleDevices[i].name == "BLUE" ? [Color(0xFF5787E3), Color(0xFF5787E3),]
                                                        //                             : _singleDevices[i].name == "SILVER" ? [Color(0xFF3D3C3A), Color(0xFFC8C5BD),]
                                                        //                             : _singleDevices[i].name == "GOLD+" ? [Color(0xFFF4C73E), Color(0xFFB99013),]
                                                        //                             : _singleDevices[i].name == "GOLD" ?   [Color(0xFFF4C73E), Color(0xFFB99013),]
                                                        //                             :_singleDevices[i].name == "CRYSTAL" ?  [Color(0xFFF19164), Color(0xFFF19164),]
                                                        //                             : [Color(0xFF1A1A1A), Color(0xFF1A1A1A),],
                                                        //                         begin: const FractionalOffset(
                                                        //                             0.2, 0.0),
                                                        //                         end: const FractionalOffset(
                                                        //                             1.1, 0.0),
                                                        //                       ),
                                                        //
                                                        //                       // color: lovedDevices[i].name == "GOLD" ? Color(0xFFB99013)
                                                        //                       //     :lovedDevices[i].name == "PLATINUM"? Color(0xFF1A1A1A)
                                                        //                       //     :lovedDevices[i].name == "BLUE"?Color(0xFF5787E3):Color(0xFFC8C5BD),
                                                        //
                                                        //                       borderRadius: BorderRadius.all(
                                                        //                         Radius.circular(50.r),
                                                        //                       ),
                                                        //                     ),
                                                        //                     height: 30.h,
                                                        //                     //width: 100.w,
                                                        //                     child: Row(
                                                        //                       mainAxisAlignment: MainAxisAlignment.center,
                                                        //                       crossAxisAlignment: CrossAxisAlignment.center,
                                                        //                       children: [
                                                        //                         Image.asset(
                                                        //                           _singleDevices[i].name == "GOLD" || _singleDevices[i].name == "GOLD+" || _singleDevices[i].name == "PLATINUM" || _singleDevices[i].name == "PLATINUM+" ? "assets/images/crown.png"
                                                        //                               : "assets/images/wifi_icon.png",
                                                        //                           color: Colors.white,
                                                        //                           height: 16.h,
                                                        //                           scale: 8,
                                                        //                         ),
                                                        //                         SizedBox(
                                                        //                           width: 5.w,
                                                        //                         ),
                                                        //                         Text(
                                                        //                           _singleDevices[i].name,
                                                        //                           style: TextStyle(
                                                        //                             color: Colors.white,
                                                        //                             fontWeight: FontWeight.w600,
                                                        //                             fontSize: 12.sp,
                                                        //                             height: 1.8,
                                                        //                           ),
                                                        //                           textAlign: TextAlign.center,
                                                        //                         ),
                                                        //                       ],
                                                        //                     ),
                                                        //                   ),
                                                        //                 ],
                                                        //               ),
                                                        //               SizedBox(
                                                        //                 height: 5,
                                                        //               ),
                                                        //               Container(
                                                        //                 height: height * 0.07,
                                                        //                 child: //ReadMore
                                                        //                 Text(
                                                        //                   prefix,
                                                        //                   overflow: TextOverflow.clip,
                                                        //                   maxLines: 3,
                                                        //                   style: TextStyle(fontSize: 12),
                                                        //                 ),
                                                        //               ),
                                                        //               SizedBox(
                                                        //                 height: 7.h,
                                                        //               ),
                                                        //               Text(
                                                        //                 "${_singleDevices[i].price.toString()} AED",
                                                        //                 style: TextStyle(
                                                        //                   fontSize: 28.sp,
                                                        //                   fontWeight: FontWeight.w600,
                                                        //                 ),
                                                        //               )
                                                        //             ],
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //       SizedBox(
                                                        //         height: 20.h,
                                                        //       ),
                                                        //       Padding(
                                                        //         padding: EdgeInsets.only(
                                                        //           left: 10.w,
                                                        //           right: 10.w,
                                                        //         ),
                                                        //         child: Row(
                                                        //           mainAxisAlignment:
                                                        //           MainAxisAlignment.spaceBetween,
                                                        //           children: [
                                                        //             Text(
                                                        //               "Validity",
                                                        //               style: TextStyle(
                                                        //                 color: Colors.grey.shade500,
                                                        //                 fontSize: 12.sp,
                                                        //               ),
                                                        //             ),
                                                        //             Text(
                                                        //               "$abc days",
                                                        //               style: TextStyle(
                                                        //                 color: Colors.black,
                                                        //                 fontWeight: FontWeight.w400,
                                                        //                 fontSize: 12.sp,
                                                        //               ),
                                                        //             ),
                                                        //           ],
                                                        //         ),
                                                        //       ),
                                                        //       SizedBox(
                                                        //         height: 10.h,
                                                        //       ),
                                                        //       Padding(
                                                        //         padding: EdgeInsets.only(
                                                        //           left: 10.w,
                                                        //           right: 10.w,
                                                        //         ),
                                                        //         child: Row(
                                                        //           mainAxisAlignment:
                                                        //           MainAxisAlignment.spaceBetween,
                                                        //           children: [
                                                        //             Text(
                                                        //               "# of Devices",
                                                        //               style: TextStyle(
                                                        //                 color: Colors.grey.shade500,
                                                        //                 fontSize: 12.sp,
                                                        //               ),
                                                        //             ),
                                                        //             Text(
                                                        //               "${_singleDevices[i].devices.toString()}",
                                                        //               style: TextStyle(
                                                        //                 color: Colors.black,
                                                        //                 fontWeight: FontWeight.w400,
                                                        //                 fontSize: 12.sp,
                                                        //               ),
                                                        //             ),
                                                        //           ],
                                                        //         ),
                                                        //       ),
                                                        //       SizedBox(
                                                        //         height: 10.h,
                                                        //       ),
                                                        //       Padding(
                                                        //         padding: EdgeInsets.only(
                                                        //           left: 10.w,
                                                        //           right: 10.w,
                                                        //         ),
                                                        //         child: Row(
                                                        //           mainAxisAlignment:
                                                        //           MainAxisAlignment.spaceBetween,
                                                        //           children: [
                                                        //             Text(
                                                        //               "Speed upto",
                                                        //               style: TextStyle(
                                                        //                 color: Colors.grey.shade500,
                                                        //                 fontSize: 12.sp,
                                                        //               ),
                                                        //             ),
                                                        //             Text(
                                                        //               "${_singleDevices[i].bandwidth.toString()}Mbps",
                                                        //               style: TextStyle(
                                                        //                 color: Colors.black,
                                                        //                 fontWeight: FontWeight.w400,
                                                        //                 fontSize: 12.sp,
                                                        //               ),
                                                        //             ),
                                                        //           ],
                                                        //         ),
                                                        //       ),
                                                        //       SizedBox(
                                                        //         height: 10.h,
                                                        //       ),
                                                        //       Divider(),
                                                        //       Container(
                                                        //         height:45,
                                                        //         //color:Colors.red,
                                                        //         child: Center(
                                                        //           child: CustomButton(
                                                        //             height: 40.h,
                                                        //             width: 140.w,
                                                        //             onPressed: () {
                                                        //               Navigator.push(
                                                        //                   context,
                                                        //                   MaterialPageRoute(
                                                        //                       builder: (context) => PaymentMethod(
                                                        //                         price: _singleDevices[i].price.toString(),
                                                        //                         id: _singleDevices[i].id.toString(),
                                                        //                       )));
                                                        //             },
                                                        //             text: AppLocalizations.of(context)!
                                                        //                 .translate('buy_now')!,
                                                        //           ),
                                                        //         ),
                                                        //       ),
                                                        //
                                                        //     ],
                                                        //   ),
                                                        // );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Text('$deviceAvailable'),
                                      _multipleNormalDevices.isNotEmpty
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .translate(
                                                          'multiple_device')!,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18.sp,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Container(
                                                  child: AnimationLimiter(
                                                    child: ListView.builder(
                                                      itemCount:
                                                          _multipleNormalDevices
                                                              .length,
                                                      // addRepaintBoundaries: false,
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),

                                                      itemBuilder:
                                                          (context, i) {
                                                        double val =
                                                            _multipleNormalDevices[
                                                                        i]
                                                                    .validity /
                                                                86400;
                                                        print(
                                                            'this is value--$val');
                                                        String abc = val
                                                            .toStringAsFixed(0);

                                                        var parts =
                                                            _multipleNormalDevices[
                                                                    i]
                                                                .description
                                                                .split('2');
                                                        var prefix =
                                                            parts[0].trim();

                                                        return AnimationConfiguration
                                                            .staggeredList(
                                                          position: i,
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      1000),
                                                          child: ScaleAnimation(
                                                            scale: 1,
                                                            child:
                                                                FlipAnimation(
                                                              child: Column(
                                                                children: [
                                                                  Container(
                                                                    width:
                                                                        width,
                                                                    height:
                                                                        height *
                                                                            0.20,
                                                                    decoration: BoxDecoration(
                                                                        gradient:
                                                                            gradientColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(17)),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              1.0),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                height * 0.14,
                                                                            width:
                                                                                width,
                                                                            decoration:
                                                                                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17)),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(12.0),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(
                                                                                            'Validity',
                                                                                            style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                          ),
                                                                                          Text(
                                                                                            "$abc days",
                                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Container(
                                                                                        height: 30,
                                                                                        width: 1,
                                                                                        color: Colors.grey[300],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(
                                                                                            'Limit',
                                                                                            style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                          ),
                                                                                          Text(
                                                                                            '${_multipleNormalDevices[i].devices.toString()} Devices',
                                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Container(
                                                                                        height: 30,
                                                                                        width: 1,
                                                                                        color: Colors.grey[300],
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Column(
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(
                                                                                            'Speed',
                                                                                            style: TextStyle(color: Colors.grey, fontSize: 12),
                                                                                          ),
                                                                                          Text(
                                                                                            '${_multipleNormalDevices[i].bandwidth} Mbps',
                                                                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  width: width * 0.9,
                                                                                  height: 1,
                                                                                  color: Colors.grey[300],
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(left: 10.0, right: 10, top: 11),
                                                                                  child: Container(
                                                                                    width: width,
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                                      children: [
                                                                                        // Container(
                                                                                        //   height: height * 0.05,
                                                                                        //   width: width*0.55,
                                                                                        //   //color: Colors.green,
                                                                                        //   child: //ReadMore
                                                                                        //   Text(
                                                                                        //     prefix,
                                                                                        //     overflow: TextOverflow.ellipsis,
                                                                                        //     maxLines: 3,
                                                                                        //     style: TextStyle(fontSize: 12),
                                                                                        //   ),
                                                                                        // ),

                                                                                        Container(
                                                                                          padding: EdgeInsets.only(left: 10, right: 10),
                                                                                          decoration: BoxDecoration(
                                                                                            gradient: LinearGradient(
                                                                                              colors:
                                                                                                  // [Color(0xFF1A1A1A), Color(0xFF1A1A1A),],
                                                                                                  _multipleNormalDevices[i].name == "BLUE"
                                                                                                      ? [
                                                                                                          Color(0xFF5787E3),
                                                                                                          Color(0xFF5787E3),
                                                                                                        ]
                                                                                                      : _multipleNormalDevices[i].name == "SILVER"
                                                                                                          ? [
                                                                                                              Color(0xFF3D3C3A),
                                                                                                              Color(0xFFC8C5BD),
                                                                                                            ]
                                                                                                          : _multipleNormalDevices[i].name == "GOLD+"
                                                                                                              ? [
                                                                                                                  Color(0xFFF4C73E),
                                                                                                                  Color(0xFFB99013),
                                                                                                                ]
                                                                                                              : _multipleNormalDevices[i].name == "GOLD"
                                                                                                                  ? [
                                                                                                                      Color(0xFFF4C73E),
                                                                                                                      Color(0xFFB99013),
                                                                                                                    ]
                                                                                                                  : _multipleNormalDevices[i].name == "CRYSTAL"
                                                                                                                      ? [
                                                                                                                          Color(0xFFF19164),
                                                                                                                          Color(0xFFF19164),
                                                                                                                        ]
                                                                                                                      : [
                                                                                                                          Color(0xFF1A1A1A),
                                                                                                                          Color(0xFF1A1A1A),
                                                                                                                        ],
                                                                                              begin: const FractionalOffset(0.2, 0.0),
                                                                                              end: const FractionalOffset(1.1, 0.0),
                                                                                            ),

                                                                                            // color: lovedDevices[i].name == "GOLD" ? Color(0xFFB99013)
                                                                                            //     :lovedDevices[i].name == "PLATINUM"? Color(0xFF1A1A1A)
                                                                                            //     :lovedDevices[i].name == "BLUE"?Color(0xFF5787E3):Color(0xFFC8C5BD),

                                                                                            borderRadius: BorderRadius.all(
                                                                                              Radius.circular(40.r),
                                                                                            ),
                                                                                          ),
                                                                                          height: 21.h,
                                                                                          //width: 100.w,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              /* Image.asset(
                                                                                  _multipleDevices[i].name == "GOLD" || _multipleDevices[i].name == "GOLD+" || _multipleDevices[i].name == "PLATINUM" || _multipleDevices[i].name == "PLATINUM+" ? "assets/images/crown.png"
                                                                                      :
                                                                                  "assets/images/wifi_icon.png",
                                                                                  color: Colors.white,
                                                                                  height: 11.h,
                                                                                  //scale: 8,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5.w,
                                                                                ),*/
                                                                                              Text(
                                                                                                //_singleDevices[i].name,
                                                                                                "${_multipleNormalDevices[i].name}",
                                                                                                style: TextStyle(
                                                                                                  color: Colors.white,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontSize: 10.sp,
                                                                                                  //height: 1.8,
                                                                                                ),
                                                                                                textAlign: TextAlign.center,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 12.0, right: 12),
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () async {
                                                                                /* Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => PaymentMethod(
                                                                          price: "${_multipleDevices[i].price.toStringAsFixed(2)}",
                                                                          id: _multipleDevices[i].id,
                                                                          comingFrom: false,
                                                                        )));*/
                                                                                EasyLoading.show(status: AppLocalizations.of(context)!.translate('please_wait')!);
                                                                                await context.read<PayByProvider>().payByPackageOrder(context, _multipleNormalDevices[i].id);
                                                                              },
                                                                              child: Container(
                                                                                height: height * 0.05,
                                                                                //color: Colors.green,
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Text(
                                                                                      'AED ${_multipleNormalDevices[i].price.toStringAsFixed(2)}',
                                                                                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                    Text(
                                                                                      'Buy Now',
                                                                                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        height *
                                                                            0.03,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Text('$deviceAvailable'),
                                    ]
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ))
          : Scaffold(
              appBar: AppBarWithCartNotificationWidget(
                title: 'Wifi',
                onTapIcon: () {
                  Navigator.pop(context);
                },
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/no_wifi_package.png',
                      color: Theme.of(context).primaryColor,
                      height: 100.h,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "You don't have any wifi package yet.",
                      style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.3),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainDashBoard(
                                      selectedIndex: 1,
                                    )));
                      },
                      text: 'Contact Support',
                      width: double.infinity,
                      height: 50.h,
                    )
                  ],
                )),
              ),
            );
    });
    navigationService.navigateTo(HomeScreenRoute);
  }
}
