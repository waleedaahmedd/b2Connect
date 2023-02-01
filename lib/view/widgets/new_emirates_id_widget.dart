import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:b2connect_flutter/view_model/providers/scanner_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewEmiratesIdWidget extends StatefulWidget {
  final bool? enableEditing;

  const NewEmiratesIdWidget({Key? key, this.enableEditing}) : super(key: key);

  @override
  _NewEmiratesIdWidgetState createState() => _NewEmiratesIdWidgetState();
}

class _NewEmiratesIdWidgetState extends State<NewEmiratesIdWidget> {
  //late final Text verificationText;
  // late final Icon verificationIcon;
  String? submitText;
  TextEditingController emiratesIdTextMask1 = TextEditingController();
  TextEditingController emiratesIdTextMask2 = TextEditingController();
  TextEditingController emiratesIdTextMask3 = TextEditingController();
  TextEditingController emiratesIdTextMask4 = TextEditingController();

  MaskedTextController? _expiryDateController;
  FocusNode emiratesIdFocus2 = FocusNode();
  FocusNode emiratesIdFocus3 = FocusNode();
  FocusNode emiratesIdFocus4 = FocusNode();
  String? eidHint1;
  String? eidHint2;
  String? eidHint3;
  String? eidHint4;
  String? expiryHint;
  DateTime selectedDate = DateTime.now();
  List<String>? _currentDate;

  @override
  void dispose() {
    // TODO: implement dispose
    emiratesIdTextMask1.clear();
    emiratesIdTextMask2.clear();
    emiratesIdTextMask3.clear();
    emiratesIdTextMask4.clear();
    _expiryDateController!.clear();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var formatter = new DateFormat('dd-MM-yyyy');
    String currentDate = formatter.format(selectedDate);
    _currentDate = currentDate.split('-');

    if (Provider.of<AuthProvider>(context, listen: false)
            .userInfoData!
            .emiratesExpiry ==
        0) {
      expiryHint = 'DD/MM/YYYY';
    } else {
      expiryHint = Provider.of<AuthProvider>(context, listen: false).expiryDate;
    }

    _expiryDateController = MaskedTextController(mask: '00/00/0000', text: '');

    emiratesIdTextMask1.text = '';
    emiratesIdTextMask2.text = '';
    emiratesIdTextMask3.text = '';
    emiratesIdTextMask4.text = '';

    if (Provider.of<AuthProvider>(context, listen: false)
            .emiratesIdList
            .length <
        4) {
      submitText = "Save Emirates Id";
      eidHint1 = '000';
      eidHint2 = '0000';
      eidHint3 = '0000000';
      eidHint4 = '0';
    } else {
      submitText = "Update Emirates Id";
      eidHint1 =
          Provider.of<AuthProvider>(context, listen: false).emiratesIdList[0];
      eidHint2 =
          Provider.of<AuthProvider>(context, listen: false).emiratesIdList[1];
      eidHint3 =
          Provider.of<AuthProvider>(context, listen: false).emiratesIdList[2];
      eidHint4 =
          Provider.of<AuthProvider>(context, listen: false).emiratesIdList[3];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(3),
                  ],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  enabled: widget.enableEditing,
                  controller: emiratesIdTextMask1,
                  onChanged: (value) {
                    Provider.of<AuthProvider>(context, listen: false)
                        .saveEmiratesIdTextMask1(value);
                    removeHints();
                    if (value.length > 2) {
                      FocusScope.of(context).requestFocus(emiratesIdFocus2);
                    }
                  },
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(emiratesIdFocus2);
                  },
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: eidHint1,
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Flexible(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                  ],
                  focusNode: emiratesIdFocus2,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  enabled: widget.enableEditing,
                  controller: emiratesIdTextMask2,
                  onChanged: (value) {
                    Provider.of<AuthProvider>(context, listen: false)
                        .saveEmiratesIdTextMask2(value);
                    removeHints();

                    if (value.length > 3) {
                      FocusScope.of(context).requestFocus(emiratesIdFocus3);
                    }
                  },
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(emiratesIdFocus3);
                  },
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: eidHint2,
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Flexible(
              flex: 7,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(7),
                  ],
                  focusNode: emiratesIdFocus3,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  enabled: widget.enableEditing,
                  controller: emiratesIdTextMask3,
                  onChanged: (value) {
                    Provider.of<AuthProvider>(context, listen: false)
                        .saveEmiratesIdTextMask3(value);
                    removeHints();

                    if (value.length > 6) {
                      FocusScope.of(context).requestFocus(emiratesIdFocus4);
                    }
                  },
                  onSubmitted: (value) {
                    FocusScope.of(context).requestFocus(emiratesIdFocus4);
                  },
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: eidHint3,
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(5)),
                child: TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                  ],
                  focusNode: emiratesIdFocus4,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  enabled: widget.enableEditing,
                  controller: emiratesIdTextMask4,
                  onChanged: (value) {
                    Provider.of<AuthProvider>(context, listen: false)
                        .saveEmiratesIdTextMask4(value);
                    removeHints();


                  },

                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: eidHint4,
                      border: InputBorder.none),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Container(
          width: 500.w,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Row(
              children: [
                Text(
                  'Exp: ',
                  style: TextStyle(color: Colors.grey),
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      if (widget.enableEditing!) {
                        _selectDate(context);

                      } else {}
                    },
                    child: TextField(
                      enabled: false,
                      keyboardType: TextInputType.number,
                      controller: _expiryDateController,
                      /*onChanged: (value){
                        Provider.of<AuthProvider>(context, listen: false).saveExpiryDateController(value);
                        Provider.of<AuthProvider>(context, listen: false).saveChangeInEid(true);
                      },*/
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: expiryHint,
                          border: InputBorder.none),
                      /* onSubmitted: (value) {
                       // setEmirateIdDetails(context);
                      },*/
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        /* Visibility(
          visible: widget.enableEditing!,
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () async {
                    //setEmirateIdDetails(context);
                  },
                  child: Text(
                    submitText!,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500, */ /*letterSpacing: 0.5*/ /*
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),*/

        /* Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CustomButton(
                height: 62,
                width: 500,
                text: 'Submit Emirates Id',
                onPressed: () async {
                  */ /*i.controller!.stopImageStream();
                  i.setScanBusy(false);
                  i.setCardType(0);
                  i.setCardFace(0);*/ /*
                  Provider.of<ScannerProvider>(context, listen: false).userEmiratesData.emiratesExpiry = _expiryDateController.text;
                  Provider.of<ScannerProvider>(context, listen: false).userEmiratesData.emiratesId = emiratesIdTextMask.text;

                  */ /* i.userEmiratesData.emiratesBirthday = _birthDateController.text;
                  i.userEmiratesData.emiratesGender = _genderController.text;
                  i.userEmiratesData.emiratesNationality = _nationalityController.text;*/ /*
                  EasyLoading.show(status: 'Saving Emirates ID...');
                  FocusScope.of(context).unfocus();
                  await Provider.of<ScannerProvider>(context, listen: false)
                      .sendEmiratesData(context);

                },
              ),
            ),*/
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      builder: (BuildContext context, Widget ?child) {
        return Theme(
           data: ThemeData(
            primarySwatch: Colors.grey,
            splashColor: Colors.black,
            textTheme: TextTheme(
              subtitle1: TextStyle(color: Colors.black),
              button: TextStyle(color: Colors.black),
            ),
            accentColor: Colors.black,
            colorScheme: ColorScheme.light(
                primary: Theme.of(context).primaryColor,
                primaryVariant: Colors.black,
                secondaryVariant: Colors.black,
                onSecondary: Colors.black,
                onPrimary: Colors.white,
                surface: Colors.black,
                onSurface: Colors.black,
                secondary: Colors.black),
            dialogBackgroundColor: Colors.white,
          ),
          child: child ??Text(""),
        );
      },
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: DateTime(int.parse(_currentDate![2]),
          int.parse(_currentDate![1]), int.parse(_currentDate![0])+1),
      firstDate: DateTime(int.parse(_currentDate![2]),
          int.parse(_currentDate![1]), int.parse(_currentDate![0])+1),
      lastDate: DateTime(2090),
    );
    if (selected != null && selected != selectedDate){
      var formatter = new DateFormat('dd-MM-yyyy');
      String currentSelectedDate = formatter.format(selected);
      String replaceDash = currentSelectedDate.toString().replaceAll("-", "/");
      Provider.of<AuthProvider>(context, listen: false).saveChangeInExpiry(true);

      setState(() {
        _expiryDateController!.text = replaceDash;
        Provider.of<AuthProvider>(context, listen: false).saveExpiryDateController(replaceDash);
      });
    }

  }

  void removeHints() {
    Provider.of<AuthProvider>(context, listen: false).saveChangeInEid(true);
    Provider.of<AuthProvider>(context, listen: false).saveChangeInExpiry(true);

    setState(() {
      eidHint1 = '';
      eidHint2 = '';
      eidHint3 = '';
      eidHint4 = '';
      expiryHint = 'DD/MM/YYYY';
    });
  }
}
