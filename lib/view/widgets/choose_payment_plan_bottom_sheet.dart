import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/screens/emi_details_screen.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:b2connect_flutter/view_model/providers/pay_by_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'custom_buttons/gradiant_color_button.dart';

class ChoosePaymentPlanBottomSheet extends StatefulWidget {
  final double? totalPriceNow;

  //final double? totalPriceLater;
  const ChoosePaymentPlanBottomSheet(
      {Key? key, this.totalPriceNow /*,this.totalPriceLater*/
      })
      : super(key: key);

  @override
  _ChoosePaymentPlanBottomSheetState createState() =>
      _ChoosePaymentPlanBottomSheetState();
}

class _ChoosePaymentPlanBottomSheetState
    extends State<ChoosePaymentPlanBottomSheet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var navigationService = locator<NavigationService>();

  //bool _checkbox = false;

//bool _checkbox1 = false;

  /*void toggle() {
    setState(() {
      _checkbox = !_checkbox;
    });
  }*/

  String? price;

  @override
  Widget build(BuildContext context) {
    return Consumer<OffersProvider>(builder: (context, i, _) {
      return Container(
        child: new Wrap(
          children: <Widget>[
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Payment Plans',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                /*Divider(
                thickness: 1,
                // height: 20.h,
              ),*/
                SizedBox(
                  height: 30.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5.0),
                    child: Text(
                      'B2 Pay Now: UpFront',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18.sp),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
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
                          value: i.payNowCheckBox,
                          onChanged: (value) {
                            i.setPayNowCheckBox(true);
                            i.setAddOn3xCheckBox(false);
                            i.setAddOn6xCheckBox(false);
                            i.setPayLater3xCheckBox(false);
                            i.setPayLater6xCheckBox(false);
                            // setState(() {
                            //   _checkbox = !_checkbox;
                            // });
                          },
                        ),
                      ),
                      Text(
                        'B2 Pay Now: 100 % payment',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 15.sp),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: i.updatedThreeInstallmentPrice ==
                         i.totalPriceNow
                      ? false
                      : true,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          child: Text(
                            'B2 Pay Later: Payment Plan',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18.sp),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
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
                                value: i.payLater3xCheckBox,
                                onChanged: (value) {
                                  i.setPayNowCheckBox(false);
                                  i.setAddOn3xCheckBox(false);
                                  i.setAddOn6xCheckBox(false);
                                  i.setPayLater3xCheckBox(true);
                                  i.setPayLater6xCheckBox(false);

                                  // setState(() {

                                  //   _checkbox = !_checkbox;

                                  // });
                                },
                              ),
                            ),
                            Text(
                              'B2 Pay Later: 3 Months EMI Plan',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15.sp),
                            )
                          ],
                        ),
                      ),
                      //TODO: REMOVE 6X INSTALLMENT
                       Visibility(
                         visible: i.updatedSixInstallmentPrice == 0.0? false : true,
                         child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
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
                                  value: i.payLater6xCheckBox,
                                  onChanged: (value) {
                                    i.setPayNowCheckBox(false);
                                    i.setAddOn3xCheckBox(false);
                                    i.setAddOn6xCheckBox(false);
                                    i.setPayLater3xCheckBox(false);
                                    i.setPayLater6xCheckBox(true);

                                    // setState(() {

                                    //   _checkbox = !_checkbox;

                                    // });
                                  },
                                ),
                              ),
                              Text(
                                'B2 Pay Later: 6 Months EMI Plan',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15.sp),
                              )
                            ],
                          ),
                      ),
                       ),
                      //TODO: REMOVE 6X INSTALLMENT
                        Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          child: Text(
                            'Payment Plans with Add-On',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18.sp),
                          ),
                        ),
                      ),
                      //TODO: REMOVE 6X INSTALLMENT

                       Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
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
                                value: i.addOn3xCheckBox,
                                onChanged: (value) {
                                  i.setPayNowCheckBox(false);
                                  i.setAddOn3xCheckBox(true);
                                  i.setAddOn6xCheckBox(false);
                                  i.setPayLater3xCheckBox(false);
                                  i.setPayLater6xCheckBox(false);

                                  // setState(() {

                                  //   _checkbox = !_checkbox;

                                  // });
                                },
                              ),
                            ),
                            Text(
                              'B2 Pay Later: 3 Months EMI with Wi-Fi',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15.sp),
                            )
                          ],
                        ),
                      ),
                      //TODO: REMOVE 6X INSTALLMENT

                        Visibility(
                          visible: i.updatedSixInstallmentPrice == 0.0? false : true,
                          child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
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
                                  value: i.addOn6xCheckBox,
                                  onChanged: (value) {
                                    i.setPayNowCheckBox(false);
                                    i.setAddOn3xCheckBox(false);
                                    i.setAddOn6xCheckBox(true);
                                    i.setPayLater3xCheckBox(false);
                                    i.setPayLater6xCheckBox(false);

                                    // setState(() {

                                    //   _checkbox = !_checkbox;

                                    // });
                                  },
                                ),
                              ),
                              Text(
                                'B2 Pay Later: 6 Months EMI with Wi-Fi',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15.sp),
                              )
                            ],
                          ),
                      ),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 1,
                  // height: 20.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        i.addOn6xCheckBox || i.addOn3xCheckBox || i.payLater6xCheckBox || i.payLater3xCheckBox ? '1st EMI Amount' : 'Total Amount: ',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.w500),
                      ),
                      Text(
                          i.payLater3xCheckBox
                              ? 'AED ${i.updatedThreeInstallmentPrice.toStringAsFixed(2)}'
                              :  i.payLater6xCheckBox? 'AED ${i.updatedSixInstallmentPrice.toStringAsFixed(2)}'
                              :i.addOn3xCheckBox? 'AED ${i.updatedThreePriceAddon.toStringAsFixed(2)}':
                          i.addOn6xCheckBox? 'AED ${i.updatedSixPriceAddon.toStringAsFixed(2)}':
                          'AED ${widget.totalPriceNow!.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor))
                    ],
                  ),
                ),
                /* Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.translate('pay_now')!,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Text(
                      'AED ${widget.totalPriceNow!.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: priceColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Theme.of(context).primaryColor,
                      side: BorderSide(
                        width: 2,
                        color: Colors.grey.shade400,
                      ),
                      value: !_checkbox,
                      onChanged: (value) {
                        if (_checkbox == false) {
                          setState(() {
                            _checkbox = false;
                          });
                        } else {
                          toggle();
                        }

                        // setState(() {
                        //   _checkbox = !_checkbox;
                        // });
                      },
                    ),
                  ],
                ),
              ),*/
                /* Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppLocalizations.of(context)!.translate('buy_upfront')!,
                    style: TextStyle(
                        color: Colors.grey,
                        //  fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                ),
              ),
              Visibility(
                visible: Provider.of<OffersProvider>(context, listen: false)
                            .updatedInstallmentPrice ==
                        Provider.of<OffersProvider>(context, listen: false)
                            .totalPriceNow
                    ? false
                    : true,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .translate('pay_later')!,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                          Text(
                            'AED ${Provider.of<OffersProvider>(context, listen: false).updatedInstallmentPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: priceColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: Theme.of(context).primaryColor,
                            side: BorderSide(
                              width: 2,
                              color: Colors.grey.shade400,
                            ),
                            value: _checkbox,
                            onChanged: (value) {
                              if (_checkbox == true) {
                                setState(() {
                                  _checkbox = true;
                                });
                              } else {
                                toggle();
                              }

                              // setState(() {

                              //   _checkbox = !_checkbox;

                              // });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 20.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.translate('buy_3x')!,
                          style: TextStyle(
                              color: Colors.grey,

                              //  fontWeight: FontWeight.bold,

                              fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),*/
             /*   InkWell(
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
                ),*/
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomButton(
                    height: 50.h,
                    width: double.infinity,
                    onPressed: () async {
                      Navigator.pop(context);
                      //_paymentPlanBottomSheet(context);
                      /* EasyLoading.show(status: 'Please Wait');
                            await context
                                .read<PayByProvider>()
                                .payByOffersOrder(context);*/

                   /*   if (_termsCheckbox == true) {*/
                      if (i.payLater3xCheckBox) {
                        i.setFinalEmiScreenDescription('B2 Pay Later: 3 Months EMI Plan');
                        i.setFinalPrice(i.updatedThreeInstallmentPrice);
                        context.read<PayByProvider>().tenure = 3;
                        context.read<PayByProvider>().isInstallment = true;
                        context.read<PayByProvider>().isAddon = false;
                       nevigateToEmiDetail(i);
                      }
                      else if (i.payLater6xCheckBox) {
                        i.setFinalEmiScreenDescription('B2 Pay Later: 6 Months EMI Plan');
                        i.setFinalPrice(i.updatedSixInstallmentPrice);
                        context.read<PayByProvider>().tenure = 6;
                        context.read<PayByProvider>().isInstallment = true;
                        context.read<PayByProvider>().isAddon = false;
                        nevigateToEmiDetail(i);
                      }
                      else if (i.addOn3xCheckBox) {
                        i.setFinalEmiScreenDescription('B2 Pay Later: 3 Months EMI with Wi-Fi');
                        i.setFinalPrice(i.updatedThreePriceAddon);
                        context.read<PayByProvider>().tenure = 3;
                        context.read<PayByProvider>().isInstallment = true;
                        context.read<PayByProvider>().isAddon = true;
                        nevigateToEmiDetail(i);
                      }
                      else if (i.addOn6xCheckBox) {
                        i.setFinalEmiScreenDescription('B2 Pay Later: 6 Months EMI with Wi-Fi');
                        i.setFinalPrice(i.updatedSixPriceAddon);
                        context.read<PayByProvider>().tenure = 6;
                        context.read<PayByProvider>().isInstallment = true;
                        context.read<PayByProvider>().isAddon = true;
                        nevigateToEmiDetail(i);
                      }
                      else{
                        i.setFinalEmiScreenDescription('');
                        i.setFinalPrice(i.totalPriceNow);
                        Provider.of<PayByProvider>(context, listen: false)
                            .payLater = false;
                        context.read<PayByProvider>().tenure = 0;
                        context.read<PayByProvider>().isInstallment = false;
                        context.read<PayByProvider>().isAddon = false;
                        navigationService.navigateTo(ShippingScreenRoute);
                      }




                        /*  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShippingScreen(
                                    paymentTypeCheckBox: !_checkbox)));*/
                    /*  } else {*/
                      /*  EasyLoading.showError(
                            'Please accept our payment terms to proceed');*/
                      }

                      //navigationService.navigateTo(PaymentMethodScreenRoute);
                   /* }*/,
                    text: 'Proceed',
                  ),
                )

                /* Container(
                height: 110,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ElevatedButton(
                      onPressed: () {
                        navigationService.navigateTo(AddShippingAddressScreenRoute);


                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.transparent,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.translate('shipping_address1')!,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        navigationService.navigateTo(AddShippingAddressScreenRoute);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.transparent,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.translate('billing_address1')!,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),*/
                /*  SizedBox(
                height: height * 0.010,
              ),*/
                /*Padding(
                padding: EdgeInsets.all(8.0.h),
                child: Container(
                  height: 6,
                  width: width * 0.35,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),*/
              ],
            ),
          ],
        ),
      );
    });
  }

  void nevigateToEmiDetail(OffersProvider i) {
    Provider.of<PayByProvider>(context, listen: false)
        .payLater = i.payLater3xCheckBox || i.payLater6xCheckBox || i.addOn3xCheckBox || i.addOn6xCheckBox? true: false;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EmiDetailsScreen()));
  }


}
