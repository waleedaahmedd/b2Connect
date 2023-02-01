import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../view_model/providers/order_provider.dart';

class OrderDetailEmiBottomSheet extends StatefulWidget {
  const OrderDetailEmiBottomSheet({Key? key}) : super(key: key);

  @override
  _OrderDetailEmiBottomSheetState createState() =>
      _OrderDetailEmiBottomSheetState();
}

class _OrderDetailEmiBottomSheetState extends State<OrderDetailEmiBottomSheet> {

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, i, _) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(' EMI Details',style: TextStyle(fontSize: 15.sp,),),
            SizedBox(height: 10.h,),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                child: Container(
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: i.orderDetailModel!.installmentInfo!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  SizedBox(height: 2.h,),
                                  Container(
                                    height: 15.w,
                                    width: 15.w,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(i.orderDetailModel!.installmentInfo![index].stepNumber == 3 || i.orderDetailModel!.installmentInfo![index].stepNumber == 6?2 : 15))),
                                  ),
                                  Visibility(
                                    visible: i.orderDetailModel!.installmentInfo![index].stepNumber == 3 || i.orderDetailModel!.installmentInfo![index].stepNumber == 6? false :true,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                                      child: Center(
                                        child: Container(
                                            height: 30,
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Image.asset(
                                                    'assets/images/downArrow.png'))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10.w,),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              '${i.orderDetailModel!.installmentInfo![index]
                                                  .stepNumber == 1 ? '1st Due ' : i
                                                  .orderDetailModel!.installmentInfo![index]
                                                  .stepNumber == 2 ? '2nd Due ':
                                              i
                                                  .orderDetailModel!.installmentInfo![index]
                                                  .stepNumber == 3 ? '3rd Due ':
                                              i
                                                  .orderDetailModel!.installmentInfo![index]
                                                  .stepNumber == 4 ? '4th Due ':
                                              i
                                                  .orderDetailModel!.installmentInfo![index]
                                                  .stepNumber == 5 ? '5th Due ': '6th Due '}',style: TextStyle(fontSize: 15.sp,)),
                                          Text('| ${i.orderDetailModel!
                                              .installmentInfo![index].status}',style: TextStyle(fontSize: 15.sp,)),
                                          Spacer(),
                                          Text('${DateFormat('yMMMd').format(DateTime.fromMicrosecondsSinceEpoch(i.orderDetailModel!
                                              .installmentInfo![index].dueDate! * 1000))}',style: TextStyle(fontSize: 15.sp,color: Colors.grey)),
                                        ],
                                      ),
                                      SizedBox(height: 5.h,),
                                      Text('AED ${i.orderDetailModel!.installmentInfo![index].price}',style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                ),
                              ),

                            ],
                          ),


                        ],
                      );
                    },

                  ),
                ),
              ),)
          ],
        ),
      );
    });
  }
}
