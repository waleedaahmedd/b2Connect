import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton2 extends StatelessWidget {
  final String? txt;
  final VoidCallback? onTap;

  const CustomButton2({Key? key,this.txt,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 50.h,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.0),
        // side: BorderSide(color: Colors.red),
      ),
      child: ElevatedButton(
        onPressed: onTap!,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          primary: Colors.transparent,
        ),
        child: new Text(
          txt!,
          // AppLocalizations.of(context)!.translate('proceed')!,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
              fontSize: 16.sp, fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}
