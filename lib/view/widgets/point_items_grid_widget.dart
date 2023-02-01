import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/utils/routes.dart';

class PointItemsGridWidget extends StatelessWidget {
  const PointItemsGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        navigationService.navigateTo(
            RewardsPaymentMethodScreenRoute);
      },
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Xiaomi Mi 2 Wireless Earphones',style: TextStyle(fontSize: 12.sp)),
              Image.asset(
                'assets/images/sample_product.png',
                scale: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('2500 Points',style: TextStyle(fontSize: 10.sp,color: Colors.grey,decoration: TextDecoration.lineThrough,),),

                  Text('1200 Points',style: TextStyle(fontSize: 12.sp,color: Theme.of(context).primaryColor)),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}
