import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../../model/services/navigation_service.dart';
import '../../model/utils/service_locator.dart';

class NotificationDetailScreen extends StatefulWidget {
  final String? title;
  final String? description;
  final String? dateTime;
  const NotificationDetailScreen(
      {Key? key, this.title, this.description, this.dateTime})
      : super(key: key);

  @override
  _NotificationDetailScreenState createState() => _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  var _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15.h),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    _navigationService.closeScreen();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 20.h,
                  ),

                ),
                SizedBox(width: 10.w,),
                Text('Notifications',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),)
              ],
            ),
            SizedBox(
              height: 40.h,
            ),

            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title!,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      widget.dateTime!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "${widget.description!}",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
