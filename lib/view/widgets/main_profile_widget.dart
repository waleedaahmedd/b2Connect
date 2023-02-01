import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/services/storage_service.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class MainProfileWidget extends StatefulWidget {
  final Widget? icon;
  final String? title;
  final VoidCallback? onTap;

  MainProfileWidget({this.icon, this.title,this.onTap});

  @override
  _MainProfileWidgetState createState() => _MainProfileWidgetState();
}

class _MainProfileWidgetState extends State<MainProfileWidget> {
  var navigationService = locator<NavigationService>();

  var storageService = locator<StorageService>();


    @override
    Widget build(BuildContext context) {
        return Container(
          //color: Colors.red,
          padding: EdgeInsets.only(
            left: 10.w,
            right: 10.w,
           // top: 5.h,
           // bottom: 10.h,
          ),
          child: Column(
            children: [
              TextButton(
                onPressed: widget.onTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.icon!,
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        widget.title!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(55, 60, 65, 1),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey.shade400,
                        size: 20.0,
                      ),
                    ],
                  ),
              ),
              Divider(
                color: Colors.grey.shade400,
                // height: 6,
              ),
            ],
          ),
        );

    }
  }



