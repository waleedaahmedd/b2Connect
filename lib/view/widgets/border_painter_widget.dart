import 'package:flutter/material.dart';

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double w = size.width;
    double h = size.height;
    double r = 10; //<-- corner radius

    Paint lightWhitePaint = Paint()
      ..color = Colors.white38
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    Paint whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    RRect fullRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h),
      Radius.circular(r),
    );

    Path topRightArc = Path()
      ..moveTo(w - r, 0)
      ..arcToPoint(Offset(w, r), radius: Radius.circular(r));
    /*Path topLeftArc = Path()
      ..moveTo( r  , h )
      ..arcToPoint(Offset(w , 0 ), radius: Radius.circular(r));*/

    Path bottomLeftArc = Path()
      ..moveTo(r, h)
      ..arcToPoint(Offset(0, h - r), radius: Radius.circular(r));

    /* Path bottomRightArc = Path()
      ..moveTo(r , 0)
      ..arcToPoint(Offset(0, h - r), radius: Radius.circular(r));*/

    canvas.drawRRect(fullRect, lightWhitePaint);
    canvas.drawPath(topRightArc, whitePaint);
    //canvas.drawPath(topLeftArc, whitePaint);
    canvas.drawPath(bottomLeftArc, whitePaint);
    // canvas.drawPath(bottomRightArc, whitePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
