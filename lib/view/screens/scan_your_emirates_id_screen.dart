import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view_model/providers/scanner_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../model/utils/routes.dart';
import '../../view/screens/scan_screen.dart';
import '../../view/widgets/indicator.dart';
import '../widgets/showOnWillPop.dart';

class ScanYourEmiratesIDScreen extends StatefulWidget {
  @override
  _ScanYourEmiratesIDScreenState createState() =>
      _ScanYourEmiratesIDScreenState();
}

class _ScanYourEmiratesIDScreenState extends State<ScanYourEmiratesIDScreen> {
  //var navigationService = locator<NavigationService>();
  //var storageService = locator<StorageService>();
  // var _firstCamera;

  //var scanId;

  // ignore: unused_field
  //int _current = 0;
  //List<int> listIndex = [0];

  // var locale;

  // CarouselController _controller = CarouselController();

  void initState() {
    super.initState();
    /*readCamera();*/
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScannerProvider>(builder: (context, i, _) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarWithBackIconAndLanguage(
            onTapIcon: () {
              Navigator.pop(context);
            },
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      IndicatorWidget("1"),
                      SizedBox(
                        height: 40.h,
                      ),
                      Text('Verify Emirates ID',
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        'Please scan or upload your Emiartes ID.\nThis will assist us in confirming your status as an authorized user.\nYou will be able to purchase our products after this step.',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w200,
                            color: Colors.grey,
                            height: 1.4),
                      ),
                      SizedBox(
                        height:20.h,
                      ),


                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Image.asset(
                          "assets/images/cardscan.png",
                          width: double.infinity,
                          // width: 350.0.w,
                          // height: 250.0.h,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            height: 50.h,
                            width: double.infinity,
                            onPressed: () async {
                              i.setSize(context);
                              i.setCardFace(0);
                              i.setCardType(0);
                              i.setScanBusy(false);
                              i.setResetButton(false);
                              await i.startCamera(context).then((value) {
                                i.startStreaming();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TakePictureScreen(
                                            /*camera: _firstCamera*/)));
                              });
                            },
                            text: 'Scan ID',
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                          child: CustomButton(
                            height: 50.h,
                            width: double.infinity,
                            onPressed: () async {
                              navigationService
                                  .navigateTo(
                                  UploadEidImageScreenRoute);
                            },
                            text: 'Upload ID',
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ));
    });
  }
}
