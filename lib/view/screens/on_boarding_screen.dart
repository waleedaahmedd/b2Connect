import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view/widgets/language_selection_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../model/utils/routes.dart';
import '../../model/utils/service_locator.dart';
import '../../model/services/navigation_service.dart';
import '../../view_model/providers/app_language_provider.dart';
import '../../model/locale/app_localization.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var navigationService = locator<NavigationService>();
  //var storageService = locator<StorageService>();
  int _current = 0;
  List<int> _listIndex = [0];
  var _locale;
  final List _imgList = [
    'assets/images/Group 10.png',
    'assets/images/Group 5.png',
    'assets/images/Group 6.png',
    'assets/images/Group 9.png',
  ];

  CarouselController _controller = CarouselController();

  void initState() {
    _locale = Provider.of<AppLanguage>(context, listen: false).appCurrentLocale;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,

        body: Column(
            children: [
      SizedBox(
        height: 30.h,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _imgList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: width / 4.50,
              height: 3.0.h,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  //shape: BoxShape.rectangle,
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.black
                          : Color.fromRGBO(217, 60, 84, 1.0)
                      //Theme.of(context).primaryColor
                      )
                      .withOpacity(_listIndex.contains(entry.key)
                          ? 0.7
                          : _listIndex.contains(entry.key)
                              ? 0.7
                              : _listIndex.contains(entry.key)
                                  ? 0.7
                                  : 0.2)),
            ),
          );
        }).toList(),
      ),
      SizedBox(
        height: 10.h,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LanguageSelectionButton(),

          ],
        ),
      ),
      Expanded(
        child: CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
              enableInfiniteScroll: false,
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  if (_current == 0 && index == 1) {
                    _listIndex.add(index);
                  } else if (_current == 1 && index == 0) {
                    _listIndex.remove(_current);
                  } else if (_current == 1 && index == 2) {
                    _listIndex.add(index);
                  } else if (_current == 2 && index == 1) {
                    _listIndex.remove(_current);
                  }else if (_current == 2 && index == 3) {
                    _listIndex.add(index);
                  } else if (_current == 3 && index == 2) {
                    _listIndex.remove(_current);
                  }
                  _current = index;
                });
              }
              ),
          items: _imgList
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    margin: EdgeInsets.only(top: 40),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Text(
                            item == "assets/images/Group 10.png"
                                ? AppLocalizations.of(context)!.translate('title2')!
                                : item == "assets/images/Group 5.png"
                                    ? AppLocalizations.of(context)!.translate('title3')!
                                    : item == "assets/images/Group 6.png"
                                         ? AppLocalizations.of(context)!.translate('title4')!
                                        : AppLocalizations.of(context)!.translate('title')!,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 27.sp,
                                //letterSpacing: 0.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: height*0.04,
                        ),
                        Center(
                          child: Image.asset(
                            item,
                            width: width,
                            height: height / 2.5,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          children: [
            CustomButton(
              onPressed: (){
                setState(() {_controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);});
                if (_current == 3) {
                 // FirebaseCrashlytics.instance.crash();

                navigationService.navigateTo(WelcomeScreenRoute);
                }
              },
              text: _current == 3 ? AppLocalizations.of(context)!.translate("button")! : AppLocalizations.of(context)!.translate("proceed")!,
              height: height*0.07,
              width: double.infinity,
              arrowVisibility: /*_current == 2? null :*/ true,
            ),

            SizedBox(height: 5.h),

            Container(
              height: 40.h,
              width: double.infinity,
              child:
                TextButton(
                  onPressed: ()async{

                    navigationService.navigateTo(WelcomeScreenRoute);
                  },
                  child: Text(AppLocalizations.of(context)!.translate("skip")!,style: TextStyle(color: Color(0xFF757575),decoration: TextDecoration.underline,),),
                )
              // CustomButton2(
              //   onTap: (){
              //     navigationService.navigateTo(WelcomeScreenRoute);
              //   },
              //   txt: AppLocalizations.of(context)!.translate("skip")!,
              // ),
            ),
            SizedBox(height: 5.h)
          ],
        ),
      ),
    ]));
  }
}

