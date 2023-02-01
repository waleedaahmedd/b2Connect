import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/view/screens/payment_method_screen.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view/widgets/new_emirates_id_widget.dart';
import 'package:b2connect_flutter/view/widgets/shipping_widget.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:b2connect_flutter/view_model/providers/pay_by_provider.dart';
import 'package:b2connect_flutter/view_model/providers/scanner_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ShippingScreen extends StatefulWidget {
  // final double? totalPriceNow;

/*
  final double? totalPriceLater;
*/



  const ShippingScreen(
      {Key? key,
      })
      : super(key: key);

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  bool _checkbox = true;
  bool eidVerified = false;

  // String tagId = ' ';
  //
  // void active(
  //   dynamic val,
  // ) {
  //   setState(() {
  //     tagId = val;
  //   });
  // }

  // List shippingdetail = [
  //   {
  //     "id": "1",
  //     "name": "Hyder Ali",
  //     "address": "C101, Al Dhabi Building, Al Dhabi",
  //     "no": "+ 917 9099 9909",
  //     "mail": "Hyderali@example.com",
  //     "nationality": "Indian, ",
  //     "gender": "Male",
  //   },
  //   {
  //     "id": "2",
  //     "name": "Aiman Khan",
  //     "address": "C101, Al Burj Building, Al Burj",
  //     "no": "+ 917 8499 8088",
  //     "mail": "Aimankhan@example.com",
  //     "nationality": "Indian, ",
  //     "gender": "Female",
  //   },
  // ];
  // List shippingdetail1 = [
  //   {
  //     "id": "3",
  //     "name": "Hyder Ali",
  //     "address": "C101, Al Dhabi Building, Al Dhabi",
  //     "no": "+ 917 9099 9909",
  //     "mail": "Hyderali@example.com",
  //     "nationality": "Indian, ",
  //     "gender": "Male",
  //   },
  //   {
  //     "id": "4",
  //     "name": "Aiman Khan",
  //     "address": "C101, Al Burj Building, Al Burj",
  //     "no": "+ 917 8499 8088",
  //     "mail": "Aimankhan@example.com",
  //     "nationality": "Indian, ",
  //     "gender": "Female",
  //   },
  // ];

  final TextEditingController _salesAgentCode = TextEditingController();
  final TextEditingController _orderComment = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Provider.of<AuthProvider>(context, listen: false)
                .userInfoData!
                .emiratesId ==
            "" ||
        Provider.of<AuthProvider>(context, listen: false).emiratesIdList[0] !=
            "784") {
      eidVerified = false;
    } else {
      eidVerified = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, i, _) {
      return WillPopScope(
        onWillPop: () {
          i.saveChangeInEid(false);
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            appBar: AppBarWithBackIconAndLanguage(
              onTapIcon: () {
                i.saveChangeInEid(false);
                navigationService.closeScreen();
              },
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.h),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .translate('ship_to')!,
                              style: TextStyle(
                                fontSize: 36.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                height: 1.1.h,
                              ),
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     _addressModalBottomSheet(context);
                            //   },
                            //   child: Icon(
                            //     Icons.add,
                            //     color: Theme.of(context).primaryColor,
                            //     size: 30.h,
                            //   ),
                            // )
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .translate('shipping_address')!,
                          style: TextStyle(
                            color: Colors.black,
                            //fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          //shippingdetail.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ShippingWidget(
                              name:
                                  "${i.userInfoData!.firstName} ${i.userInfoData!.lastName}",
                              //data: "${i.userInfoData!.firstName} ${i.userInfoData!.lastName}",//shippingdetail[index],
                              gender: i.userInfoData!.emiratesGender,
                              number: i.userInfoData!.uid,
                              // tag: i.userInfoData!.uid,//shippingdetail[index]['id'],
                              // action: active,
                              // active: tagId == shippingdetail[index]['id'] ? true : false,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 10.h,
                            );
                          },
                        ),
                        // SizedBox(
                        //   height: 30.h,
                        // ),
                        // Text(
                        //   AppLocalizations.of(context)!.translate('billing_address')!,
                        //   style: TextStyle(
                        //     color: Colors.grey.shade700,
                        //     fontSize: 16.sp,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 15.h,
                        // ),
                        // ListView.separated(
                        //   physics: NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   itemCount: shippingdetail.length,
                        //   itemBuilder: (BuildContext context, int index) {
                        //     return ShippingWidget(
                        //       data: shippingdetail1[index],
                        //       tag: shippingdetail1[index]['id'],
                        //       action: active,
                        //       active:
                        //           tagId == shippingdetail1[index]['id'] ? true : false,
                        //     );
                        //   },
                        //   separatorBuilder: (BuildContext context, int index) {
                        //     return SizedBox(
                        //       height: 10.h,
                        //     );
                        //   },
                        // ),

                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "EMIRATES ID",
                                style: TextStyle(
                                  color: Colors.black,
                                  //fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            eidVerified
                                ? Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.info_outline,
                                    color: Colors.red,
                                  ),
                            SizedBox(
                              width: 5.w,
                            ),
                            eidVerified
                                ? Text(
                                    AppLocalizations.of(context)!
                                        .translate('verified')!,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                : Text(
                                    AppLocalizations.of(context)!
                                        .translate('not_verified')!,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        NewEmiratesIdWidget(enableEditing: true),
                        /*Visibility(
                          visible: i.userInfoData!.emiratesId == "" ? true : false,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScanYourEmiratesIDScreen()))
                                    .then((value) {
                                  */ /* setState(() {
                                          checkEmiratesId();
                                        });*/ /*
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                textStyle: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(6.0),
                                ),
                                primary: Theme.of(context).primaryColor,
                              ),
                              child: Text(AppLocalizations.of(context)!
                                  .translate('scan_now')!)),
                        ),*/
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'Please enter your valid Emirates ID Number as mentioned in its respective field.',
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        /* Text('SALES AGENT CODE'),*/

                        Text(
                          AppLocalizations.of(context)!
                              .translate('sales_promo_code')!,
                          style: TextStyle(
                            color: Colors.black,
                            //fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          controller: _salesAgentCode,
                          decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 15.0,
                              ),
                              isDense: true,
                              // Added this
                              // border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: AppLocalizations.of(context)!
                                  .translate('sales_promo_code_hint')!
                              //labelText: 'Sales Agent Code'
                              ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .translate('order_comment')!,
                          style: TextStyle(
                            color: Colors.black,
                            //fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          controller: _orderComment,
                          decoration: new InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 15.0,
                              ),
                              isDense: true,
                              // Added this
                              // border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: AppLocalizations.of(context)!
                                  .translate('optional')!

                              //labelText: 'Sales Agent Code'
                              ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Theme.of(context).primaryColor,
                              side: BorderSide(
                                width: 2.w,
                                color: Colors.grey.shade400,
                              ),
                              value: _checkbox,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox = !_checkbox;
                                });
                              },
                            ),
                            Text(
                              AppLocalizations.of(context)!
                                  .translate('ship_checkbox_text')!,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        //Text(context.read<PayByProvider>().deviceId.toString()),

                        CustomButton(
                          height: 50.h,
                          width: double.infinity,
                          onPressed: () async {
                            i.userInfoData!.emiratesId == "" &&
                                    i.changeInEid == false
                                ? _showToast(context)
                                : setEmirateIdDetails(context, i);

                            /* EasyLoading.show(status: 'Please Wait');
                              await context
                                  .read<PayByProvider>()
                                  .payByOffersOrder(context);*/
                            //navigationService.navigateTo(PaymentMethodScreenRoute);
                          },
                          text: AppLocalizations.of(context)!
                              .translate('ship_next_button')!,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            /*Consumer<AuthProvider>(builder: (context, i, _) {*/
            /*return*/
            /* }*/
          ),
        ),
      );
    });
  }

  Future<void> setEmirateIdDetails(BuildContext context, AuthProvider i) async {
    FocusScope.of(context).unfocus();

    if (i.changeInEid == true && i.changeInExpiry == true) {
      if (i.emiratesIdTextMask1 == '' ||
          i.emiratesIdTextMask1 != '784' ||
          i.emiratesIdTextMask1!.length != 3 ||
          i.emiratesIdTextMask2!.length != 4 ||
          i.emiratesIdTextMask3!.length != 7 ||
          i.emiratesIdTextMask4!.length != 1 ||
          i.emiratesIdTextMask2 == '' ||
          i.emiratesIdTextMask3 == '' ||
          i.emiratesIdTextMask4 == '' ||
          i.emiratesIdTextMask1 == '000' ||
          i.emiratesIdTextMask2 == '0000' ||
          i.emiratesIdTextMask3 == '0000000') {
        EasyLoading.showError('Please enter valid Emirates Id');
      } else {
        //var expiry = i.expiryDateController!.split('/');
        if (i.expiryDateController == null) {
          EasyLoading.showError('Please enter Expiry Date');
        } else {
          /* if (int.parse(expiry[0]) > 31 ||
              int.parse(expiry[1]) > 12 ) {
            EasyLoading.showError('Please enter valid Expiry Date');
          } else {*/
          Provider.of<ScannerProvider>(context, listen: false)
              .userEmiratesData
              .emiratesExpiry = i.expiryDateController!;
          Provider.of<ScannerProvider>(context, listen: false)
                  .userEmiratesData
                  .emiratesId =
              '${i.emiratesIdTextMask1}-${i.emiratesIdTextMask2}-${i.emiratesIdTextMask3}-${i.emiratesIdTextMask4}';
          EasyLoading.show(status: 'Saving Emirates ID...');
          await Provider.of<ScannerProvider>(context, listen: false)
              .sendEmiratesData(context);
          setState(() {
            eidVerified = true;
          });
          setSalesAgentCodeAndOrderCommint(i);
          /*}*/
        }
      }
    } else if (i.changeInExpiry == true) {
      if (i.userInfoData!.emiratesId == "") {
        EasyLoading.showError('Please enter valid Emirates Id');
      } else {
        Provider.of<ScannerProvider>(context, listen: false)
            .userEmiratesData
            .emiratesId = i.userInfoData!.emiratesId;
        Provider.of<ScannerProvider>(context, listen: false)
            .userEmiratesData
            .emiratesExpiry = i.expiryDateController!;
        EasyLoading.show(status: 'Saving Emirates ID...');
        await Provider.of<ScannerProvider>(context, listen: false)
            .sendEmiratesData(context);
        setSalesAgentCodeAndOrderCommint(i);
      }
    } else {
      setSalesAgentCodeAndOrderCommint(i);
      Provider.of<AuthProvider>(context, listen: false).saveChangeInEid(false);
      Provider.of<AuthProvider>(context, listen: false)
          .saveChangeInExpiry(false);
    }
  }

  void setSalesAgentCodeAndOrderCommint(AuthProvider i) {
    Provider.of<PayByProvider>(context, listen: false).salesAgentCode =
        _salesAgentCode.text;
    Provider.of<PayByProvider>(context, listen: false).comment =
        _orderComment.text;
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PaymentMethod(
               )));
    i.saveChangeInEid(false);
  }
}

void _showToast(BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: const Text(
          'Please enter your valid Emirates ID details to continue!'),
      // action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
