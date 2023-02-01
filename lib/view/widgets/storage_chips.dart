import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class StorageChipsWidget extends StatefulWidget {
  final data;
  ValueChanged<dynamic>? action;
  String? tag;
  final active;
  StorageChipsWidget({this.action, this.data, this.tag, this.active});

  @override
  _StorageChipsWidgetState createState() => _StorageChipsWidgetState();
}

class _StorageChipsWidgetState extends State<StorageChipsWidget> {

  void handletap() {
    widget.action!(widget.tag!);
  }
  // void handletap() {
  //   widget.action!(widget.idAs!);
  // }

  // String tagId1 = ' ';
  //
  // void active1(val) {
  //   setState(() {
  //     tagId1 = val;
  //   });
  // }
  //int? abc;
  @override
  void initState() {
    super.initState();

    //abc=widget.idAs;
  }
  // void active3(val) {
  //   setState(() {
  //     widget.idAs = val;
  //   });
  // }

  //bool value=false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
      return GestureDetector(
        onTap: handletap,
        child: Container(
          decoration: BoxDecoration(
            color:
            widget.active ? Color.fromRGBO(255, 235, 242, 1) : Colors.white,
          ),
          height: 55.h,
          // margin: EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.all(15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.data,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: widget.active
                        ? Theme.of(context).primaryColor
                        : Color.fromRGBO(88, 102, 115, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
   // });
  }
}
