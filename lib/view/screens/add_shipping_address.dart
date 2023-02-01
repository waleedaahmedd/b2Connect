import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AddShippingAddress extends StatefulWidget {
  const AddShippingAddress({Key? key}) : super(key: key);

  @override
  _AddShippingAddressState createState() => _AddShippingAddressState();
}

class _AddShippingAddressState extends State<AddShippingAddress> {

  final TextEditingController _phnController = TextEditingController();
  String _phneNumberWcuntryCode = '';
  Color _txtFieldColor = Colors.transparent;
  Color? _validateColor = Colors.green;
  String? _validator;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithBackIconAndLanguage(
        onTapIcon: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: 15.w,
            right: 15.w,
            top: 10.h,
            bottom: 10.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!
                    .translate('add_shipiing_address')!,
                style: TextStyle(
                  fontSize: 36.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  height: 1.1.h,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                AppLocalizations.of(context)!.translate('number')!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 30.h,
                      width: width * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 22.h,
                            width: 22.w,
                            child: Image.asset(
                              'assets/images/united-arab-emirates.png',
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            '+971',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          RotatedBox(
                            quarterTurns: 3,
                            child: Icon(
                              Icons.chevron_left,
                              color: Colors.grey.shade500,
                              size: 18.h,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Container(
                      height: 30.h,
                      color: Colors.grey.shade200,
                      width: width * 0.63,
                      child: TextFormField(
                        controller: _phnController,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(9),
                        ],
                        onChanged: (value) {
                          if (value.length > 9 ||
                              value.isEmpty ||
                              value.length < 8) {
                            setState(() {
                              _validator = 'Wrong input';
                              _validateColor = Colors.red;
                            });
                          } else {
                            setState(() {
                              _validator = 'Looks Good';
                              _validateColor = Colors.green;
                            });
                          }

                          _phneNumberWcuntryCode = '971$value';
                          if (_phnController.text.isEmpty) {
                            setState(() {
                              _txtFieldColor = Colors.transparent;
                            });
                          } else if (_phnController.text.length < 8) {
                            setState(() {
                              _txtFieldColor = Colors.red;
                            });
                          } else {
                            setState(() {
                              _txtFieldColor = Colors.green;
                            });
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 8.h,
                            horizontal: 20.w,
                          ),
                          labelText: AppLocalizations.of(context)!
                              .translate('numberDigits')!,
                          labelStyle: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                          filled: true,
                          suffixIcon: _phnController.value.text.isEmpty
                              ? Text(' ')
                              : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _phnController.clear();
                                    });
                                  },
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.grey.shade500,
                                  )),
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
                height: 15.h,
              ),
              Text(
                AppLocalizations.of(context)!.translate('email_add')!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: double.infinity,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    isDense: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8.0.h,
                      horizontal: 20.w,
                    ),
                    hintText: "Enter Your Email",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
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
              SizedBox(
                height: 15.h,
              ),
              Text(
                AppLocalizations.of(context)!.translate('room_no')!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: double.infinity,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    isDense: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8.0.h,
                      horizontal: 20.w,
                    ),
                    hintText: "Enter Your Room/Flat Number",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
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
              SizedBox(
                height: 15.h,
              ),
              Text(
                AppLocalizations.of(context)!.translate('building_no')!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: double.infinity,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    isDense: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8.0.h,
                      horizontal: 20.w,
                    ),
                    hintText: "Enter Your Building/Cluster Number",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
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
              SizedBox(
                height: 15.h,
              ),
              Text(
                AppLocalizations.of(context)!.translate('building_name')!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: double.infinity,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    isDense: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8.0.h,
                      horizontal: 20.w,
                    ),
                    hintText: "Enter Your Building Name",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
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
              SizedBox(
                height: 15.h,
              ),
              Text(
                AppLocalizations.of(context)!.translate('location')!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: double.infinity,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    isDense: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8.0.h,
                      horizontal: 20.w,
                    ),
                    hintText: "Enter Your Location",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
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
              SizedBox(
                height: 15.h,
              ),
              Text(
                AppLocalizations.of(context)!.translate('state')!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: double.infinity,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    isDense: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 8.0.h,
                      horizontal: 20.w,
                    ),
                    hintText: "Enter Your State",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
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
              SizedBox(
                height: 15.h,
              ),
              Text(
                AppLocalizations.of(context)!.translate('country')!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              // Container(
              //   width: double.infinity,
              //   child: TextFormField(
              //     keyboardType: TextInputType.text,
              //     decoration: InputDecoration(
              //       isDense: true,
              //       floatingLabelBehavior: FloatingLabelBehavior.never,
              //       contentPadding: EdgeInsets.symmetric(
              //         vertical: 8.0.h,
              //         horizontal: 20.w,
              //       ),
              //       hintText: "Enter Your Country",
              //       hintStyle: TextStyle(
              //         color: Colors.grey.shade600,
              //         fontSize: 14.sp,
              //         fontWeight: FontWeight.w500,
              //       ),
              //       filled: true,
              //       fillColor: Colors.grey.shade200,
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: Colors.transparent,
              //           width: 0,
              //         ),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(
              //           color: txtFieldColor,
              //           width: 0,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                height: 35.h,
                child: _buildCountryPickerDropdownSoloExpanded(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_buildCountryPickerDropdownSoloExpanded(context) {
  return CountryPickerDropdown(
    onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
    onValuePicked: (Country country) {
      print("${country.name}");
    },
    itemBuilder: (Country country) {
      return Row(
        children: <Widget>[
          SizedBox(width: 10.w),
          // CountryPickerUtils.getDefaultFlagImage(country),
          SizedBox(width: 10.w),
          Text(
            country.name,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    },
    itemHeight: kMinInteractiveDimension,
    isExpanded: true,
    initialValue: 'AE',
    icon: Padding(
      padding: EdgeInsets.only(
        right: 10.w,
      ),
      child: Icon(
        Icons.keyboard_arrow_down,
        size: 18.h,
      ),
    ),
  );
}
