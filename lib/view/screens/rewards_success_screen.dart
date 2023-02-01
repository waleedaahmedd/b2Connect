import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../model/locale/app_localization.dart';
import '../../view_model/providers/points_provider.dart';
import '../widgets/custom_buttons/gradiant_color_button.dart';

class RewardsSuccessScreen extends StatelessWidget {
  const RewardsSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Consumer<PointsProvider>(builder: (context, _pointsProvider, _) {
      return Scaffold(
          body: WillPopScope(
        onWillPop: () async {
          _pointsProvider.setPointsMainView(false);

          var count = 0;
          Navigator.popUntil(context, (route) {
            return count++ == 2;
          });
          /* if (widget.comingFrom == 'topup') {
              var count = 0;
              Navigator.popUntil(context, (route) {
                return count++ == 2;
              });
            }
            else{
              var count = 0;
              Navigator.popUntil(context, (route) {
                return count++ == 4;
              });
            }
            */ /*  widget.comingFrom == 'topup'?  Navigator.pop(context):
        _navigationService.navigateTo(HomeScreenRoute);*/
          return false;
        },
        child: Stack(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //AppLocalizations.of(context)!.translate('back')!,
                      Container(
                          height: 150,
                          child: Image.asset('assets/images/success_icon.png')),
                      Text(
                        AppLocalizations.of(context)!.translate('success')!,
                        style: TextStyle(
                            fontSize: 22,
                            color: Color(0xFF223263),
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Text.rich(
                        TextSpan(
                          // with no TextStyle it will have default text style
                          text: 'Thank you for the Order ',
                          style: TextStyle(
                            color: Colors.grey[400],
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '# SO-1234',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                            TextSpan(
                              text:
                                  '. Your redemption on Xiaomi Ear Bud ( White) is successful! Please collect your deliverable.',
                              style: TextStyle(
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Reference Number: #683129490970959',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Theme.of(context).primaryColor,
                          //fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'B2Connect will not support on any service provider issues. Please reach corresponding service provider support for further assistance.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        onPressed: () {
                          _pointsProvider.setPointsMainView(false);
                          var count = 0;
                          Navigator.popUntil(context, (route) {
                            return count++ == 2;
                          });
                        },
                        text: 'Order History',
                        height: height * 0.07,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ));
    });
  }
}
