import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/tinted_color_button.dart';
import 'package:b2connect_flutter/view/widgets/language_selection_button.dart';
import 'package:b2connect_flutter/view/widgets/useful_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view/widgets/column_scroll_view.dart';
import '../../view/widgets/showOnWillPop.dart';
import '../../model/utils/routes.dart';
import '../../model/utils/service_locator.dart';
import '../../model/locale/app_localization.dart';
import '../../model/services/navigation_service.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var _navigationService = locator<NavigationService>();
  //var storageService = locator<StorageService>();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final double height = MediaQuery.of(context).size.height;
    //final double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                  gradientTabs(context:context, gradientColor1: gradientColor, gradientColor2: greyGradientColor, gradientColor3: greyGradientColor),

                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LanguageSelectionButton(),
                      ],
                    ),
                  ),
                  Container(
                    height: height * 0.6,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.translate('welcome')!}",
                            style: TextStyle(
                                fontSize: 30.sp,
                                //letterSpacing: 1.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          // Text(
                          //   "B2Connect",
                          //   style: TextStyle(
                          //       fontSize: 30.sp,
                          //       //letterSpacing: 1.5,
                          //       fontWeight: FontWeight.w500,
                          //       color: Colors.black),
                          // ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('getStarted')!,
                            style: TextStyle(
                                fontSize: 14.sp,
                                //letterSpacing: 0.5,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF757575)),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Center(
                            child: Image(
                              image: AssetImage("assets/images/Group 8.png"),
                              width: 250.w,
                              height: 250.h,
                              fit: BoxFit.fill,
                            ),
                          ),

                        ],
                      ),

                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20,bottom: 10),
                  child: Column(
                    children: [
                      CustomButton(
                        onPressed: () async {
                          _navigationService.navigateTo(SignupScreenRoute);
                        },
                        text: AppLocalizations.of(context)!.translate('singupB2')!,
                        height: height * 0.07,
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomButton2(
                        onTap: (){
                          _navigationService.navigateTo(LoginScreenRoute);
                        },
                        txt: AppLocalizations.of(context)!.translate('member')!,
                      ),

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
