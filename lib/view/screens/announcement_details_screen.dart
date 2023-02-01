import 'package:b2connect_flutter/model/announcement_model.dart';
import 'package:b2connect_flutter/view/widgets/appBar_with_cart_notification_widget.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AnnouncementDetailsScreen extends StatelessWidget {
  final Announcement? announcementDetails;
  final String? screenName;

  const AnnouncementDetailsScreen(
      {Key? key, this.announcementDetails, this.screenName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? dateString;

    var date = new DateTime.fromMillisecondsSinceEpoch(
        announcementDetails!.created!.toInt()*1000);
    var format = new DateFormat.yMMMMd('en_US').add_jm();
    dateString = format.format(date);

    return Scaffold(
      appBar: AppBarWithCartNotificationWidget(
        title: screenName!,
        onTapIcon: () {
          navigationService.closeScreen();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Row(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        //  margin: const EdgeInsets.all(15.0),
                        // padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Theme.of(context).primaryColor)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Text(
                            announcementDetails!.category!,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Text(
                            dateString,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey,
                              /*fontWeight: FontWeight.w500*/),
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    announcementDetails!.title!,
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor),
                  )),
              SizedBox(height: 20.h),
              Card(
                elevation: 5,
                child: CachedNetworkImage(
                  height: 200.h,
                  imageUrl: announcementDetails!.image!.isNotEmpty
                      ? announcementDetails!.image!
                      : 'assets/images/not_found1.png',
                  placeholder: (context, url) =>
                      Image.asset('assets/images/placeholder1.png'),
                  errorWidget: (context, url, error) => Center(
                    child: Image.asset(
                      'assets/images/not_found1.png',
                      height: 100,
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 20.h),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Description',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                  )),
              SizedBox(height: 20.h),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(announcementDetails!.description!)),
            ],
          ),
        ),
      ),
    );
  }
}
