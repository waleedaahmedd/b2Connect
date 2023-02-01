// import 'package:b2connect_flutter/model/services/navigation_service.dart';
// import 'package:b2connect_flutter/model/utils/service_locator.dart';
// import 'package:flutter/material.dart';
// import 'package:animated_check/animated_check.dart';
//
// class SuccessWidget extends StatefulWidget {
//   @override
//   _SuccessWidgetState createState() => _SuccessWidgetState();
// }
//
// class _SuccessWidgetState extends State<SuccessWidget>
//     with SingleTickerProviderStateMixin {
//   var navigationService = locator<NavigationService>();
//   AnimationController? _animationController;
//   Animation<double>? _animation;
//   @override
//   void initState() {
//     super.initState();
//     _animationController =
//         AnimationController(vsync: this, duration: Duration(seconds: 1));
//
//     _animation = new Tween<double>(begin: 0, end: 1).animate(
//         new CurvedAnimation(
//             parent: _animationController!, curve: Curves.easeInOutCirc));
//     setState(() {
//       _animationController!.forward();
//     });
//   }
//
//   var height;
//   @override
//   Widget build(BuildContext context) {
//     height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: Container(
//         height: height * 0.5,
//         width: MediaQuery.of(context).size.height * 0.5,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               children: [
//                 // SizedBox(height: height * 0.09),
//                 Container(
//                   margin: EdgeInsets.only(top: 30),
//                   decoration: BoxDecoration(
//                       border: Border.all(
//                         width: 3,
//                         color: Theme.of(context).backgroundColor,
//                         style: BorderStyle.solid,
//                       ),
//                       shape: BoxShape.circle),
//                   child: Center(
//                     child: AnimatedCheck(
//                       progress: _animation!,
//                       size: 150,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: height * 0.05),
//                 Text(
//                   "Success",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.black,
//                   ),
//                 ),
//                 Text(
//                   "thankyou for shopping using B2App",
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.grey,
//                       height: 1.6),
//                 ),
//               ],
//             ),
//             Container(
//               child: ElevatedButton(
//                 onPressed: () {
//                   setState(() {});
//                 },
//                 style: ElevatedButton.styleFrom(
//                   elevation: 0,
//                   textStyle: TextStyle(
//                       fontSize: MediaQuery.of(context).size.height * 0.03,
//                       fontWeight: FontWeight.w500),
//                   fixedSize: Size(MediaQuery.of(context).size.width * 0.55,
//                       MediaQuery.of(context).size.height * 0.060),
//                   primary: Theme.of(context).primaryColor,
//                   shape: new RoundedRectangleBorder(
//                     borderRadius: new BorderRadius.circular(50.0),
//                   ),
//                 ),
//                 child: Container(
//                     padding: EdgeInsets.only(left: 5, right: 10),
//                     child: new Text(
//                       "Back to Orders",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     )),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
