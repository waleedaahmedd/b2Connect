import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../model/utils/constant.dart';
import '../../view_model/providers/points_provider.dart';
import '../widgets/appbar_with_back_icon_and_language.dart';
import '../widgets/point_items_grid_widget.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PointsProvider>(builder: (context, _pointsProvider, _) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithBackIconAndLanguage(
          onTapIcon: () {
            Navigator.pop(context);
          },
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rewards',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 25.sp,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        gradient: gradientColor,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        '2100',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 25.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 2.0, color: Theme.of(context).primaryColor ),
                        )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5),
                      child: Text('Products', style: TextStyle(color:  Theme.of(context).primaryColor ),),
                    )),
              ),
            ),
            Divider(color: Colors.grey,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AnimationLimiter(
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
                   // physics: NeverScrollableScrollPhysics(),
                    itemCount: 100,
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
              ),
            ),
          ],
        ),
      );
    });
  }
}
