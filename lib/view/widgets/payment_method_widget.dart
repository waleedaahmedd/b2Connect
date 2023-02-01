import 'package:flutter/material.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class PaymentMethodWidget extends StatefulWidget {
  final data;
  ValueChanged<dynamic>? action;
  String? tag;
  final active;
  PaymentMethodWidget({this.action, this.data, this.tag, this.active});

  @override
  _PaymentMethodWidgetState createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  void handletap() {
    widget.action!(widget.tag!);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return GestureDetector(
        onTap: handletap,
        child: Container(
          decoration: BoxDecoration(
            color:
            widget.active ? Color.fromRGBO(255, 235, 242, 1) : Colors.white,
            border: Border.all(
              width: width * 0.001,
              color: widget.active ? Colors.transparent : Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(5.r),
          ),
          margin: EdgeInsets.only(bottom: height * 0.010, top: height * 0.010),
          child: Chip(
            backgroundColor:
            widget.active ? Color.fromRGBO(255, 235, 242, 1) : Colors.white,
            label: Text(
              widget.data['title'],
              style: TextStyle(
                fontSize: height * 0.017,
                fontWeight: FontWeight.bold,
                color: widget.active
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade400,
              ),
            ),
          ),
        ),
      );
    });
  }
}
