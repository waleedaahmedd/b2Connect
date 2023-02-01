import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EmiDetailsScreen extends StatefulWidget {
  const EmiDetailsScreen({Key? key}) : super(key: key);

  @override
  State<EmiDetailsScreen> createState() => _EmiDetailsScreenState();
}

class _EmiDetailsScreenState extends State<EmiDetailsScreen> {
  String? _firstInstallmentDate;
  String? _secondInstallmentDate;
  String? _thirdInstallmentDate;
  String? _fourthInstallmentDate;
  String? _fifthInstallmentDate;
  bool _termsCheckbox = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstInstallmentDate = DateFormat("LLL dd, yyyy")
        .format(DateTime.now().add(Duration(days: 30)));
    _secondInstallmentDate = DateFormat("LLL dd, yyyy")
        .format(DateTime.now().add(Duration(days: 60)));
    _thirdInstallmentDate = DateFormat("LLL dd, yyyy")
        .format(DateTime.now().add(Duration(days: 90)));
    _fourthInstallmentDate = DateFormat("LLL dd, yyyy")
        .format(DateTime.now().add(Duration(days: 120)));
    _fifthInstallmentDate = DateFormat("LLL dd, yyyy")
        .format(DateTime.now().add(Duration(days: 150)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBarWithBackIconAndLanguage(
      onTapIcon: () {
        navigationService.closeScreen();
      },
    ), body: Consumer<OffersProvider>(builder: (context, i, _) {
      return Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 40.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'EMI Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 25.sp,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 20.0),
                child: Text(
                  '${i.finalEmiScreenDescription}',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 15.sp),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Card(
                elevation: 5.0,
                borderOnForeground: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 30),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 15.w,
                                  width: 15.w,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                                                               ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate('pay_just')!,
                                        style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        'AED ${i.finalPrice!.toStringAsFixed(2)}${AppLocalizations.of(context)!.translate('own_today')!}',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 2, bottom: 2),
                                child: Container(
                                    height: 30,
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Image.asset('assets/images/downArrow.png'))),
                              ),
                            Row(
                              children: [
                                Container(
                                  height: 15.w,
                                  width: 15.w,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade400,

                                      /*border: Border.all(
                                        color: Colors.grey,
                                      ),*/
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15))),
                                /*  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      AppLocalizations.of(context)!.translate('2')!,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),*/
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate('next_installment')!,
                                        style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        'AED ${i.finalPrice!.toStringAsFixed(2)}${AppLocalizations.of(context)!.translate('due_on')!}$_firstInstallmentDate',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, top: 2, bottom: 2),
                              child: Container(
                                  height: 30,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Image.asset('assets/images/downArrow.png'))),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 15.w,
                                  width: 15.w,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade400,

                                      /*border: Border.all(
                                        color: Colors.grey,
                                      ),*/
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                                  /*  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      AppLocalizations.of(context)!.translate('2')!,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),*/
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        i.addOn3xCheckBox || i.payLater3xCheckBox
                                            ? AppLocalizations.of(context)!
                                                .translate('last_installment')!
                                            : AppLocalizations.of(context)!
                                                .translate('next_installment')!,
                                        style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        'AED ${i.finalPrice!.toStringAsFixed(2)}${i.addOn3xCheckBox || i.payLater3xCheckBox ? AppLocalizations.of(context)!.translate('is_on')! : AppLocalizations.of(context)!.translate('due_on')!}$_secondInstallmentDate',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Visibility(
                          visible: i.payLater6xCheckBox || i.addOn6xCheckBox,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 2, bottom: 2),
                                child: Container(
                                    height: 30,
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child:
                                            Image.asset('assets/images/downArrow.png'))),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 15.w,
                                    width: 15.w,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400,

                                        /*border: Border.all(
                                        color: Colors.grey,
                                      ),*/
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                    /*  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      AppLocalizations.of(context)!.translate('2')!,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),*/
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .translate('next_installment')!,
                                          style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          'AED ${i.finalPrice!.toStringAsFixed(2)}${AppLocalizations.of(context)!.translate('due_on')!}$_thirdInstallmentDate',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              //fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 2, bottom: 2),
                                child: Container(
                                    height: 30,
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child:
                                            Image.asset('assets/images/downArrow.png'))),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 15.w,
                                    width: 15.w,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400,

                                        /*border: Border.all(
                                        color: Colors.grey,
                                      ),*/
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                    /*  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      AppLocalizations.of(context)!.translate('2')!,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),*/
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .translate('next_installment')!,
                                          style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          'AED ${i.finalPrice!.toStringAsFixed(2)}${AppLocalizations.of(context)!.translate('due_on')!}$_fourthInstallmentDate',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              //fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 2, bottom: 2),
                                child: Container(
                                    height: 30,
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child:
                                            Image.asset('assets/images/downArrow.png'))),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 15.w,
                                    width: 15.w,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400,

                                        /*border: Border.all(
                                        color: Colors.grey,
                                      ),*/
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                    /*  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    child: Text(
                                      AppLocalizations.of(context)!.translate('2')!,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),*/
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .translate('last_installment')!,
                                          style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          'AED ${i.finalPrice!.toStringAsFixed(2)}${AppLocalizations.of(context)!.translate('is_on')!}$_fifthInstallmentDate',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              //fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    _launchURL();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: 1.5,
                          child: Checkbox(
                            checkColor: Colors.white,
                            activeColor: Theme.of(context).primaryColor,
                            side: BorderSide(
                              width: 1,
                              color: Colors.grey.shade400,
                            ),
                            value: _termsCheckbox,
                            onChanged: (value) {
                              setState(() {
                                _termsCheckbox = value!;
                              });
                            },
                          ),
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
                ),
                CustomButton(
                  height: 50.h,
                  width: double.infinity,
                  onPressed: () async {
                    //_paymentPlanBottomSheet(context);
                    /* EasyLoading.show(status: 'Please Wait');
                                await context
                                    .read<PayByProvider>()
                                    .payByOffersOrder(context);*/

                    if (_termsCheckbox == true) {
                      Navigator.pop(context);
                      navigationService.navigateTo(ShippingScreenRoute);
                    } else {
                      EasyLoading.showError(
                          'Please accept our payment terms to proceed');
                    }

                    //navigationService.navigateTo(PaymentMethodScreenRoute);
                  },
                  text: 'Confirm & Continue',
                ),
              ],
            ),
          )
        ],
      );
    }));
  }

  _launchURL() async {
    const url =
        "https://b2-documents.s3.me-south-1.amazonaws.com/B2Connect+Terms+and+Conditions.pdf";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
