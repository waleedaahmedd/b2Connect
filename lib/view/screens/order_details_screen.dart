import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view_model/providers/order_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:dotted_border/dotted_border.dart';

import '../widgets/change_language_bottom_sheet.dart';
import '../widgets/order_detail_emi_bottom_sheet.dart';

const kTileHeight = 50.0;
const completeColor = Color(0xff5e0457b);
const inProgressColor = Color(0xff5e0457b);
const todoColor = Color(0xffe0457b);

class OrderDetailScreen extends StatefulWidget {
  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
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
  void initState() {
    setState(() {
      _processIndex = (_processIndex + 1) % _processes.length;
    });
    super.initState();
  }

  bool favorite = false;
  bool like = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

    return Consumer<OrderProvider>(builder: (context, i, _) {
      return Scaffold(
        appBar: AppBarWithBackIconAndLanguage(
          onTapIcon: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // "Order Detail",
                            AppLocalizations.of(context)!
                                .translate("orderdetails_orderDetail")!,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            AppLocalizations.of(context)!
                                .translate("order_id")! +
                                " ${i.orderDetailModel!.salesOrderNo}",
                            style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppLocalizations.of(context)!.translate("status")! +
                                " ${i.orderDetailModel!.status!.toUpperCase()}",
                            style: TextStyle(
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          /*  Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  timLine(context),
                                  */ /* timLine(context),*/ /*
                                  */ /* timLine(context),
                                  timLine(context),
                                  timLine(context),*/ /*
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Ordered',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 75,
                                  ),
                                  Text('${i.orderDetailModel!.status!}',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.020.h,
                          ),*/
                          Text(
                            // "Product",
                            AppLocalizations.of(context)!
                                .translate("orderdetails_Product")!,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: height * 0.020.h,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: i.orderDetailModel!.items!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    //todo: on tap function
                                  },
                                  child: Container(
                                    //height: height * 0.13,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey[200]!),
                                          borderRadius:
                                          BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: width * 0.2,
                                              // color: Colors.red,
                                              child: i
                                                  .orderDetailModel!
                                                  .items![index]
                                                  .images!
                                                  .isNotEmpty
                                                  ? CachedNetworkImage(
                                                imageUrl: i
                                                    .orderDetailModel!
                                                    .items![index]
                                                    .images![0],
                                                fit: BoxFit.cover,
                                                placeholder:
                                                    (context, url) =>
                                                    Image.asset(
                                                      'assets/images/placeholder1.png',
                                                    ),
                                                errorWidget: (context,
                                                    url, error) =>
                                                    Center(
                                                      child: Image.asset(
                                                        'assets/images/not_found1.png',
                                                        // height: 50,
                                                      ),
                                                    ),
                                              )
                                                  : Image.asset(
                                                'assets/images/not_found1.png',
                                                //height: 50,
                                              ),
                                            ),
                                            Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${i.orderDetailModel!
                                                          .items![index].name}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'SKU: ${i
                                                          .orderDetailModel!
                                                          .items![index].sku}',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      '${i.orderDetailModel!
                                                          .items![index]
                                                          .currency} ${i
                                                          .orderDetailModel!
                                                          .items![index].price!
                                                          .toStringAsFixed(2)}',
                                                      style: TextStyle(
                                                          color: Theme
                                                              .of(context)
                                                              .primaryColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                          FontWeight.w400),
                                                    ),
                                                  ],
                                                )),
                                            /*  Container(
                                              color: Colors.yellow,
                                              child: Text('sddwdwdwdw'),
                                            )*/
                                          ],
                                        ),
                                      )),
                                );
                              }),
                          SizedBox(
                            height: height * 0.020.h,
                          ),
                          Text(
                            // "Billing Address",
                            AppLocalizations.of(context)!
                                .translate("orderdetails_BillingAddress")!,
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
                                    /* Text(
                                      // "EMI Dates",
                                      AppLocalizations.of(context)!
                                          .translate("orderdetails_EMIDates")!,
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: height * 0.010.h,
                                    ),*/
                                    /*  Text(
                                      // "Delivery Date",
                                      AppLocalizations.of(context)!.translate(
                                          "orderdetails_DeliveryDate")!,
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: height * 0.010.h,
                                    ),
                                    Text(
                                      // "Date Shipping",
                                      AppLocalizations.of(context)!.translate(
                                          "orderdetails_DateShipping")!,
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
                                      AppLocalizations.of(context)!
                                          .translate("orderdetails_Shipping")!,
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: height * 0.010.h,
                                    ),
                                    Text(
                                      // "No. Resi",
                                      AppLocalizations.of(context)!
                                          .translate("orderdetails_NOofResi")!,
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: height * 0.010.h,
                                    ),*/
                                    Text(
                                      // "Address",
                                      AppLocalizations.of(context)!
                                          .translate("orderdetails_Address")!,
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          //fontSize: 12.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    /*  Text(
                                      "N/A",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: height * 0.010.h,
                                    ),*/
                                    /* Text(
                                      "N/A",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: height * 0.010.h,
                                    ),
                                    Text(
                                      "N/A",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: height * 0.010.h,
                                    ),
                                    Text(
                                      "N/A",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: height * 0.010.h,
                                    ),
                                    Text(
                                      "N/A",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: height * 0.010.h,
                                    ),*/
                                    Text(
                                      '${i.orderDetailModel!.userAddress}'
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          //fontSize: 12.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '${i.orderDetailModel!.userZone} , ${i
                                          .orderDetailModel!.userZoneState}'
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          //fontSize: 10.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: i.orderDetailModel!.cardNumber == "" &&
                                i.orderDetailModel!.cardPin == ""
                                ? false
                                : true,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * 0.020.h,
                                ),
                                Text(
                                  // "Payment Details",
                                  AppLocalizations.of(context)!
                                      .translate("orderdetails_order_detail")!,
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
                                    border:
                                    Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Column(
                                    children: [
                                      Visibility(
                                        visible:
                                        i.orderDetailModel!.cardNumber == ""
                                            ? false
                                            : true,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  // "Item (2)",
                                                  AppLocalizations.of(context)!
                                                      .translate(
                                                      "card_number")!,
                                                  style: TextStyle(
                                                      color:
                                                      Colors.grey.shade400,
                                                      //fontSize: 10.sp,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                                Text(
                                                  '${i.orderDetailModel!
                                                      .cardNumber == null
                                                      ? 'null'
                                                      : i.orderDetailModel!
                                                      .cardNumber}',
                                                  style: TextStyle(
                                                      color:
                                                      Colors.grey.shade700,
                                                      //fontSize: 10.sp,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: height * 0.010.h,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Visibility(
                                        visible:
                                        i.orderDetailModel!.cardPin == ""
                                            ? false
                                            : true,
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  // "Item (2)",
                                                  AppLocalizations.of(context)!
                                                      .translate("card_pin")!,
                                                  style: TextStyle(
                                                      color:
                                                      Colors.grey.shade400,
                                                      //fontSize: 10.sp,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                                Text(
                                                  '${i.orderDetailModel!
                                                      .cardPin == null
                                                      ? 'null'
                                                      : i.orderDetailModel!
                                                      .cardPin}',
                                                  style: TextStyle(
                                                      color:
                                                      Colors.grey.shade700,
                                                      //fontSize: 10.sp,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.020.h,
                          ),
                          Text(
                            // "Payment Details",
                            AppLocalizations.of(context)!
                                .translate("orderdetails_PaymentDetails")!,
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
                                DottedBorder(
                                  borderType: BorderType.Rect,
                                  radius: Radius.circular(10.r),
                                  padding: EdgeInsets.all(10.h),
                                  color: Theme
                                      .of(context)
                                      .primaryColor,
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
                                            "orderdetails_Totalprice")!,
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                           // fontSize: 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "AED ${i.orderDetailModel!.total!
                                            .toStringAsFixed(2)}",
                                        style: TextStyle(
                                            color:
                                            Theme
                                                .of(context)
                                                .primaryColor,
                                            //fontSize: 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.010.h,
                                ),
                                Visibility(
                                  visible: i.orderDetailModel!.tenure == 0 ||
                                      i.orderDetailModel!.tenure == null
                                      ? false
                                      : true,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Payment Plan',
                                            style: TextStyle(
                                                color: Colors.grey.shade400,
                                                //fontSize: 10.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _emiDetailBottomSheet(context);
                                            },
                                            child: RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                    //fontSize: 10.sp,
                                                    fontWeight: FontWeight.w500
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'B2 Pay Later ',
                                                      style: TextStyle(
                                                        color: Theme
                                                            .of(context)
                                                            .primaryColor,
                                                      )),
                                                  TextSpan(
                                                      text: '( ${i
                                                          .orderDetailModel!
                                                          .tenure} Months)',
                                                      style: TextStyle(
                                                        color: Colors.grey
                                                            .shade700,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),

                                          /* Text(
                                            "${i.orderDetailModel!.tenure}",
                                            style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w600),
                                          ),*/
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.010.h,
                                      ),
                                    ],
                                  ),
                                ),

                                /* Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Paid',
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "${i.orderDetailModel!.paymentMethod!.replaceAll("_", " ")}",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.010.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Balance',
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "${i.orderDetailModel!.paymentMethod!.replaceAll("_", " ")}",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.010.h,
                                ),*/
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      // "Paid Using",
                                      AppLocalizations.of(context)!
                                          .translate("orderdetails_Paidusing")!,
                                      style: TextStyle(
                                          color: Colors.grey.shade400,
                                          //fontSize: 10.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${i.orderDetailModel!.paymentMethod!
                                          .replaceAll("_", " ")}",
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          //fontSize: 10.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(15.0.h),
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  width: double.infinity,
                  height: 50.h,
                  text: (AppLocalizations.of(context)!
                      .translate("orderdetails_BackToOrders")!),
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(FontAwesomeIcons.chevronRight,size: 16.h,color: Colors.white,),
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

void _emiDetailBottomSheet(context) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          topLeft: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return Wrap(children: [
          OrderDetailEmiBottomSheet()
        ]);
      });
}


// class _BezierPainter extends CustomPainter {
//   const _BezierPainter({
//     required this.color,
//     this.drawStart = true,
//     this.drawEnd = true,
//   });
//
//   final Color color;
//   final bool drawStart;
//   final bool drawEnd;
//
//   Offset _offset(double radius, double angle) {
//     return Offset(
//       radius * cos(angle) + radius,
//       radius * sin(angle) + radius,
//     );
//   }
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..style = PaintingStyle.fill
//       ..color = color;
//
//     final radius = size.width / 2;
//
//     var angle;
//     var offset1;
//     var offset2;
//
//     var path;
//
//     if (drawStart) {
//       angle = 3 * pi / 4;
//       offset1 = _offset(radius, angle);
//       offset2 = _offset(radius, -angle);
//       path = Path()
//         ..moveTo(offset1.dx, offset1.dy)
//         ..quadraticBezierTo(0.0, size.height / 2, -radius,
//             radius)
//         ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
//         ..close();
//
//       canvas.drawPath(path, paint);
//     }
//     if (drawEnd) {
//       angle = -pi / 4;
//       offset1 = _offset(radius, angle);
//       offset2 = _offset(radius, -angle);
//
//       path = Path()
//         ..moveTo(offset1.dx, offset1.dy)
//         ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
//             radius)
//         ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
//         ..close();
//
//       canvas.drawPath(path, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(_BezierPainter oldDelegate) {
//     return oldDelegate.color != color ||
//         oldDelegate.drawStart != drawStart ||
//         oldDelegate.drawEnd != drawEnd;
//   }
// }

Widget timLine(context) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Theme
                .of(context)
                .primaryColor, shape: BoxShape.circle),
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 15.0,
        ),
      ),
      Container(
        height: 2,
        width: 100,
        color: Theme
            .of(context)
            .primaryColor,
      )
    ],
  );
}

final _processes = [
  'Packing',
  'Shipping',
  'Arriving',
  'Stop 4',
  'Stop 5',
  'Success',
];
