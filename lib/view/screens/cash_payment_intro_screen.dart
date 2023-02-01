import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view/widgets/language_selection_button.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../model/utils/routes.dart';
import '../../model/utils/service_locator.dart';
import '../../model/services/navigation_service.dart';
//import '../../view/widgets/bottam_modal_sheet.dart';
import '../../view_model/providers/app_language_provider.dart';
import '../../model/locale/app_localization.dart';

class CashPaymentIntroScreen extends StatefulWidget {
  // final bool wifi;
  // ChoosePackageScreen({required this.wifi});
  @override
  _CashPaymentIntroScreenState createState() => _CashPaymentIntroScreenState();
}

class _CashPaymentIntroScreenState extends State<CashPaymentIntroScreen> {
  var navigationService = locator<NavigationService>();
  //var storageService = locator<StorageService>();
  int _current = 0;
  List<int> _listIndex = [0];
  var _locale;
  final List _imgList = [
    'assets/images/Group 6899.png',
    'assets/images/Group 6898.png',
    'assets/images/Group 6897.png',
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
        body:Consumer<OffersProvider>(builder: (context, i, _) {
          return Column(children: [
            SizedBox(
              height: 30.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: width / 3.33,
                    height: 3.0.h,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: (Theme.of(context).brightness == Brightness.dark ? Colors.black : Theme.of(context).primaryColor)
                            .withOpacity(_listIndex.contains(entry.key)
                            ? 1
                            : _listIndex.contains(entry.key)
                            ? 1
                            : _listIndex.contains(entry.key)
                            ? 1
                            : 0.2)),
                  ),
                );
              }).toList(),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: (){
                    navigationService.closeScreen();
                  },
                  icon: Icon(Icons.clear),
                ),

                LanguageSelectionButton(),

              ],
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
                        print('this is current index-$_current');
                        print('this is origional index-$index');

                        if (_current == 0 && index == 1) {
                          _listIndex.add(index);
                        } else if (_current == 1 && index == 0) {
                          _listIndex.remove(_current);
                        } else if (_current == 1 && index == 2) {
                          _listIndex.add(index);
                        } else if (_current == 2 && index == 1) {
                          _listIndex.remove(_current);
                        }
                        print('currnt index--$_current');

                        _current = index;
                      });
                    }
                  // autoPlay: true,
                ),
                items: _imgList
                    .map(
                      (item) => Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item == 'assets/images/Group 6899.png'
                                    ? "${AppLocalizations.of(context)!.translate("choose_the_package")!}"
                                    : item == 'assets/images/Group 6898.png'
                                    ? "${AppLocalizations.of(context)!.translate("enter_mobile_number")!}"
                                //: item == 'assets/images/Group 6897.png'
                                //? "${AppLocalizations.of(context)!.translate("pay_and_enjoy")!}"
                                    : "${AppLocalizations.of(context)!.translate("pay_and_enjoy")!}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 27.sp,
                                  //letterSpacing: 1.2,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:20.0),
                                child: Text(
                                  item == 'assets/images/Group 6899.png'
                                      ? "${AppLocalizations.of(context)!.translate("tutorial_desc1")!}"
                                      : item == 'assets/images/Group 6898.png'
                                      ? "${AppLocalizations.of(context)!.translate("tutorial_desc2")!}"
                                  // : item == 'assets/images/Group 6897.png'
                                  //     ? "Insert the cash as prompted in terminal screen"
                                      : "${AppLocalizations.of(context)!.translate("tutorial_desc3")!}",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      //letterSpacing: 0.5,
                                      height: 1.8,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey),
                                ),
                              ),

                            ],
                          ),

                          // SizedBox(
                          //   height: height*0.1,
                          // ),

                          Image.asset(
                            item,
                            width: width,
                            height: height / 2.5,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
            Container(
              width: double.infinity,
              height: 100.h,
              // color: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child:
                      CustomButton(
                        height: 50.h,
                        width: double.infinity,
                        onPressed: ()async{
                          setState(() {
                            _controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);});
                          if (_current == 2) {

                            navigationService.navigateTo(HomeScreenRoute);
                             /* i.totalPriceNow=0.0;
                              i.updatedInstallmentPrice=0.0;
                              i.installmentPrice = 0.0;
                              EasyLoading.show();

                              await context.read<PayByProvider>().cashOffersOrder(context).then((value){
                                navigationService.navigateTo(HomeScreenRoute);

                              });

                              Provider.of<PayByProvider>(context,listen: false).offerItemsOrder.clear();
                              // i.clearProduct();
                              i.clearCartData();
                              i.onlySmartPhone = false;
                              i.showLoader=true;
                              EasyLoading.dismiss();*/




                          }
                        },
                        text: _current == 2 ? AppLocalizations.of(context)!.translate("done")! : AppLocalizations.of(context)!.translate("proceed")!,
                      )
                    // Container(
                    //   width: double.infinity,
                    //   height: 50.h,
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       setState(() {
                    //         //print('${_controlle}')
                    //
                    //         _controller.nextPage(
                    //             duration: Duration(milliseconds: 300),
                    //             curve: Curves.linear);
                    //       });
                    //       if (_current == 2) {
                    //
                    //         navigationService.navigateTo(HomeScreenRoute);
                    //       }
                    //
                    //       print('hello $_current');
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       elevation: 0,
                    //       textStyle:TextStyle(
                    //           fontSize: 14, fontWeight: FontWeight.w500),
                    //       shape: new RoundedRectangleBorder(
                    //
                    //
                    //         borderRadius: new BorderRadius.circular(10.0),
                    //       ),
                    //       primary: Theme.of(context).primaryColor,
                    //     ),
                    //     child: new Text(
                    //       _current == 2
                    //           ? "Done"
                    //           : AppLocalizations.of(context)!.translate("proceed")!,
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 15.sp,
                    //           fontWeight: FontWeight.w500,
                    //           letterSpacing: 1),
                    //     ),
                    //   ),
                    // ),
                  ),
                  //SizedBox(height: 10.h)
                ],
              ),
            ),
          ]);
        })

    );
  }
}

/*
void _settingModalBottomSheet(context) {
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
}
*/
