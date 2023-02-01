import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class RamChipsWidget extends StatefulWidget {
  final data;
   ValueChanged<dynamic>? action;
   String? tag;
  bool? active;
  RamChipsWidget({this.data, this.active});

  @override
  _RamChipsWidgetState createState() => _RamChipsWidgetState();
}

class _RamChipsWidgetState extends State<RamChipsWidget> {
  void handletap() {
    setState(() {
      widget.active=!(widget.active!);
    });

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

      return GestureDetector(
        onTap: handletap,
        child: Container(
          height: 25.h,
          width: 35.w,
          decoration: BoxDecoration(
            color: widget.active! ? Color.fromRGBO(255, 235, 242, 1) : Colors.white,
            border: Border.all(
              width: height * 0.001,
              color: widget.active! ? Colors.transparent : Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(5.r),
          ),
          margin: EdgeInsets.only(bottom: height * 0.010, top: height * 0.010),
          child: Chip(
            backgroundColor: widget.active! ? Color.fromRGBO(255, 235, 242, 1) : Colors.white,
            label: Text(
              widget.data.toString(),
              style: TextStyle(
                fontSize: height * 0.017,
                fontWeight: FontWeight.bold,
                color: widget.active!
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade400,
              ),
            ),
          ),
        ),
      );

  }
}
