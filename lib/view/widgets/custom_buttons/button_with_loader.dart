import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWithLoader extends StatelessWidget {
  const ButtonWithLoader({ this.text, this.onPressed, this.height, this.width, this.showLoader,this.clickEnableColor, this.onLongPress}) : super();
  final String? text;
  final VoidCallback? onLongPress;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final bool? showLoader;
  final bool? clickEnableColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width!,
      height: height!,
      decoration: BoxDecoration(
        gradient: //gradientColor,
        clickEnableColor == true || clickEnableColor == null? LinearGradient(
          colors: [
            Color.fromRGBO(217, 60, 84, 1.0),
            Color.fromRGBO(212, 52, 119, 1.0)
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ):LinearGradient(
          colors: [
            Colors.grey,
            Colors.grey,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8.0),
        // side: BorderSide(color: Colors.red),
      ),
      child: ElevatedButton(
        onLongPress: showLoader == false? onLongPress : (){},
        onPressed:  showLoader == false? onPressed: (){},
        style: ElevatedButton.styleFrom(
          elevation: 0,
          textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          primary: Colors.transparent,
        ),
        child: showLoader != null && showLoader != false? Center(
          child: Container(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                backgroundColor: Color(0xFFF7BFA5),
                valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFFFFFFFF)),
                strokeWidth: 3,
              )
          ),
        ): new Text(
          text!,
          // AppLocalizations.of(context)!.translate('proceed')!,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            //letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
