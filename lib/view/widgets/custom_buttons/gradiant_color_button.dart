import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final double? height;
  final double? width;
  final bool? arrowVisibility;


  const CustomButton(
      {Key? key, required this.text, required this.onPressed, this.onLongPress, this.height, this.width, this.arrowVisibility
      //  this.styles = const ButtonStyles(),
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  final btnStyles = ButtonStyles();
    return Container(
      width: width!,
      height: height!,
      decoration: BoxDecoration(
        gradient: gradientColor,
        borderRadius: BorderRadius.circular(8.0),
        // side: BorderSide(color: Colors.red),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          primary: Colors.transparent,
        ),
        child:
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Center(child: Text(text!,
              // AppLocalizations.of(context)!.translate('proceed')!,
              style: TextStyle(
                fontFamily: 'Lexend',
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                //letterSpacing: 1,
              ),))),
            Visibility(visible: arrowVisibility == null? false:true,child: Icon(Icons.arrow_forward)),
          ],

        ),
        /*new Text(
          text!,
          // AppLocalizations.of(context)!.translate('proceed')!,
          style: TextStyle(
            fontFamily: 'Lexend',
            color: Colors.white,
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            //letterSpacing: 1,
          ),
        ),*/
      ),
    );
  }
}
