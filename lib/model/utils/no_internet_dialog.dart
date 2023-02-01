import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../view/widgets/custom_buttons/gradiant_color_button.dart';

class NoInternetDialog {

static Future<bool> checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
      //getInternetAlert();
    }
  }

static void getInternetAlert({required BuildContext newContext, int? popCount, Future<void>? dataCalling }) {
    showGeneralDialog(
      barrierLabel: 'No Internet',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      context: newContext,
      pageBuilder: (_, __, ___) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Align(
            alignment: Alignment.center,
            child: Wrap(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Icon(Icons.error, color: Theme.of(newContext).primaryColor,size: 50.h,)/*Image.asset(
                            "assets/images/no_internet.png",
                            height: 100.h,
                            color: Theme.of(newContext!).primaryColor,
                          ),*/
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'Please check your internet/network connection and try again',
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.w200),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              height: 40.h,
                              width: 250.w,
                              text: "RETRY",
                              onPressed: () async {
                                final status = await checkConnection();
                                if (status) {
                                  if (dataCalling == null) {
                                    int count = 0;
                                    //Navigator.pop(newContext);
                                    Navigator.of(newContext).popUntil((_)=> count++>= popCount!);
                                  }
                                  else{
                                    Navigator.pop(newContext);
                                     dataCalling;

                                  }

                                 // dataCalling();
                                }
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
