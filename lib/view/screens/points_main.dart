import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../model/utils/constant.dart';
import '../../model/utils/routes.dart';
import '../../view_model/providers/auth_provider.dart';
import '../../view_model/providers/points_provider.dart';
import '../widgets/point_items_grid_widget.dart';
import '../widgets/showOnWillPop.dart';

class PointsMain extends StatefulWidget {
  const PointsMain({Key? key}) : super(key: key);

  @override
  _PointsMainState createState() => _PointsMainState();
}

class _PointsMainState extends State<PointsMain> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PointsProvider>(builder: (context, _pointsProvider, _) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: gradientColor,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${Provider.of<AuthProvider>(context, listen: false).userInfoData!.firstName} ${Provider.of<AuthProvider>(context, listen: false).userInfoData!.lastName}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.sp),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.accessibility,
                                  color: Colors.white,
                                  size: 15.h,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  '${Provider.of<AuthProvider>(context, listen: false).userInfoData!.uid}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14.sp),
                                )
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'B2 Points',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 12.sp),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              _pointsProvider.getPointsModel.balance.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25.sp),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Worth',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 12.sp),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text(
                              'AED ${_pointsProvider.getPointsModel.balanceInAED}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 18.sp),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Text(
                              'Next goal',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.w200,
                                  fontSize: 12.sp),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LinearPercentIndicator(
                              animationDuration: 2000,
                              animation: true,
                              width: 200.w,
                              lineHeight: 5.0,
                              percent: 0.2,
                              backgroundColor: Colors.white,
                              progressColor: Colors.grey,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                '2100/2500 Points',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 12.sp),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 70.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.w, color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Browse All \nRewards',
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          Image.asset(
                            'assets/images/award.png',
                            width: 50.w,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Container(
                    height: 70.h,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.w, color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('How to earn \nB2 points?',
                              style: TextStyle(fontSize: 12.sp)),
                          Image.asset(
                            'assets/images/coin_icon.png',
                            width: 50.w,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Rewards',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500),
                ),
                GestureDetector(
                  onTap: (){
                    navigationService.navigateTo(
                        RewardsScreenRoute);
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            AnimationLimiter(
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                addRepaintBoundaries: false,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10.0.h,
                  crossAxisSpacing: 10.0.w,
                  childAspectRatio: 0.8.w,
                  //ScreenSize.productCardWidth / ScreenSize.productCardHeight,
                  crossAxisCount: 2,
                ),
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredGrid(
                      columnCount: 2,
                      position: index,
                      duration: const Duration(milliseconds: 1000),
                      child: ScaleAnimation(
                          scale: 1,
                          child: FlipAnimation(
                            child: PointItemsGridWidget(),
                          )));
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              'Earn points on the go!',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20.h,
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/spinner.png',
                      width: 100.h,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('Weekly Wins',
                              style: TextStyle(fontSize: 14.sp)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                              'Every 7 Days, Spin to Win Surprise B2 Points. Accumulate to redeem e-gifts & prizes!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w200)),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text('Spin the Wheel',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Theme.of(context).primaryColor)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      );
    });
  }
}
