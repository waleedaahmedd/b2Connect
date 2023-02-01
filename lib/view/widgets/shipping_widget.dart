// import 'package:b2connect_flutter/model/locale/app_localization.dart';
// import 'package:b2connect_flutter/model/utils/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// // ignore: must_be_immutable
// class ShippingWidget extends StatefulWidget {
//   final data;
//   final active;
//   ValueChanged<String>? action;
//   String? tag;
//   ShippingWidget({
//     this.action,
//     this.active,
//     this.data,
//     this.tag,
//   });
//
//   @override
//   _ShippingWidgetState createState() => _ShippingWidgetState();
// }
//
// class _ShippingWidgetState extends State<ShippingWidget> {
//   void handleTap() {
//     widget.action!(widget.tag!);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: handleTap,
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 1,
//             color: widget.active
//                 ? Theme.of(context).primaryColor
//                 : Colors.grey.shade400,
//           ),
//           borderRadius: BorderRadius.circular(5),
//         ),
//         padding: EdgeInsets.only(
//           left: 15.w,
//           right: 15.w,
//           top: 20.h,
//           bottom: 20.h,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       widget.data["name"],
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10.w,
//                     ),
//                     widget.active
//                         ? Container(
//                             width: 60.w,
//                             height: 15.h,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(30),
//                               ),
//                               gradient: gradientColor,
//                             ),
//                             child: Text(
//                               AppLocalizations.of(context)!.translate('default')!,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12.sp,
//                               ),
//                             ),
//                             alignment: Alignment.center,
//                           )
//                         : Text(' '),
//                   ],
//                 ),
//                 widget.active!
//                     ? Container(
//                         width: 25.h,
//                         height: 25.h,
//                         decoration: BoxDecoration(
//                           // shape: BoxShape.circle,
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(50),
//                           ),
//                           gradient: gradientColor
//                         ),
//                         child: Icon(
//                           Icons.check,
//                           color: Colors.white,
//                           size: 18.h,
//                         ),
//                       )
//                     : Text(' '),
//               ],
//             ),
//             SizedBox(
//               height: 15.h,
//             ),
//             Text(
//               widget.data["address"],
//               style: TextStyle(
//                 color: Colors.grey.shade500,
//                 fontWeight: FontWeight.w400,
//                 fontSize: 14.sp,
//               ),
//             ),
//             SizedBox(
//               height: 5.h,
//             ),
//             Row(
//               children: [
//                 Text(
//                   "Mobile: ",
//                   style: TextStyle(
//                     color: Colors.grey.shade500,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14.sp,
//                   ),
//                 ),
//                 Text(
//                   widget.data["no"],
//                   style: TextStyle(
//                     color: Colors.grey.shade500,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14.sp,
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 5.h,
//             ),
//             Row(
//               children: [
//                 Text(
//                   "Email: ",
//                   style: TextStyle(
//                     color: Colors.grey.shade500,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14.sp,
//                   ),
//                 ),
//                 Text(
//                   widget.data["mail"],
//                   style: TextStyle(
//                     color: Colors.grey.shade500,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14.sp,
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 5.h,
//             ),
//             Row(
//               children: [
//                 Text(
//                   widget.data["nationality"],
//                   style: TextStyle(
//                     color: Colors.grey.shade500,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14.sp,
//                   ),
//                 ),
//                 Text(
//                   widget.data["gender"],
//                   style: TextStyle(
//                     color: Colors.grey.shade500,
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14.sp,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 15.h,
//             ),
//             Row(
//               children: [
//                 TextButton(
//                   style: TextButton.styleFrom(
//                     fixedSize: Size(40.w, 45.h),
//                     backgroundColor: Theme.of(context).primaryColor,
//                     primary: Colors.white,
//                   ),
//                   onPressed: () {},
//                   child: Text(
//                     AppLocalizations.of(context)!.translate('edit_button')!,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14.sp,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 30.w,
//                 ),
//                 InkWell(
//                   onTap: () {},
//                   child: ImageIcon(
//                     AssetImage(
//                     ),
//                     size: 22.h,
//                     color: Colors.grey.shade500,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 30.w,
//                 ),
//                 widget.active
//                     ? Text(' ')
//                     : Text(
//                       AppLocalizations.of(context)!
//                           .translate('make_this_deflaut')!,
//                       style: TextStyle(
//                         color: Theme.of(context).primaryColor,
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ShippingWidget extends StatefulWidget {
  final String? name;
  final String? number;
  final String? gender;

  ShippingWidget({
    this.name,
    this.number,
    this.gender
    // this.data,
    // this.tag,
  });

  @override
  _ShippingWidgetState createState() => _ShippingWidgetState();
}

class _ShippingWidgetState extends State<ShippingWidget> {
  // void handleTap() {
  //   widget.action!(widget.tag!);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.18,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).primaryColor

        ),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 15.h,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 20,
                    //color: Colors.red,
                    width: MediaQuery.of(context).size.width*0.5,
                    child: Text(
                      widget.name!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                   Container(
                    width: 60.w,
                    height: 15.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      gradient: gradientColor,
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.translate('default')!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                    alignment: Alignment.center,
                  )

                ],
              ),
               Container(
                width: 25.h,
                height: 25.h,
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    gradient: gradientColor
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18.h,
                ),
              )

            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          // Text(
          //   "widget.data[address]",
          //   style: TextStyle(
          //     color: Colors.grey.shade500,
          //     fontWeight: FontWeight.w400,
          //     fontSize: 14.sp,
          //   ),
          // ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            "Mobile: ${widget.number}",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          // Row(
          //   children: [
          //     Text(
          //       "Email: ",
          //       style: TextStyle(
          //         color: Colors.grey.shade500,
          //         fontWeight: FontWeight.w400,
          //         fontSize: 14.sp,
          //       ),
          //     ),
          //     // Text(
          //     //   widget.data["mail"],
          //     //   style: TextStyle(
          //     //     color: Colors.grey.shade500,
          //     //     fontWeight: FontWeight.w400,
          //     //     fontSize: 14.sp,
          //     //   ),
          //     // )
          //   ],
          // ),
          SizedBox(
            height: 5.h,
          ),
          Container(

            child: Text(
              "United Arab Emirates, ${widget.gender!}",
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
              ),
            ),
          ),
          // Row(
          //   children: [
          //     Text(
          //       "United Arab Emirates, ${widget.gender!}",
          //       style: TextStyle(
          //         color: Colors.grey.shade500,
          //         fontWeight: FontWeight.w400,
          //         fontSize: 14.sp,
          //       ),
          //     ),
          //     // Text(
          //     //   widget.gender!,
          //     //   style: TextStyle(
          //     //     color: Colors.grey.shade500,
          //     //     fontWeight: FontWeight.w400,
          //     //     fontSize: 14.sp,
          //     //   ),
          //     // ),
          //   ],
          // ),
          /*SizedBox(
            height: 15.h,
          ),*/
          // Row(
          //   children: [
          //     TextButton(
          //       style: TextButton.styleFrom(
          //         //fixedSize: Size(45.w, 45.h),
          //         backgroundColor: Theme.of(context).primaryColor,
          //         primary: Colors.white,
          //       ),
          //       onPressed: () {},
          //       child: Text(
          //         AppLocalizations.of(context)!.translate('edit_button')!,
          //         style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 14.sp,
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       width: 30.w,
          //     ),
          //     InkWell(
          //       onTap: () {},
          //       child: ImageIcon(
          //         AssetImage(
          //           "assets/images/del.png",
          //         ),
          //         size: 22.h,
          //         color: Colors.grey.shade500,
          //       ),
          //     ),
          //     SizedBox(
          //       width: 30.w,
          //     ),
          //     // widget.active
          //     //     ? Text(' ')
          //     //     : Text(
          //     //   AppLocalizations.of(context)!
          //     //       .translate('make_this_deflaut')!,
          //     //   style: TextStyle(
          //     //     color: Theme.of(context).primaryColor,
          //     //     fontSize: 16.sp,
          //     //     fontWeight: FontWeight.w600,
          //     //   ),
          //     // ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

