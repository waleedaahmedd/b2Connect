import 'dart:async';
import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/services/util_service.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../model/utils/service_locator.dart';
import '../../view/widgets/border_painter_widget.dart';
import '../../view/widgets/indicator.dart';
import '../../view_model/providers/scanner_provider.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen() : super();

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  //CameraImage? image;
  var utilService = locator<UtilService>();
  // late final _size;

  @override
  initState() {
    super.initState();
    /* WidgetsBinding.instance?.addPostFrameCallback((_) {
    });*/
/*
    WidgetsBinding.instance?.addPostFrameCallback((_) {
*/
    //_size = MediaQuery.of(context).size;
    /*   });*/
  }

  @override
  Future<void> dispose() async {
    //await Provider.of<ScannerProvider>(context, listen: false).controller.dispose();
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScannerProvider>(builder: (context, i, _) {
      return WillPopScope(
        onWillPop: () {
          i.onBackPressed(context);
          Navigator.pop(context);
          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body:SafeArea(
            child: Stack(
              children: [
                Transform.scale(
                  scale: i.scale,
                  alignment: Alignment.topCenter,
                  child: CameraPreview(i.controller),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                        MediaQuery.of(context).size.width * 0.05),
                    child: CustomPaint(
                      painter: BorderPainter(),
                      child: Container(
                        height: i.size.height / 3.7,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    "assets/images/credit-card-icon.png",
                    color: Colors.white.withOpacity(0.5),
                    // scale: 8,
                    height: 100.h,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    IndicatorWidget("2"),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () async {
                          i.onBackPressed(context);
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_outlined,
                            color: Colors.white, size: 24),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: i.cardFace == 1 && i.cardType == 1
                            ? Text(
                          'Scan Front of Your Emirates ID',
                          style: TextStyle(
                              color: Colors.white, fontSize: 18),
                        )
                            : i.cardFace == 2 && i.cardType == 2
                            ? Text(
                          'Flip Your Emirates ID',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18),
                        )
                            : i.cardFace == 3 && i.cardType == 3
                            ? Text(
                          'No Card Found click try again',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 18),
                        )
                            : Text(
                          'Processing ....',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: i.resetButton,
                        child: CustomButton(
                          height: 62,
                          width: 200,
                          text: 'Try Again',
                          onPressed: () async {
                            i.onBackPressed(context);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: i.cardFace == 1 || i.cardFace == 0
                            ? Text(
                          AppLocalizations.of(context)!
                              .translate('front')!,
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )
                            : i.cardFace == 2
                            ? Text(
                          AppLocalizations.of(context)!
                              .translate('back_')!,
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )
                            : Text(''),
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .translate('scan_desc')!,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // CameraPreview(_controller);


        ),
      );
    });
  }


}
