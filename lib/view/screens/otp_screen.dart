import 'package:b2connect_flutter/model/services/util_service.dart';
import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/button_with_loader.dart';
import 'package:b2connect_flutter/view/widgets/language_selection_button.dart';
import 'package:b2connect_flutter/view/widgets/useful_widgets.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//import 'package:hexcolor/hexcolor.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import '../../model/services/navigation_service.dart';
import '../../model/locale/app_localization.dart';
import '../../view/widgets/column_scroll_view.dart';
import '../../model/utils/routes.dart';
import '../../model/utils/service_locator.dart';
import '../../view/widgets/showOnWillPop.dart';
import '../../view_model/providers/auth_provider.dart';

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> with CodeAutoFill {
  TextEditingController _controller = TextEditingController(text: "");

  //HttpService objhttpService = HttpService();
  //HttpService? http = locator<HttpService>();
  NavigationService _navigationService = locator<NavigationService>();
  String? appSignature;
  String? otpCode;

  String _phoneNumber = '';
  String _ipAddress = '';
  String _macAddress = '';

  //String _thisText = "";
  //int _pinLength = 6;
  //bool _hasError = false;
  //String? errorMessage;
  //String? number;
  //int _start = 30;
  bool _timer = true;
  Color _border = Colors.white;
  var _utilsService = locator<UtilService>();

  /*void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start, milliseconds: 00),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _current = _start - duration.elapsed.inMinutes;
      });
    });

    sub.onDone(() {
      //print("Done");
      sub.cancel();
    });
  }*/
  // setNavigateDecision()async{
  //   var prefs = await SharedPreferences.getInstance();
  //
  //   if(prefs.getBool('isShowHome')!=true){
  //     Timer(Duration(seconds: 6), () async {
  //       Navigator.pop(context);
  //     });
  //
  //         btn3(context);
  //
  //   }
  //
  //   prefs.setBool('isShowHome', true);
  //
  //
  // }

  @override
  void codeUpdated() {
    setState(() {
      otpCode = code!;
      _controller.text = otpCode!;
    });
  }

  @override
  void initState() {
    //setNavigateDecision();
    listenForCode();

    SmsAutoFill().getAppSignature.then((signature) {
      setState(() {
        appSignature = signature;
      });
    });
    _phoneNumber =
        Provider.of<AuthProvider>(context, listen: false).getPhoneNumber;
    _ipAddress = Provider.of<AuthProvider>(context, listen: false).getIpAddress;
    _macAddress =
        Provider.of<AuthProvider>(context, listen: false).getMacAddress;
    /*startTimer();*/
    print(
        'mac address from provider ${Provider.of<AuthProvider>(context, listen: false).getMacAddress}');
    print(
        'ip address from provider ${Provider.of<AuthProvider>(context, listen: false).getIpAddress}');
    print(
        'phone address from provider ${Provider.of<AuthProvider>(context, listen: false).getPhoneNumber}');
    super.initState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  bool _showLoader = false;

  @override
  Widget build(BuildContext context) {
    /*  if(otpCode != null){
      _controller.text = otpCode!;
    }*/

    final double height = MediaQuery.of(context).size.height;
    //final double width = MediaQuery.of(context).size.width;
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
            children: <Widget>[
              Column(
                children: [
                  gradientTabs(
                      context: context,
                      gradientColor1: gradientColor,
                      gradientColor2: gradientColor,
                      gradientColor3: gradientColor),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    //color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // _navigationService.navigateTo(LoginScreenRoute);
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_sharp,
                            color: Colors.black,
                            size: 25,
                          ),
                        ),
                        LanguageSelectionButton(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 10.h,
                        ),
                        //    Text('$appSignature'),
                        //   Text('$otpCode'),
                        Text(
                          AppLocalizations.of(context)!.translate('verify')!,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 30.sp,
                          ),
                        ),

                        SizedBox(
                          height: 10.h,
                        ),
                        RichText(
                          text: TextSpan(
                            text: AppLocalizations.of(context)!
                                .translate('enterOtp')!,
                            style: TextStyle(
                              color: Color(0xFF757575),
                              height: 1.4,
                              fontSize: 15.sp,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '+$_phoneNumber',
                                style: TextStyle(
                                  color: Color(0xFF757575),
                                  fontSize: 15.sp,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                              TextSpan(
                                text: AppLocalizations.of(context)!
                                    .translate('change')!,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15.sp,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pop(context);

                                    /*_navigationService
                                        .navigateTo(SignupScreenRoute);*/
                                  },
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        Text(
                          AppLocalizations.of(context)!.translate('verify')!,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(
                          height: 7.h,
                        ),
                        Container(
                          child: PinCodeTextField(
                              pinBoxRadius: 5,
                              pinBoxColor: Color(0xffEEEEEE),
                              pinBoxHeight: 47.h,
                              autofocus: true,
                              pinBoxWidth: 47.w,
                              controller: _controller,
                              hideCharacter: false,
                              highlight: true,
                              highlightPinBoxColor: Color(0xffEEEEEE),
                              highlightColor: Theme.of(context).primaryColor,
                              defaultBorderColor: _border,
                              //HexColor('#f2f2f3'),
                              //hasTextBorderColor: HexColor('#f2f2f2'),
                              highlightAnimationEndColor:
                                  Color.fromRGBO(238, 238, 238, 0),
                              //HexColor('#EEEEEE'),
                              maxLength: 6,
                              hasError: false,
                              hasTextBorderColor: _border,
                              onTextChanged: (text) {
                                if (_controller.text.length < 6) {
                                  setState(() {
                                    _border = Colors.white;
                                  });
                                }
                              },
                              wrapAlignment: WrapAlignment.center,
                              pinTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                              pinTextAnimatedSwitcherTransition:
                                  ProvidedPinBoxTextAnimation.scalingTransition,
                              pinTextAnimatedSwitcherDuration:
                                  Duration(milliseconds: 300),
                              keyboardType: TextInputType.number),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _timer
                                ? Text(
                                    AppLocalizations.of(context)!
                                        .translate('resend')!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp,
                                      color: Colors.pink[200],
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      await Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .callOTP(_phoneNumber)
                                          .then((value) {
                                        print(
                                            'this is the number$_phoneNumber');
                                        print('resend otp: $value');
                                        setState(() {});
                                      });
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('resend')!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15.sp,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                            _timer
                                ? Row(
                                    children: [
                                      Icon(
                                        Icons.timer,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate('expire')!,
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      TweenAnimationBuilder<Duration>(
                                          duration: Duration(minutes: 2),
                                          tween: Tween(
                                              begin: Duration(minutes: 2),
                                              end: Duration.zero),
                                          onEnd: () {
                                            setState(() {
                                              _timer = false;
                                            });
                                            print('Timer ended');
                                          },
                                          builder: (BuildContext context,
                                              Duration value, Widget? child) {
                                            final minutes = value.inMinutes;
                                            final seconds =
                                                value.inSeconds % 60;
                                            return Text(' 0$minutes:$seconds',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  // fontWeight: FontWeight.bold,
                                                  /*fontSize: 30*/
                                                ));
                                          }),
                                      /*Text(" 00:$_timer",
                                    style: TextStyle(
                                        color: Colors.grey)),*/
                                    ],
                                  )
                                : Text(
                                    AppLocalizations.of(context)!
                                        .translate('expired')!,
                                    style: TextStyle(color: Colors.grey),
                                  )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
                child: Container(
                  height: height * 0.07,
                  width: double.infinity,
                  child: ButtonWithLoader(
                    showLoader: _showLoader,
                    height: 25.h,
                    width: 100,
                    clickEnableColor: _timer ? true : false,
                    text: AppLocalizations.of(context)!.translate('verify')!,
                    onPressed: _timer
                        ? () async {
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());
                            if (connectivityResult ==
                                    ConnectivityResult.mobile ||
                                connectivityResult == ConnectivityResult.wifi) {
                              setState(() {
                                _showLoader = true;
                              });

                              //await Provider.of<AuthProvider>(context,listen: false).callVerifyOTP(context, number, code, ipAddress, deviceMac)
                              var value = await Provider.of<AuthProvider>(
                                      context,
                                      listen: false)
                                  .callVerifyOTP(
                                      context,
                                      _phoneNumber,
                                      _controller.text,
                                      _ipAddress,
                                      _macAddress);

                              if (value == "Wrong") {
                                setState(() {
                                  _showLoader = false;
                                  _border = Colors.red;
                                });
                              } else if (value == "Done") {
                                _navigationService.navigateTo(HomeScreenRoute);
                              }
                            } else {
                              _utilsService.showToast(
                                  "Sorry! but you don't seem to connected to any internet connection");
                            }
                          }
                        : () {},
                  ),
                ),
                /* child: Container(

                  height: height*0.07,
                  width: double.infinity,

                  decoration: BoxDecoration(
                    gradient:_current>=1? LinearGradient(
                      colors: [
                        Color(0xFFED33B9),
                        Color(0xFFA2001D)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ):LinearGradient(
                      colors: [
                        Colors.grey,
                        Colors.grey,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    // side: BorderSide(color: Colors.red),

                  ),

                  child: ElevatedButton(
                    onPressed:_current>=1? () async {

                      var connectivityResult = await (Connectivity().checkConnectivity());
                      if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi)
                      {
                        setState(() {
                          _showLoader=true;
                        });

                        //await Provider.of<AuthProvider>(context,listen: false).callVerifyOTP(context, number, code, ipAddress, deviceMac)
                        var value = await Provider.of<AuthProvider>(context, listen: false).callVerifyOTP(context, _phoneNumber, _controller.text, _ipAddress, _macAddress);

                        if(value=="Wrong"){
                          setState(() {
                            _showLoader=false;
                            _border=Colors.red;
                          });
                        }
                        else if(value=="Done"){
                          _navigationService.navigateTo(HomeScreenRoute);
                        }
                      }else{
                        _utilsService.showToast("Sorry! but you don't seem to connected to any internet connection");
                      }


                    }:(){},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0),),
                      primary: Colors.transparent,
                    ),
                    child:_showLoader?
                    Center(
                      child: Container(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            backgroundColor: Color(0xFFF7BFA5),
                            valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFFFFFF)),
                            strokeWidth: 3,
                          )
                      ),
                    )
                        :Container(
                      child: Text(
                        AppLocalizations.of(context)!.translate('verify')!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),*/
              ),
            ],
          ),
        ),
      ),
    );
  }

/*  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
          ),
        ),
        context: context,
        builder: (BuildContext bc) {
          return ChangeLanguageBottomSheet();
        });
  }*/
}
