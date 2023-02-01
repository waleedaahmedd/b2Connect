import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'change_language_bottom_sheet.dart';

class LanguageSelectionButton extends StatefulWidget {
  const LanguageSelectionButton({Key? key}) : super(key: key);

  @override
  _LanguageSelectionButtonState createState() => _LanguageSelectionButtonState();
}

class _LanguageSelectionButtonState extends State<LanguageSelectionButton> {
  @override
  Widget build(BuildContext context) {
    // final double width = MediaQuery.of(context).size.width;
    return Container(
      // width: width * 0.36,
      height: 30.h,
      //  padding: EdgeInsets.only(right: 5.h),

      child: ElevatedButton(
        onPressed: () {
          changeLanguageBottomSheet(context);
        },
        style: ElevatedButton.styleFrom(
            elevation: 0,
            textStyle: TextStyle(
              fontSize: 12.sp,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            primary: Colors.grey[200]),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: new Text(
                // "hello",
                AppLocalizations.of(context)!.translate('select')!,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12.sp,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w500,
                ),
                // textAlign: TextAlign.end,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: RotatedBox(
                quarterTurns: 3,
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.black,
                  size: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void changeLanguageBottomSheet(context) {
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
      },
    );
  }

//non
}

