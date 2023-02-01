import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/tinted_color_button.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view/widgets/web_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TravelScreen extends StatelessWidget {
  const TravelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithBackIconAndLanguage(
        onTapIcon: () {
          navigationService.closeScreen();
        },
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: Card(
                          elevation: 5,
                          child: Image.asset('assets/images/asfartrip.png',height: 80.h,)),
                    ),
                  ),

                  Center(child: Image.asset('assets/images/twoWayArrow.jpeg',height: 20.h,)),
                  Expanded(child: Center(child: Image.asset('assets/images/app_icon.png',height: 80.h,))),

                ],
              ),
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text( AppLocalizations.of(
                    context)!
                    .translate('travel_description')!,textAlign: TextAlign.center,),
              ),
            ],
          )),
          Align(
            alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton2(
                        onTap: (){
                          navigationService.closeScreen();
                        },
                        txt: AppLocalizations.of(
                            context)!
                            .translate('dont_allow')!,
                      ),
                    ),
                    SizedBox(width: 20.w,),
                    Expanded(
                      child: CustomButton(
                        height: 50.h,
                        width: double.infinity,
                        onPressed: () async {
                         // EasyLoading.show(status: 'Loading..');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WebViewPage(
                                    url:
                                    "https://asfartrip.com/en/affiliate-login?id=TVRrek56VT0=",
                                    title: 'Travel',
                                  ),
                            ),
                          );
                        },
                        text: AppLocalizations.of(
                            context)!
                            .translate('ok')!,
                      ),
                    ),

                  ],
                ),
              )),
        ],),
      ),
    );
  }
}
