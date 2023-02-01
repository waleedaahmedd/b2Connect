import 'dart:math';

import 'package:b2connect_flutter/model/models/points_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PointItemsVerticalWidgets extends StatelessWidget {
  const PointItemsVerticalWidgets(
      {Key? key, required this.rewardsList, required this.index})
      : super(key: key);

  final List<Transactions> rewardsList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              '${rewardsList[index].transactionImage}',
              width: 50.w,
            ),
            SizedBox(
              width: 20.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rewardsList[index].created!,
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w200,
                        color: Colors.grey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '${rewardsList[index].transactionInfo}',
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Image.network(
                        '${rewardsList[index].transactionImage}',
                        width: 30.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    '${rewardsList[index].pointsInCurrency} AED',
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade500),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${rewardsList[index].type == 'CREDIT' ? '+' : '-'}${rewardsList[index].points}K B2 Points',
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: rewardsList[index].type == 'CREDIT'
                              ? Colors.lightGreenAccent
                              : Colors.orange),
                    ),
                  ),
                  /* if (rewardsList[index].partner != null)
                  Text('${rewardsList[index].partner}', style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w200,
                      color: Colors.grey.shade800),)*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
