import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/tinted_color_button.dart';
import 'package:b2connect_flutter/view/widgets/language_selection_button.dart';
import 'package:b2connect_flutter/view/widgets/useful_widgets.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:b2connect_flutter/view_model/providers/order_provider.dart';
import 'package:b2connect_flutter/view_model/providers/pay_by_provider.dart';
import 'package:b2connect_flutter/view_model/providers/wifi_provider.dart';
import 'package:b2connect_flutter/view_model/providers/wish_list_provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import '../../model/services/navigation_service.dart';


//import 'package:device_info_plus/device_info_plus.dart';
//import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:macadress_gen/macadress_gen.dart';
import 'package:provider/provider.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import '../../view/widgets/column_scroll_view.dart';
import '../../model/utils/routes.dart';
import '../../model/utils/service_locator.dart';
import '../../model/locale/app_localization.dart';
import '../../model/services/util_service.dart';
import '../../view/widgets/showOnWillPop.dart';
import '../../view_model/providers/auth_provider.dart';
import '../widgets/custom_buttons/button_with_loader.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var utilsService = locator<UtilService>();
  NavigationService navigationService = locator<NavigationService>();


  MacadressGen _macadressGen = MacadressGen();
  final _info = NetworkInfo();

  final TextEditingController _phnController = TextEditingController();
  String ipAddress = '';
  String macAddress = '';
  String _phneNumberWcuntryCode = '';
  Color _txtFieldColor = Colors.transparent;
  String? _validator;
  Color? _validateColor = Colors.green;
  bool _showLoader = false;


  getMAc() async {
    String mac = '';
    mac = await _macadressGen.getMac();
    print('Mac address:$mac');
    Provider.of<AuthProvider>(context, listen: false).saveMacAddress(mac);
  }

  getIP() async {
    String? ip = '';
    ip = await _info.getWifiIP();
    print('Mac address:$ip');
    Provider.of<AuthProvider>(context, listen: false).saveIpAddress(ip);
  }

  clearSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('INAppONOFF');
    await preferences.remove('EmailONOFF');
  }

  clearProviders() {
    Provider.of<AuthProvider>(context, listen: false).packageOrderModelData =
        [];
    Provider.of<OrderProvider>(context, listen: false).offerOrderModelData =
        null;
    Provider.of<AuthProvider>(context, listen: false).notificationData.clear();
    //Provider.of<AuthProvider>(context, listen: false).refillHistoryData.clear();

    Provider.of<PayByProvider>(context, listen: false).offerItemsOrder.clear();

    Provider.of<OffersProvider>(context, listen: false).clearAllData();
    Provider.of<WifiProvider>(context, listen: false).wifiData.clear();
    Provider.of<WifiProvider>(context, listen: false).wifiPlanData = null;
    Provider.of<WishListProvider>(context, listen: false).wishListData.clear();
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
    clearProviders();});
    clearSharedPreferences();

    getMAc();
    getIP();
    ipAddress = Provider.of<AuthProvider>(context, listen: false).getIpAddress;
    macAddress =
        Provider.of<AuthProvider>(context, listen: false).getMacAddress;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    // SimpleFontelicoProgressDialog _dialog = SimpleFontelicoProgressDialog(
    //     context: context, barrierDimisable: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          showOnWillPop(context);
          return false;
        },
        child: ColumnScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  gradientTabs(
                      context: context,
                      gradientColor1: gradientColor,
                      gradientColor2: gradientColor,
                      gradientColor3: greyGradientColor),
                  Container(
                    padding: const EdgeInsets.only(right: 10, top: 10),
                    //color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            navigationService.navigateTo(WelcomeScreenRoute);
                          },
                          icon: Icon(
                            Icons.arrow_back_sharp,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                        LanguageSelectionButton(),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('login')!,
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    //letterSpacing: 1.5,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              Text(
                                "B2Connect",
                                style: TextStyle(
                                    fontSize: 30.sp,
                                    //letterSpacing: 1.5,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('enterNumber')!,
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    //letterSpacing: 1,
                                    fontWeight: FontWeight.w200,
                                    color: Color(0xFF757575)),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('number')!,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    //letterSpacing: 1,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                //color: Colors.red,
                                //padding: EdgeInsets.only(left: 5, right: 5),
                                //
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      height: 30.h,
                                      width: width * 0.25,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: 22.h,
                                            width: 22.w,
                                            child: Image.asset(
                                                'assets/images/united-arab-emirates.png'),
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Text(
                                            '+971',
                                            style: TextStyle(fontWeight: FontWeight.w200),
                                            //style: GoogleFonts.poppins(),
                                          ),
                                          RotatedBox(
                                            quarterTurns: 3,
                                            child: Icon(
                                              Icons.chevron_left,
                                              color: Colors.black,
                                              size: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.03,
                                    ),
                                    Container(
                                      height: 30.h,
                                      width: width * 0.65,
                                      child: TextFormField(
                                        style: TextStyle(fontWeight: FontWeight.w200),
                                        controller: _phnController,
                                        textInputAction: TextInputAction.done,
                                        //autofocus: true,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(9),
                                        ],

                                        onChanged: (value) {
                                          if (value.length > 9 ||
                                              value.isEmpty ||
                                              value.length < 9) {
                                            setState(() {
                                              _validator = 'Wrong Input';
                                              _validateColor = Colors.red;
                                            });
                                          } else {
                                            setState(() {
                                              _validator = "Looks Good";
                                              _validateColor = Colors.green;
                                              if (value.length == 9) {
                                                //10 is the length of the phone number you're allowing
                                                FocusScope.of(context)
                                                    .requestFocus(FocusNode());
                                              }
                                            });
                                          }
                                          _phneNumberWcuntryCode = '971$value';
                                          print('input number-$value');
                                          if (_phnController.text.isEmpty) {
                                            print("if");
                                            setState(() {
                                              _txtFieldColor =
                                                  Colors.transparent;
                                            });
                                          } else if (_phnController
                                                  .text.length <
                                              9) {
                                            print("else if");
                                            setState(() {
                                              _txtFieldColor = Colors.red;
                                            });
                                          } else {
                                            print("else");
                                            setState(() {
                                              _txtFieldColor = Colors.green;
                                            });
                                          }
                                        },
                                        keyboardType: TextInputType.number,
                                        // keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                        // TextInputType.numberWithOptions(
                                        //   signed: true, decimal: true),

                                        decoration: InputDecoration(
                                          isDense: true,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 5.0,
                                            horizontal: 20,
                                          ),

                                          suffixIcon: _phnController
                                                  .value.text.isEmpty
                                              ? Text(' ')
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _phnController.clear();
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: Colors.black,
                                                  )),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .translate('numberDigits')!,
                                          labelStyle: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13.h,
                                          ),
                                          // hintText: AppLocalizations.of(context)!.translate('numberDigits')!,
                                          // hintStyle: TextStyle(
                                          //   color: Colors.black,
                                          //   fontSize: 12.h,
                                          // ),
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: _txtFieldColor,
                                              width: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _validator != null
                                      ? Text(
                                          '$_validator',
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              letterSpacing: 0.2,
                                              fontWeight: FontWeight.w500,
                                              color: _validateColor),
                                        )
                                      : Text(' '),

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Column(
                    children: [
                      CustomButton2(
                        onTap: () {
                          navigationService.navigateTo(SignupScreenRoute);
                        },
                        txt: AppLocalizations.of(context)!
                            .translate('notMemeber')!,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ButtonWithLoader(
                        showLoader: _showLoader,
                        onLongPress: () {
                          if (_phnController.text.length > 9 ||
                              _phnController.text.isEmpty ||
                              _phnController.text.length < 9) {
                            setState(() {
                              _validator = 'Wrong input';
                              _validateColor = Colors.red;
                            });
                          } else {
                            Provider.of<AuthProvider>(context, listen: false)
                                .savePhneNumber(_phneNumberWcuntryCode);
                            navigationService.navigateTo(OtpScreenRoute);
                          }
                        },
                        onPressed: () async {
                          if (_phnController.text.length > 9 ||
                              _phnController.text.isEmpty ||
                              _phnController.text.length < 9) {
                            setState(() {
                              _validator = 'Wrong input';
                              _validateColor = Colors.red;
                            });
                          } else {
                            setState(() {
                              _showLoader = true;
                            });
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());
                            if (connectivityResult ==
                                    ConnectivityResult.mobile ||
                                connectivityResult == ConnectivityResult.wifi) {
                              Provider.of<AuthProvider>(context, listen: false)
                                  .savePhneNumber(_phneNumberWcuntryCode);
                              navigationService.navigateTo(OtpScreenRoute);
                              await Provider.of<AuthProvider>(context,
                                      listen: false)
                                  .callLogin(_phneNumberWcuntryCode, ipAddress,
                                      macAddress);
                              setState(() {
                                _showLoader = false;
                              });
                            } else {
                              utilsService.showToast(
                                  "Sorry! but you don't seem to connected to any internet connection");
                              setState(() {
                                _showLoader = false;
                              });
                            }
                          }
                        },
                        text:
                            AppLocalizations.of(context)!.translate('proceed')!,
                        height: height * 0.07,
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
