import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/services/storage_service.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_buttons/tinted_color_button.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //bool isSwitched = ;
  //bool isOffSwitched = true;
  //int value = 1;
  var _storageService = locator<StorageService>();

  bool? _email;
  bool? _inApp;

  //bool valueabc = false;

  bool? _email1;
  bool? _inApp1;

  setApi() async {
    if (await _storageService.getBoolData('INAppONOFF') == null) {
      setState(() {
        _inApp = true;
      });
    } else {
      _inApp1 = await _storageService.getBoolData('INAppONOFF');
      //print('this is value from shared else$email1');
      setState(() {
        //email= email1;
        _inApp = _inApp1;
      });
    }
  }

  setEmail() async {
    if (await _storageService.getBoolData('EmailONOFF') == null) {
      setState(() {
        _email = true;
        //inApp=true;
      });
    } else {
      _email1 = await _storageService.getBoolData('EmailONOFF');
      //inApp1=await storageService.getBoolData('INAppONOFF');
      print('this is value from shared else$_email1');
      setState(() {
        _email = _email1;
        // inApp=inApp1;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    setEmail();
    setApi();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithBackIconAndLanguage(
        onTapIcon: () {
          navigationService.closeScreen();
        },
      ),
      body: _email != null || _inApp != null
          ? Container(
              padding: EdgeInsets.only(left: 15.h, right: 15.h, bottom: 15.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.translate('setting')!,
                          style: TextStyle(
                              // color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 40.h,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('email_noti')!,
                                    style: TextStyle(
                                        fontSize: 16,
                                        // fontFamily: 'Lexend',
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('email_noti_desc')!,
                                    style: TextStyle(
                                      color: Color(0xFF545454),
                                      fontSize: 12,
                                      //fontWeight: FontWeight.w300
                                    ),
                                  ),
                                ],
                              ),
                              // Switch(
                              //   value: isSwitched,
                              //   onChanged: (value) {
                              //     setState(() {
                              //       isSwitched = value;
                              //       print(isSwitched);
                              //     });
                              //   },
                              //   activeTrackColor: Colors.lightGreenAccent,
                              //   activeColor: Colors.green,
                              // ),

                              CupertinoSwitch(
                                value: _email!,
                                onChanged: (value) async {
                                  //setEmail(value);
                                  await _storageService.setBoolData(
                                      'EmailONOFF', value);
                                  setState(() {
                                    _email = value;
                                    //print(isSwitched);

                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setEmailONOFF(value);
                                  });
                                },
                                activeColor: Color(0xFFE0457B),
                                trackColor: Colors.grey,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          //Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('in_app')!,
                                    style: TextStyle(
                                        // fontFamily: "Lexend",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .translate('in_app_desc')!,
                                    style: TextStyle(
                                      color: Color(0xFF545454),
                                      fontSize: 12,
                                      //fontWeight: FontWeight.w300
                                    ),
                                  ),
                                ],
                              ),
                              CupertinoSwitch(
                                value: _inApp!,
                                onChanged: (value) async {
                                  await _storageService.setBoolData(
                                      'INAppONOFF', value);
                                  setState(() {
                                    _inApp = value;
                                    //(isOffSwitched);
                                    // await storageService.setBoolData('INAppONOFF', value);
                                    Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .setInAppONOFF(value);
                                  });
                                },
                                activeColor: Color(0xFFE0457B),
                                trackColor: Colors.grey,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                        ],
                      ),

                      //Divider(),
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      Text(
                        AppLocalizations.of(context)!.translate('currency')!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          padding: EdgeInsets.all(8.h),
                          // width: 330.w,
                          // margin: EdgeInsets.only(left: 40),
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(5.r),
                            // border: Border.all(width: 0,),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!
                                    .translate('dirham')!,
                                style: TextStyle(
                                    //fontFamily: 'Lexend',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),
                              ),
                              //  Icon(Icons.keyboard_arrow_down_sharp)
                            ],
                          )),
                      SizedBox(height: 40.h),
                      Text(
                       'Warning !',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: (){
                          navigationService.navigateTo(
                              DeleteAccountScreenRoute);
                        },
                        child: Container(
                            padding: EdgeInsets.all(8.h),
                            // width: 330.w,
                            // margin: EdgeInsets.only(left: 40),
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEEEEE),
                              borderRadius: BorderRadius.circular(5.r),
                              // border: Border.all(width: 0,),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.delete_forever_rounded,color: Colors.red,),
                                SizedBox(width: 10.w,),
                                Text('Delete Account',
                                  style: TextStyle(
                                    color: Colors.red,
                                    //fontFamily: 'Lexend',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                //  Icon(Icons.keyboard_arrow_down_sharp)
                              ],
                            )),
                      ),
                      SizedBox(height: 10.h,),

                      Text
                        (
                        'If you delete your account now, you will have the option to recover it with in 30 days',
                        //"${Provider.of<AuthProvider>(context, listen: false).getAppVersion}",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          //fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          height: 2,
                        ),
                      ),
                      /*   SizedBox(
                        height: 20.h,
                      ),

                      Text(
                        AppLocalizations.of(context)!.translate('language')!,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          padding: EdgeInsets.all(10.h),
                        //  margin: EdgeInsets.only(left: 40),

                          // width: 330.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Color(0xFFEEEEEE),
                            borderRadius: BorderRadius.circular(5.r),
                            // border: Border.all(width: 0,),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.translate('select')!,
                                style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w300
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down_sharp)
                            ],
                          )),*/
                    ],
                  ),

                  Column(
                    children: [
                      CustomButton(
                        width: double.infinity,
                        height: 50.h,
                        onPressed: () {
                          navigationService.closeScreen();
                        },
                        text: AppLocalizations.of(context)!
                            .translate('save_changes')!,
                      ),

                      Text(
                        "${AppLocalizations.of(context)!.translate('app_version')!}: ${Provider.of<AuthProvider>(context, listen: false).getAppVersion}",
                        //"${Provider.of<AuthProvider>(context, listen: false).getAppVersion}",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          //fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          height: 2,
                        ),
                      ),
                    ],
                  ),

                  // Container(
                  //   padding: EdgeInsets.only(right: 10.w, left: 10.w),
                  //   width: double.infinity,
                  //   height: 50.h,
                  //   child: ElevatedButton(
                  //     onPressed: () {},
                  //     style: ElevatedButton.styleFrom(
                  //       elevation: 0,
                  //       textStyle:
                  //           TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  //       shape: new RoundedRectangleBorder(
                  //         borderRadius: new BorderRadius.circular(10.0),
                  //       ),
                  //       primary: Theme.of(context).primaryColor,
                  //     ),
                  //     child: new Text(
                  //       "Save Changes",
                  //       style: TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 16.sp,
                  //           fontWeight: FontWeight.w600,
                  //           letterSpacing: 1),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
