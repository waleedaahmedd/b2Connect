import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget gradientTabs({context,Gradient? gradientColor1,Gradient? gradientColor2,Gradient? gradientColor3}){

  final double width = MediaQuery.of(context).size.width;
  return Container(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 20.0,),
    child: Row(
      children: [
        Container(
          width: width * 0.29,
          height: 3.0.h,
          margin: EdgeInsets.symmetric(
              vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: gradientColor1
          ),
        ),
        Container(
          width: width * 0.29,
          height: 3.0.h,
          margin: EdgeInsets.symmetric(
              vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: gradientColor2
          ),
        ),
        Container(
          width: width * 0.29,
          height: 3.0.h,
          margin: EdgeInsets.symmetric(
              vertical: 8.0, horizontal: 4.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: gradientColor3
          ),
        ),
      ],
    ),
  );
}
//
// Widget sizedBox({double? height,double? width}){
//   return SizedBox(
//     height: height,
//     width: width,
//   );
// }
// Widget img(String url, {double? height,double? scale}){
//   return Image.asset(
//     url,
//     scale: scale,
//     height: height,
//   );
// }
//
// AppBar gradientAppBar(Widget title,{List<Widget>? actions}){
//   return AppBar(
//     automaticallyImplyLeading: false,
//     elevation: 0,
//     toolbarHeight: ScreenSize.appbarHeight,
//     title: title,
//     actions: actions,
//
//     flexibleSpace: Container(
//       decoration: BoxDecoration(
//           gradient: gradientColor
//       ),
//     ),
//   );
// }
//
// local(context,String? txt){
//   return "${AppLocalizations.of(context!)!.translate("$txt")!}";
// }
