import 'package:flutter/material.dart';

import 'package:relative_scale/relative_scale.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class OrderlistWidget extends StatefulWidget {
  final data;
  ValueChanged<dynamic>? action;
  String? tag;
  final active;

  OrderlistWidget({this.action, this.data, this.tag, this.active});

  @override
  _OrderlistWidgetState createState() => _OrderlistWidgetState();
}

class _OrderlistWidgetState extends State<OrderlistWidget> {
  @override
  Widget build(BuildContext context) {
    void handletap() {}

    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return InkWell(
        onTap: () {
          widget.action!(widget.tag!);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: widget.active ? 4 : 1,
              color: widget.active ? Colors.blue : Colors.grey,
            ),
          ),
          margin:
              EdgeInsets.only(top: 10.h, bottom: 10.h, left: 5.w, right: 5.w),
          padding:
              EdgeInsets.only(top: 20.h, bottom: 20.h, left: 5.w, right: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 235, 242, 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.r),
                      ),
                    ),
                    height: 30.h,
                    width: 60.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/crown.png",
                          color: Theme.of(context).primaryColor,
                          height: 8.h,
                          scale: 8,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "Shop",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            height: 1.8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.010.h,
                  ),
                  Text(
                    widget.data['title'],
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Container(
                    width: 200.w,
                    child: Text(
                      widget.data['order'],
                      style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.data['price'],
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    widget.data['item'],
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}