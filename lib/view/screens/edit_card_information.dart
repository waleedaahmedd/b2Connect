import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../model/locale/app_localization.dart';
import '../../view/widgets/change_language_bottom_sheet.dart';
import '../../view/widgets/column_scroll_view.dart';

class EditCardScreen extends StatefulWidget {
  EditCardScreen({Key? key}) : super(key: key);

  @override
  _EditCardScreenState createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  TextEditingController _dateFromController = TextEditingController();
  DateTime _selectedFromDate = DateTime.now();

  Future<Null> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Theme.of(context).primaryColor,
                onSurface: Colors.black,
              ),
              buttonTheme: ButtonThemeData(
                colorScheme: ColorScheme.light(
                  primary: Theme.of(context).primaryColor,
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: _selectedFromDate,
        initialDatePickerMode: DatePickerMode.year,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        _selectedFromDate = picked;
        _dateFromController.text = DateFormat.yMMM().format(_selectedFromDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: Colors.black,
            size: 24.h,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _settingModalBottomSheet(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: Colors.grey.shade200,
              ),
              padding: EdgeInsets.all(8.h),
              height: 30.h,
              width: 110.w,
              child: Row(
                children: [
                  new Text(
                    AppLocalizations.of(context)!.translate('select')!,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                    size: 20.h,
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: ColumnScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: 15.w,
                right: 15.w,
              ),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Edit Card\nInformation",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30.sp,
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Cardholder Name",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        autocorrect: true,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0.h,
                            horizontal: 20.w,
                          ),
                          hintText: 'Megan Langdon',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                              width: 0.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Card Number",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        autocorrect: true,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0.h,
                            horizontal: 20.w,
                          ),
                          hintText: '4235 6262 1626 3452',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                              width: 0.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Expriy Date",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      height: 50.h,
                      child: TextFormField(
                        readOnly: true,
                        onTap: () {
                          _selectFromDate(context);
                        },
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                        controller: _dateFromController,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0.h,
                            horizontal: 20.w,
                          ),
                          hintText: '02/2023',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                              width: 0.w,
                            ),
                          ),
                          suffix: Padding(
                            padding: EdgeInsets.all(0),
                            child: Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "CVV",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Container(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        autocorrect: true,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0.h,
                            horizontal: 20.w,
                          ),
                          hintText: '⚫ ⚫ ⚫',
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                              width: 0.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  textStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  primary: Colors.transparent,
                ),
                child: Container(
                  child: new Text(
                    "Delete Card",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  textStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  primary: Theme.of(context).primaryColor,
                ),
                child: new Text(
                  AppLocalizations.of(context)!.translate('member')!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30.0),
            topLeft: Radius.circular(30.0),
          ),
        ),
        context: context,
        builder: (BuildContext bc) {
          return ChangeLanguageBottomSheet();
        });
  }
}
