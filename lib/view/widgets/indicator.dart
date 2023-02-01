import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndicatorWidget extends StatefulWidget {
  String colorIndicator;

  IndicatorWidget(this.colorIndicator, {Key? key}) : super(key: key);

  @override
  _IndicatorWidgetState createState() => _IndicatorWidgetState();
}

class _IndicatorWidgetState extends State<IndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.colorIndicator == '1') {
      return Container(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 100.w,
                height: 3.h,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 10.w),
              Container(width: 100.w, height: 3.h, color: Colors.grey.shade300),
              SizedBox(width: 10.w),
              Container(width: 100.w, height: 3.h, color: Colors.grey.shade300),
            ]),
          ],
        ),
      );
    } else if (widget.colorIndicator == '2') {
      return Container(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 100.w,
                height: 3.h,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 10.w),
              Container(
                width: 100.w,
                height: 3.h,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 10.w),
              Container(width: 100.w, height: 3.h, color: Colors.grey.shade300),
            ]),
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: 100.w,
                height: 3.h,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(width: 10.w),
              Container(
                  width: 100.w,
                  height: 3.h,
                  color: Theme.of(context).primaryColor),
              SizedBox(width: 10.w),
              Container(
                  width: 100.w,
                  height: 3.h,
                  color: Theme.of(context).primaryColor),
            ]),
          ],
        ),
      );
    }
  }
}
