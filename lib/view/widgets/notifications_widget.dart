import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/notification_detail_screen.dart';

// ignore: must_be_immutable
class NotificationsWidget extends StatefulWidget {
  final data;
  final dateTime;
  final description;
  // ValueChanged<dynamic>? action;
  // String? tag;
  // final active;
  NotificationsWidget({
    this.data,
    this.dateTime,
    this.description,
    // this.data,
    // this.tag,
    // this.active,
  });
  @override
  _NotificationsWidgetState createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  // void handletap() {
  //   widget.action!(widget.tag!);
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // return RelativeBuilder(builder: (context, height, width, sy, sx) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8,bottom: 15,),
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationDetailScreen(
                      dateTime: widget.dateTime,
                      description: widget.description,
                      title: widget.data,
                    )));
            //navigationService.navigateTo(NotificationScreenRoute);
          },
          child: Container(
            // height: height*0.12,
            width: width,
            //color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0,),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.045,
                    width: height * 0.045,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFEBF2),
                    ),
                    child: Icon(
                      Icons.email,
                      color: Color.fromRGBO(197, 109, 222, 1),
                      size: 11,
                    ),
                  ),
                  SizedBox(
                    width: 15.h,
                  ),
                  Column(
                    children: [
                      Container(
                          width: width * 0.65,
                          child: Text(
                            "${widget.data!}",
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15),
                          )),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                          width: width * 0.65,
                          child: Text(
                            widget.dateTime!,
                            textAlign: TextAlign.left,
                            style:
                            TextStyle(fontSize: 11, color: Colors.grey),
                          )),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
