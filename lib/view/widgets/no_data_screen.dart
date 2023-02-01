import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoDataScreen extends StatelessWidget {
  final String title;
  final String desc;
  final String buttontxt;
  final VoidCallback ontap;
  const NoDataScreen({Key? key,required this.title,required this.desc,required this.ontap,required this.buttontxt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithBackIconAndLanguage(
        onTapIcon: (){
          navigationService.closeScreen();
        },
      ),
      body: Padding(
        padding:  EdgeInsets.all(20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              title,
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w500,
                //height: 1.1.h,
              ),
            ),
/*
            SizedBox(height: 10,),
*/
            Column(
             // crossAxisAlignment: CrossAxisAlignment.center,

              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(
                  width: double.infinity,
                  child: Center(
                    child: Image(
                      image: AssetImage(
                        "assets/images/error.jpg",
                      ),
                      width: 200.w,
                      height: 200.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
               /* SizedBox(
                  height: 40.h,
                ),*/
               /* Text(
                  AppLocalizations.of(context)!.translate('oh_no')!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.5),
                ),*/
                Text(
                  desc,
                 // AppLocalizations.of(context)!.translate('oh_no_desc')!,
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.3),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            CustomButton(
              height: height * 0.07,
              width: double.infinity,
              onPressed: ontap,

              text: buttontxt,//AppLocalizations.of(context)!.translate('back')!,
            ),
           // SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}


// Widget noWifiScreen(context) {
//   final double height = MediaQuery.of(context).size.height;
//   return Padding(
//     padding:  EdgeInsets.all(15.h),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//
//           //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//
//             Container(
//               width: double.infinity,
//               child: Center(
//                 child: Image(
//                   image: AssetImage(
//                     "assets/images/notification.png",
//                   ),
//                   width: 200.w,
//                   height: 200.h,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 40.h,
//             ),
//             Text(
//               AppLocalizations.of(context)!.translate('oh_no')!,
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 24.sp,
//                   fontWeight: FontWeight.w500,
//                   height: 1.5),
//             ),
//             Text(
//               AppLocalizations.of(context)!.translate('oh_no_desc')!,
//               style: TextStyle(
//                   color: Colors.grey.shade500,
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.w500,
//                   height: 1.3),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
//           child: Column(
//             children: [
//               CustomButton(
//                 height: height * 0.07,
//                 width: double.infinity,
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 text: AppLocalizations.of(context)!.translate('back')!,
//               ),
//               SizedBox(height: 10.h),
//               Container(
//                 width: double.infinity,
//                 height: 50.h,
//                 child: ElevatedButton(
//                   onPressed: (){
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>MainDashBoard(selectedIndex: 1,)));
//                   },
//                   //     () {
//                   //   setState(() {
//                   //     _launched = _makePhoneCall('tel: 800614');
//                   //   });
//                   // },
//                   style: ElevatedButton.styleFrom(
//                     elevation: 0,
//                     textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                     shape: new RoundedRectangleBorder(
//                       borderRadius: new BorderRadius.circular(10.0),
//                     ),
//                     primary: Color(0xFFFFEBF2),
//                   ),
//                   child: new Text(
//                     AppLocalizations.of(context)!.translate('contact_support')!,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         color: Theme.of(context).primaryColor,
//                         fontSize: 15.sp,
//                         fontWeight: FontWeight.w500,
//                         letterSpacing: 1),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }