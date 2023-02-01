import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:b2connect_flutter/view_model/providers/pay_by_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';
import 'package:relative_scale/relative_scale.dart';

// ignore: must_be_immutable
class PaymentMethod extends StatefulWidget {
  PaymentMethod();

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  var _navigationService = locator<NavigationService>();

  //var storageService = locator<StorageService>();

  bool _active1 = false;
  double? finalPrice;
  double perc = 0.0;

  //bool _checkbox = false;

  //bool active2 = false;

  /*void toggle() {
    setState(() {
      _checkbox = !_checkbox;
    });
  }*/

  double? abc;

  @override
  void initState() {
    super.initState();
    finalPrice = context.read<OffersProvider>().finalPrice;
    context.read<PayByProvider>().getPayByDeviceId();
    //perc=double.parse(widget.price!)*0.025;
    perc = finalPrice! + finalPrice! * 0.025;
    print('this is the perc--$perc');
  }

  @override
  Widget build(BuildContext context) {
    //final double height = MediaQuery.of(context).size.height;
    //final double width = MediaQuery.of(context).size.width;
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithBackIconAndLanguage(
          onTapIcon: () {
            Navigator.pop(context);
          },
        ),
        body: Container(
          padding: EdgeInsets.all(15.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.translate("payment_method")!,
                    style: TextStyle(
                      height: 1.2,
                      fontSize: sy(20),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Visibility(
                        visible: context.read<PayByProvider>().payLater
                            ? false
                            : true,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate('cards')!,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: height * 0.016.h,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _active1 = true;
                                });
                              },
                              child: Container(
                                height: 60.h,
                                width: double.infinity,
                                padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  color: _active1
                                      ? Colors.pinkAccent.withOpacity(0.2)
                                      : Colors.white,
                                  border: Border.all(
                                    width: width * 0.003,
                                    color: _active1
                                        ? Colors.red
                                        : Colors.grey.shade200,
                                  ),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                margin: EdgeInsets.only(
                                  bottom: height * 0.010,
                                  top: height * 0.010,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      image:
                                          AssetImage("assets/images/payby.png"),
                                      width: 50.w,
                                      height: 50.w,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),

                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.translate('cash')!,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: height * 0.016.h,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _active1 = false;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10.h),
                              width: double.infinity,
                              height: 60.h,
                              decoration: BoxDecoration(
                                color: _active1
                                    ? Colors.white
                                    : Colors.pinkAccent.withOpacity(0.2),
                                border: Border.all(
                                  width: width * 0.003,
                                  color: _active1
                                      ? Colors.grey.shade200
                                      : Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              margin: EdgeInsets.only(
                                  bottom: height * 0.010, top: height * 0.010),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .translate('pay_via_kiosk')!,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .translate('default')!,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.blue),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /*widget.comingFrom
                      ? */
                  _active1
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            AppLocalizations.of(context)!
                                .translate('payby_terms')!,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        )
                      : Text(''),
                  /*InkWell(
                    onTap: () {
                      _launchURL();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: Theme.of(context).primaryColor,
                            side: BorderSide(
                              width: 2,
                              color: Colors.grey.shade400,
                            ),
                            value: _checkbox,
                            onChanged: (value) {
                              if (_checkbox == false) {
                                setState(() {
                                  _checkbox = true;
                                });
                              } else {
                                toggle();
                              }
                            },
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('pay_cash_check')!,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .translate('pay_cash_term')!,
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),*/
                  SizedBox(
                    height: 5,
                  ),
                  CustomButton(
                      height: 50.h,
                      width: double.infinity,
                      onPressed: () async {
                        if (_active1 == true) {
                          EasyLoading.show(
                              status: AppLocalizations.of(context)!
                                  .translate('please_wait')!);
                          context.read<PayByProvider>().payLater
                              ? context.read<PayByProvider>().isInstallment =
                                  true
                              : context.read<PayByProvider>().isInstallment =
                                  false;
                          await context
                              .read<PayByProvider>()
                              .payByOffersOrder(context);
                        } else {
                          /* if (_checkbox) {*/
                          EasyLoading.show(
                              status: AppLocalizations.of(context)!
                                  .translate('please_wait')!);

                          await context
                              .read<PayByProvider>()
                              .cashOffersOrder(context);
                          /*  } else {
                            Fluttertoast.showToast(
                              msg: AppLocalizations.of(context)!
                                  .translate('toast_check')!,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                            );
                          }*/
                        }
                      },
                      text: _active1
                          ? "${AppLocalizations.of(context)!.translate("pay")!} AED ${perc.toStringAsFixed(2)}"
                          : "${AppLocalizations.of(context)!.translate("pay")!} AED ${finalPrice!.toStringAsFixed(2)}"),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

/*_launchURL() async {
    const url =
        "https://b2-documents.s3.me-south-1.amazonaws.com/B2Connect+Terms+and+Conditions.pdf";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }*/
}
