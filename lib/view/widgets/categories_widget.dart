import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CategoriesWidget extends StatefulWidget {
  final String? img;
  final String? name;


  CategoriesWidget({this.img, this.name});

  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0.r),
        ),
        elevation: 2,
        child: Container(
          padding: EdgeInsets.all(6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                        width: 70.w,
                        height: 70.h,
                      child: Image.network(
                        widget.img!,
                      ),
                    )
                    // Image(
                    //   image: AssetImage(
                    //     widget.img!,
                    //   ),
                    //   width: 70.w,
                    //   height: 70.h,
                    // ),
                  ]
              ),
              Text(
                widget.name!,
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Theme
                        .of(context)
                        .primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.chevron_right_outlined,
                color: Theme
                    .of(context)
                    .primaryColor,
                size: 26.h,
              ),
            ],
          ),
        ),
      );

  }
}
