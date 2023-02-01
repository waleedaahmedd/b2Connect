import 'dart:math';
import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timelines/timelines.dart';
import 'package:dotted_border/dotted_border.dart';

const kTileHeight = 50.0;
const completeColor = Color(0xff5e0457b);
const inProgressColor = Color(0xff5e0457b);
const todoColor = Color(0xffe0457b);

class TransactionDetailsScreen extends StatefulWidget {
  @override
  _TransactionDetailsScreenState createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  int _processIndex = 2;

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    //bool _favourite = false;
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    return Consumer<AuthProvider>(builder: (context, i, _) {
      return Scaffold(
        appBar: AppBarWithBackIconAndLanguage(
          onTapIcon: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.h),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // "Transcation Details",
                            AppLocalizations.of(context)!.translate(
                                "transactiondetails_transactionDetails")!,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Order Id ${i.packageDetails!.packageId}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          Container(
                            height: 70.h,
                            child: Timeline.tileBuilder(
                              physics: NeverScrollableScrollPhysics(),
                              theme: TimelineThemeData(
                                direction: Axis.horizontal,
                                connectorTheme: ConnectorThemeData(
                                  space: 10.0,
                                  thickness: 2.0,
                                ),
                              ),
                              builder: TimelineTileBuilder.connected(
                                connectionDirection: ConnectionDirection.before,
                                itemExtentBuilder: (_, __) =>
                                    MediaQuery.of(context).size.width /
                                    _processes.length,
                                contentsBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      _processes[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: getColor(index),
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  );
                                },
                                indicatorBuilder: (_, index) {
                                  var color;
                                  var child;
                                  if (index == _processIndex) {
                                    color = inProgressColor;
                                    child = Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3.0,
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white),
                                      ),
                                    );
                                  } else if (index < _processIndex) {
                                    color = completeColor;
                                    child = Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 15.0,
                                    );
                                  } else {
                                    color = todoColor;
                                  }

                                  if (index <= _processIndex) {
                                    return Stack(
                                      children: [
                                        // CustomPaint(
                                        //   size: Size(30.0, 30.0),
                                        //   painter: _BezierPainter(
                                        //     color: color,
                                        //     drawStart: index > 0,
                                        //     drawEnd: index < _processIndex,
                                        //   ),
                                        // ),
                                        DotIndicator(
                                          size: 26.0,
                                          color: color,
                                          child: child,
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Stack(
                                      children: [
                                        CustomPaint(
                                          size: Size(15.0, 15.0),
                                          painter: _BezierPainter(
                                            color: color,
                                            drawEnd:
                                                index < _processes.length - 1,
                                          ),
                                        ),
                                        OutlinedDotIndicator(
                                          borderWidth: 4.0,
                                          color: color,
                                        ),
                                      ],
                                    );
                                  }
                                },
                                connectorBuilder: (_, index, type) {
                                  if (index > 0) {
                                    if (index == _processIndex) {
                                      final prevColor = getColor(index - 1);
                                      final color = getColor(index);
                                      List<Color> gradientColors;
                                      if (type == ConnectorType.start) {
                                        gradientColors = [
                                          Color.lerp(prevColor, color, 0.5)!,
                                          color
                                        ];
                                      } else {
                                        gradientColors = [
                                          prevColor,
                                          Color.lerp(prevColor, color, 0.5)!
                                        ];
                                      }
                                      return DecoratedLineConnector(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: gradientColors,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SolidLineConnector(
                                        color: getColor(index),
                                      );
                                    }
                                  } else {
                                    return null;
                                  }
                                },
                                itemCount: _processes.length,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.020.h,
                          ),
                          Text(
                            // "Wifi Package",
                            AppLocalizations.of(context)!
                                .translate("transactiondetails_WifiPackage")!,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: height * 0.020.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                  mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        "assets/images/crown.png",
                                        color: Theme.of(context).primaryColor,
                                        height: 12.h,
                                       // scale: 5,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        '${i.packageDetails!.packageName?.replaceAll("_", " ")}',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp,
                                          height: 1.8,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  /*Container(
                                    width: 350.w,
                                    child: Text(
                                      "Short description of the  WIFI Plan second description line",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),*/
                                  Text(
                                    '${i.packageDetails!.currency} ${i.packageDetails!.total!.toStringAsFixed(2)}',
                                    style: TextStyle(
                                        color: Color.fromRGBO(254, 126, 118, 1),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Divider(
                                    color: Colors.grey.shade800,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!.translate(
                                                "transactiondetails_Validity")!,
                                            // "Validity",

                                            style: TextStyle(
                                                color: Colors.grey.shade400,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          /* SizedBox(
                                            height: height * 0.010.h,
                                          ),
                                          Text(
                                            "# of devices",
                                            style: TextStyle(
                                                color: Colors.grey.shade400,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: height * 0.010.h,
                                          ),
                                          Text(
                                            // "Speed upto",
                                            AppLocalizations.of(context)!.translate(
                                                "transactiondetails_Speedupto")!,
                                            style: TextStyle(
                                                color: Colors.grey.shade400,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600),
                                          ),*/
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '${(i.packageDetails!.packageValidSeconds! / 86400).toStringAsFixed(0)} Days',
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          /* SizedBox(
                                            height: height * 0.010.h,
                                          ),
                                          Text(
                                            "2 devices",
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: height * 0.010.h,
                                          ),
                                          Text(
                                            "100 Mbas",
                                            style: TextStyle(
                                                color: Colors.blueGrey,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600),
                                          ),*/
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.020.h,
                          ),
                          /*Text(
                            // "Billing Address",
                            AppLocalizations.of(context)!
                                .translate("transactiondetails_BillingAddress")!,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: height * 0.020.h,
                          ),
                          Container(
                            padding: EdgeInsets.all(15.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // "EMI Dates",
                                      AppLocalizations.of(context)!.translate(
                                          "transactiondetails_EMIDates")!,
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: height * 0.010.h,
                                    ),
                                    Text(
                                      // "Delivery Date",
                                      AppLocalizations.of(context)!.translate(
                                          "transactiondetails_DeliveryDate")!,
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: height * 0.010.h,
                                    ),
                                    */ /*  Text(
                                    // "Date Shipping",
                                    AppLocalizations.of(context)!.translate(
                                        "transactiondetails_DateShipping")!,
                                    style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: height * 0.010.h,
                                  ),*/ /*
                                    Text(
                                      AppLocalizations.of(context)!.translate(
                                          "transactiondetails_Shipping")!,
                                      // "Shipping",
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: height * 0.010.h,
                                    ),
                                    */ /*   Text(
                                    // "No. Resi",
                                    AppLocalizations.of(context)!.translate(
                                        "transactiondetails_NOofResi")!,
                                    style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: height * 0.010.h,
                                  ),*/ /*
                                    Text(
                                      // "Address",
                                      AppLocalizations.of(context)!.translate(
                                          "transactiondetails_Address")!,
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "3 months (Jan 16, Mar 16,Nov 16 2022",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: height * 0.010.h,
                                    ),
                                    Text(
                                      "January 29, 2022",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: height * 0.010.h,
                                    ),
                                    */ /*   Text(
                                    "January 29, 2022",
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: height * 0.010.h,
                                  ),*/ /*
                                    Text(
                                      "In-hand delivery",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: height * 0.010.h,
                                    ),
                                    */ /* Text(
                                    "Camp C101",
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: height * 0.010.h,
                                  ),*/ /*
                                    Text(
                                      "C101, Al Dhabi Building,Al Dhabi",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.020.h,
                          ),*/
                          Text(
                            // "Payment Details",
                            AppLocalizations.of(context)!.translate(
                                "transactiondetails_PaymentDetails")!,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: height * 0.020.h,
                          ),
                          Container(
                            padding: EdgeInsets.all(15.h),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Column(
                              children: [
                                /* Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          // "Item (2)",
                                          AppLocalizations.of(context)!.translate(
                                              "transactiondetails_Item")!,
                                          style: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: height * 0.010.h,
                                        ),
                                        Text(
                                          // "Taxes",
                                          AppLocalizations.of(context)!.translate(
                                              "transactiondetails_Taxes")!,

                                          style: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: height * 0.010.h,
                                        ),
                                        Text(
                                          // "Shipping",
                                          AppLocalizations.of(context)!.translate(
                                              "transactiondetails_Shipping")!,
                                          style: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "AED 2224",
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: height * 0.010.h,
                                        ),
                                        Text(
                                          "AED 10",
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: height * 0.010.h,
                                        ),
                                        Text(
                                          "AED 10",
                                          style: TextStyle(
                                              color: Colors.blueGrey,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.010.h,
                                ),*/
                                DottedBorder(
                                  borderType: BorderType.Rect,
                                  radius: Radius.circular(10.r),
                                  padding: EdgeInsets.all(10.h),
                                  color: Theme.of(context).primaryColor,
                                  strokeWidth: 1,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // "Total Price",
                                        AppLocalizations.of(context)!.translate(
                                            "transactiondetails_TotalPrice")!,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${i.packageDetails!.currency} ${i.packageDetails!.total!.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                /*  SizedBox(
                                  height: height * 0.020.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      // "Paid Using",
                                      AppLocalizations.of(context)!.translate(
                                          "transactiondetails_Paidusing")!,
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "Payby",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )*/
                              ],
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0.h),
              child: CustomButton(
                width: double.infinity,
                height: 50.h,
                text: (
                    // 'Back to Transactions'
                    AppLocalizations.of(context)!
                        .translate("transactiondetails_backtotransactions")!),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(
        //     FontAwesomeIcons.chevronRight,
        //     size: 16.h,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     setState(() {
        //       _processIndex = (_processIndex + 1) % _processes.length;
        //     });
        //   },
        //   backgroundColor: Theme.of(context).primaryColor,
        // ),
      );
    });
  }
}

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius, radius)
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(
            size.width, size.height / 2, size.width + radius, radius)
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}

final _processes = [
  'Activated',
  'Connected',
];
