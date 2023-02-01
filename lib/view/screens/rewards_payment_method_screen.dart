import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:relative_scale/relative_scale.dart';

import '../../model/locale/app_localization.dart';
import '../../model/utils/routes.dart';
import '../widgets/appbar_with_back_icon_and_language.dart';
import '../widgets/custom_buttons/gradiant_color_button.dart';
import '../widgets/showOnWillPop.dart';

class RewardsPaymentMethodScreen extends StatefulWidget {
  const RewardsPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  _RewardsPaymentMethodScreenState createState() =>
      _RewardsPaymentMethodScreenState();
}

class _RewardsPaymentMethodScreenState
    extends State<RewardsPaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithBackIconAndLanguage(
          onTapIcon: () {
            Navigator.pop(context);
          },
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!
                          .translate("payment_method")!,
                      style: TextStyle(
                        height: 1.2,
                        fontSize: sy(20),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'B2 Points',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: height * 0.016.h,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 60.h,
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: width * 0.003,
                          color: Colors.grey.shade200,
                        ),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      margin: EdgeInsets.only(
                        bottom: height * 0.010,
                        top: height * 0.010,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image(
                              image: AssetImage("assets/images/coin_icon.png"),
                              width: 50.w,
                            ),
                            Container(
                                width: 106.w,
                                child: Text(
                                  'Pay using your B2 Points balance',
                                  style: TextStyle(fontSize: 12.sp),
                                )),
                            Text(
                              '25000 B2 Points',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.green),
                            )
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                  ],
                ),
              ),
              CustomButton(
                  height: 50.h,
                  width: double.infinity,
                  onPressed: () async {
                    navigationService.navigateTo(
                        RewardsSuccessScreenRoute);
                  },
                  text: 'Confirm'),
            ],
          ),
        ),
      );
    });
  }
}
