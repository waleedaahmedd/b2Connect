import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/services/util_service.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/screens/view_all_service_screen.dart';
import 'package:b2connect_flutter/view/widgets/appBar_with_cart_notification_widget.dart';
import 'package:b2connect_flutter/view/widgets/service_type_bottom_sheet.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:b2connect_flutter/view_model/providers/pay_by_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditNumberTopUpScreen extends StatefulWidget {
/*
  final ProductDetailsModel? _productDetailsData;
*/
  const EditNumberTopUpScreen(/*this._productDetailsData*/) : super();

  @override
  _EditNumberTopUpScreenState createState() => _EditNumberTopUpScreenState();
}

class _EditNumberTopUpScreenState extends State<EditNumberTopUpScreen> {
  final TextEditingController _phnController = TextEditingController();
  Color _txtFieldColor = Colors.transparent;
  String? _validator;
  Color? _validateColor = Colors.green;
  String _phneNumberWcuntryCode = '';
  int? _selectedIndex;
  var utilsService = locator<UtilService>();

  List<dynamic> _serviceProviderList = [
    {
      'name': 'Du',
      'color': '4284513675',
      'type': 'Prepaid',
      'logo': 'assets/images/du.png'
    },
    {
      'name': 'Etisalat',
      'color': '4294930176',
      'type': 'Prepaid',
      'logo': 'assets/images/etisalat.png'
    },
    {
      'name': 'Virgin',
      'color': '4294930176',
      'type': 'eVoucher',
      'logo': 'assets/images/virgin.png'
    },
    /*{
      'name': 'Swyp',
      'color': '4294930176',
      'type': 'Prepaid',
      'logo': 'assets/images/swyp.png'
    }*/
  ];

  @override
  void initState() {
    _phnController.text = Provider.of<AuthProvider>(context, listen: false)
        .userInfoData!
        .uid
        .toString()
        .substring(3);
    if (_phnController.text.isNotEmpty) {
      _validator = 'Looks Good';
      Provider.of<PayByProvider>(context, listen: false).topUpMobileNumber =
          _phnController.text;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Consumer<PayByProvider>(builder: (context, i, _) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBarWithCartNotificationWidget(
          title: 'Top-Up',
          onTapIcon: () {
            navigationService.closeScreen();
          },
        ),
        /* AppBarWithBackIconAndLanguage(
          onTapIcon: () {
            Navigator.pop(context);
            i.offerItemsOrder.clear();
          },
        ),*/
        body: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            return Future.value(false);
          },
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      AppLocalizations.of(context)!.translate('mobile_top_up')!,
                        style: TextStyle(
                            fontSize: 30.sp,
                            //letterSpacing: 1.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        '${AppLocalizations.of(context)!.translate('top_up_description')!} 5xxxxxxxx',
                        style: TextStyle(
                            fontSize: 14.sp,
                            //letterSpacing: 1,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF757575)),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            navigationService.navigateTo(TopUpIntroScreenRoute);
                          },
                          child: Text(
                            AppLocalizations.of(context)!
                                .translate('how_to_recharge')!,
                            style: TextStyle(
                                fontSize: 14.sp,
                                //letterSpacing: 1,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text(
                        AppLocalizations.of(context)!.translate('number')!,
                        style: TextStyle(
                            fontSize: 16.sp,
                            //letterSpacing: 1,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        //color: Colors.red,
                        //padding: EdgeInsets.only(left: 5, right: 5),
                        //
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 30.h,
                              //width: width * 0.25,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: new BorderRadius.circular(5.0),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 22.h,
                                    width: 22.w,
                                    child: Image.asset(
                                        'assets/images/united-arab-emirates.png'),
                                  ),
                                  SizedBox(
                                    width: 2.w,
                                  ),
                                  Text(
                                    '+971',
                                    //style: GoogleFonts.poppins(),
                                  ),
                                  RotatedBox(
                                    quarterTurns: 3,
                                    child: Icon(
                                      Icons.chevron_left,
                                      color: Colors.black,
                                      size: 18,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Container(
                              height: 30.h,
                              width: width * 0.65,
                              child: TextFormField(
                                controller: _phnController,
                                textInputAction: TextInputAction.done,
                                //autofocus: true,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(9),
                                ],

                                onChanged: (value) {
                                  checkPhoneNumber(value, i);
                                },
                                keyboardType: TextInputType.number,
                                // keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                                // TextInputType.numberWithOptions(
                                //   signed: true, decimal: true),

                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5.0,
                                    horizontal: 20,
                                  ),

                                  suffixIcon: _phnController.value.text.isEmpty
                                      ? Text(' ')
                                      : GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _phnController.clear();
                                              _validator = 'Wrong Input';
                                              _validateColor = Colors.red;
                                            });
                                          },
                                          child: Icon(
                                            Icons.clear,
                                            color: Colors.black,
                                          )),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelText: '5xxxxxxxx',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13.sp,
                                  ),
                                  // hintText: AppLocalizations.of(context)!.translate('numberDigits')!,
                                  // hintStyle: TextStyle(
                                  //   color: Colors.black,
                                  //   fontSize: 12.h,
                                  // ),
                                  filled: true,
                                  fillColor: Colors.grey.shade200,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: _txtFieldColor,
                                      width: 0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _validator != null
                              ? Text(
                                  '$_validator',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      letterSpacing: 0.2,
                                      fontWeight: FontWeight.w500,
                                      color: _validateColor),
                                )
                              : Text(' '),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .translate('service_providers')!,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                         /* GestureDetector(
                            onTap: () async {
                              EasyLoading.show(status: 'Please Wait...');

                              await getServiceDetail(context, "");

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewAllServiceScreen(
                                        // categoryId: 493,
                                        )),
                              );
                              *//*  Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ServiceProviderListScreen(
                                              _serviceProviderList,
                                              'Service Providers',
                                              validator: _validator == null
                                                  ? 'Wrong Input'
                                                  : _validator)));*//*
                            },
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                AppLocalizations.of(context)!
                                    .translate('view_all')!,
                                style: TextStyle(
                                    //fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
                /*  Text(
                  "B2Connect",
                  style: TextStyle(
                      fontSize: 30.sp,
                      //letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),*/

                ListView.builder(
                    shrinkWrap: true,
                    itemCount: _serviceProviderList.length,
                    //physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: new BoxDecoration(
                            border: new Border(
                                bottom: new BorderSide(
                                    color: Colors.grey.shade300))),
                        child: ListTile(
                          leading: Image.asset(
                            _serviceProviderList[index]['logo'],
                            height: 30.h,
                          ),
                          title: Text(
                            '${_serviceProviderList[index]['name']}',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                          selectedTileColor: Theme.of(context).primaryColor,
                          selected:
                              _selectedIndex != null && _selectedIndex == index,
                          selectedColor: Colors.white,
                          onTap: () {
                            if (_validator == null ||
                                _validator == 'Wrong Input') {
                              final snackBar = SnackBar(
                                content: Text(
                                  AppLocalizations.of(context)!
                                      .translate('enter_valid_number')!,
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              setState(() {
                                _selectedIndex = index;
                                index == 0
                                    ? _serviceTypeBottomSheet(
                                        '${_serviceProviderList[index]['name']}')
                                    : serviceTypeDetail(
                                        '${_serviceProviderList[index]['name']}');
                              });
                            }
                          },
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> getServiceDetail(BuildContext context, String _name) async {
    await Provider.of<OffersProvider>(context, listen: false)
        .getOffers(perPage: 10, name: _name);
  }

  void _serviceTypeBottomSheet(serviceProviderList) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
          ),
        ),
        context: context,
        builder: (BuildContext bc) {
          return ServiceTypeBottomSheet(serviceProviderList);
        });
  }

  /* Future<void> payNow() async {
    EasyLoading.show(
        status: AppLocalizations.of(context)!.translate('please_wait')!);
    await Provider.of<PayByProvider>(context, listen: false).getPayByDeviceId();
    await Provider.of<PayByProvider>(context, listen: false)
        .addServicesToOfferItems(widget._productDetailsData!.offer.id);
    await Provider.of<PayByProvider>(context, listen: false)
        .payByServiceOrder(context);
  }*/

  void checkPhoneNumber(
    String value,
    PayByProvider editNumber,
  ) {
    editNumber.topUpMobileNumber = _phnController.text;

    if (value.isEmpty || value.length < 9) {
      setState(() {
        _validator = AppLocalizations.of(context)!.translate('wrong_input')!;
        _validateColor = Colors.red;
        _txtFieldColor = Colors.red;
      });
    } else {
      setState(() {
        _validator = AppLocalizations.of(context)!.translate('looks_good')!;
        _validateColor = Colors.green;
        _txtFieldColor = Colors.green;

        if (value.length == 9) {
          FocusScope.of(context).requestFocus(FocusNode());
          // _phneNumberWcuntryCode = '971$value';
          // editNumber.topUpMobileNumber = value;
        }
      });
    }
    /* _phneNumberWcuntryCode = '971$value';
    print('input number-$value');
    if (_phnController.text.isEmpty) {
      setState(() {
        _txtFieldColor = Colors.transparent;
      });
    } else if (_phnController.text.length < 9) {
      print("else if");
      setState(() {
        _txtFieldColor = Colors.red;
      });
    } else {
      print("else");
      setState(() {
        _txtFieldColor = Colors.green;
      });
    }*/
  }

  serviceTypeDetail(String name) async {
    EasyLoading.show(status: 'Please Wait...');

    await getServiceDetail(context, name);

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ViewAllServiceScreen(
                name: name,
                // categoryId: 493,
              )),
    );
  }
}
