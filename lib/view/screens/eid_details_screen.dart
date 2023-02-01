import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/tinted_color_button.dart';
import 'package:b2connect_flutter/view_model/providers/scanner_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../widgets/indicator.dart';

class EidDetailsScreen extends StatefulWidget {
  const EidDetailsScreen() : super();

  @override
  _EidDetailsScreenState createState() => _EidDetailsScreenState();
}

class _EidDetailsScreenState extends State<EidDetailsScreen> {
  late TextEditingController _nationalityController;
  late TextEditingController _genderController;
  late MaskedTextController _birthDateController;
  late MaskedTextController _expiryDateController;

  /*late TextEditingController _birthDateController;
  late TextEditingController _expiryDateController;*/

  @override
  void initState() {
    super.initState();
    _nationalityController = new TextEditingController(
        text:
            '${Provider.of<ScannerProvider>(context, listen: false).userEmiratesData.emiratesNationality}');
    _genderController = new TextEditingController(
        text:
            '${Provider.of<ScannerProvider>(context, listen: false).userEmiratesData.emiratesGender}');
    _birthDateController = MaskedTextController(
        mask: '00/00/0000',
        text:
            '${Provider.of<ScannerProvider>(context, listen: false).userEmiratesData.emiratesBirthday}');
    //  _birthDateController = new TextEditingController(text: '${Provider.of<ScannerProvider>(context, listen: false).userEmiratesData.emiratesBirthday}');
    _expiryDateController = MaskedTextController(
        mask: '00/00/0000',
        text:
            '${Provider.of<ScannerProvider>(context, listen: false).userEmiratesData.emiratesExpiry}');
    // _expiryDateController = new TextEditingController(text: '${Provider.of<ScannerProvider>(context, listen: false).userEmiratesData.emiratesExpiry}');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScannerProvider>(builder: (context, i, _) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithBackIconAndLanguage(
          onTapIcon: () {
            var count = 0;
            Navigator.popUntil(context, (route) {
              i.setScanBusy(true);
              i.setCardType(0);
              i.setCardFace(0);
              // i.controller!.stopImageStream();

              return count++ == 2;
            });
          },
        ),
        body: WillPopScope(
          onWillPop: () {
            var count = 0;
            Navigator.popUntil(context, (route) {
              i.setScanBusy(true);
              i.setCardType(0);
              i.setCardFace(0);
              //  i.controller!.stopImageStream();

              return count++ == 2;
            });
            return Future.value(false);
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IndicatorWidget("3"),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    "Confirm Your Details",
                    style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Full Name',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        enabled: false,
                        //controller: phoneNumberTextMask,
                        decoration: InputDecoration(
                            hintText: '${i.userEmiratesData.emiratesName}',
                            hintStyle: TextStyle(fontWeight: FontWeight.w200),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Emirates ID',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        enabled: false,
                        //controller: phoneNumberTextMask,
                        decoration: InputDecoration(
                            hintText: '${i.userEmiratesData.emiratesId}',
                            hintStyle: TextStyle(fontWeight: FontWeight.w200),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Nationality',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        enabled: true,
                        controller: _nationalityController,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.edit,
                              size: 14.h,
                              color: Theme.of(context).primaryColor,
                            ),
                            hintText:
                                '${i.userEmiratesData.emiratesNationality}',
                            hintStyle: TextStyle(fontWeight: FontWeight.w200),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Gender',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        enabled: false,
                        controller: _genderController,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.edit,
                              size: 14.h,
                              color: Theme.of(context).primaryColor,
                            ),
                            hintText: 'Male',
                            hintStyle: TextStyle(fontWeight: FontWeight.w200),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Date of birth',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        enabled: true,
                        controller: _birthDateController,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.edit,
                              size: 14.h,
                              color: Theme.of(context).primaryColor,
                            ),
                            hintText: 'Date/Month/Year',
                            hintStyle: TextStyle(fontWeight: FontWeight.w200),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Expiry date of EID',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: TextField(
                        enabled: true,
                        controller: _expiryDateController,
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.edit,
                              size: 14.h,
                              color: Theme.of(context).primaryColor,
                            ),
                            hintText: 'Date/Month/Year',
                            hintStyle: TextStyle(fontWeight: FontWeight.w200),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CustomButton(
                      height: 62,
                      width: 500,
                      text: 'Submit',
                      onPressed: () async {
                        i.onBackPressed(context);
                        i.userEmiratesData.emiratesExpiry =
                            _expiryDateController.text;
                        i.userEmiratesData.emiratesBirthday =
                            _birthDateController.text;
                        i.userEmiratesData.emiratesGender =
                            _genderController.text;
                        i.userEmiratesData.emiratesNationality =
                            _nationalityController.text;
                        EasyLoading.show(
                            status: 'Saving Emirates ID...');
                        await Provider.of<ScannerProvider>(context,
                                listen: false)
                            .sendEmiratesData(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
