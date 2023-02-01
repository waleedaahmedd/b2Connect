import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view_model/providers/pay_by_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SuccessScreen extends StatefulWidget {
  final String comingFrom;

  const SuccessScreen({required this.comingFrom}) : super();

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    // Provider.of<OffersProvider>(context, listen: false).totalPriceNow=0.0;
    // Provider.of<OffersProvider>(context, listen: false).totalPriceLater=0.0;
    // Provider.of<OffersProvider>(context, listen: false).cartData.clear();
    // Provider.of<OffersProvider>(context, listen: false).productIds.clear();
    // Provider.of<OffersProvider>(context, listen: false).onlySmartPhone = false;

    // Provider.of<OffersProvider>(context, listen: false).totalPriceNow=0.0;
    // Provider.of<OffersProvider>(context, listen: false).totalPriceLater=0.0;
    //
    // Provider.of<OffersProvider>(context, listen: false).clearProduct();
    // Provider.of<OffersProvider>(context, listen: false).clearCartData();
    // Provider.of<OffersProvider>(context, listen: false).onlySmartPhone = false;
    //
    // Provider.of<OffersProvider>(context, listen: false).showLoader=true;
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            if (widget.comingFrom == 'topup') {
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
          /*  widget.comingFrom == 'topup'?  Navigator.pop(context):
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
                    widget.comingFrom == 'cash'
                        ?
                    Text.rich(
                      TextSpan(
                        // with no TextStyle it will have default text style
                        text:
                        '${AppLocalizations.of(context)!.translate('success_thanks_1')!}',
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                            '${Provider.of<PayByProvider>(context, listen: false).orderNumber == null ? " " : ' # ${Provider.of<PayByProvider>(context, listen: false).orderNumber}'}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                          TextSpan(
                            text:
                            '${AppLocalizations.of(context)!.translate('success_thanks_2')!}',
                            style: TextStyle(
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ):

                    Text.rich(
                      TextSpan(
                        // with no TextStyle it will have default text style
                        text:
                            '${AppLocalizations.of(context)!.translate('success_thanks_1')!}',
                        style: TextStyle(
                          color: Colors.grey[400],
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                '${Provider.of<PayByProvider>(context, listen: false).orderNumber == null ? " " : ' # ${Provider.of<PayByProvider>(context, listen: false).orderNumber}'}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
                          ),
                          TextSpan(
                            text:
                                '${AppLocalizations.of(context)!.translate('success_thanks_3')!}',
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
                    Visibility(
                        visible: widget.comingFrom == 'cash' ? false : true,
                        child: Text(
                          'Reference Number: #${Provider.of<PayByProvider>(context, listen: false).paymentOrderId}',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Theme.of(context).primaryColor,
                            //fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )),

                    Visibility(
                      visible: widget.comingFrom == 'cash' ? true : false,
                      child: InkWell(
                          onTap: () {
                            _navigationService
                                .navigateTo(CashPaymentIntroScreenRoute);
                          },
                          child: Text(
                            AppLocalizations.of(context)!
                                .translate('how_to_deposit')!,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          )),
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
                    Visibility(
                        visible: widget.comingFrom == 'cash' ? false : true,
                        child: Text(
                          'B2Connect will not support on any service provider issues. Please reach corresponding service provider support for further assistance.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      onPressed: () {
                        if (widget.comingFrom == 'topup') {
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

                       /* widget.comingFrom == 'topup'?  Navigator.pop(context):
                        _navigationService.navigateTo(HomeScreenRoute);*/
                      },
                      text: AppLocalizations.of(context)!.translate('back')!,
                      height: height * 0.07,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          ]),
    ));
  }
}
