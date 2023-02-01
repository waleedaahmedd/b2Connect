import 'package:flutter/material.dart';

import 'package:relative_scale/relative_scale.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class SelectColorWidget extends StatefulWidget {
  final data;
  ValueChanged<dynamic>? action;
  String? tag;
  final active;

  SelectColorWidget({this.action, this.data, this.tag, this.active});

  @override
  _SelectColorWidgetState createState() => _SelectColorWidgetState();
}

class _SelectColorWidgetState extends State<SelectColorWidget> {
  void handletap() {
    widget.action!(widget.tag!);
  }

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return GestureDetector(
        onTap: handletap,
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              decoration:
                  BoxDecoration(shape: BoxShape.circle,
                      color:
                      // Colors.red
                      widget.data["Color"]

                      ),
            ),
          ],
        ),
      );
    });
  }
}
