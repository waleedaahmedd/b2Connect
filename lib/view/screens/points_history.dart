import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../view_model/providers/points_provider.dart';
import '../widgets/point_items_vertical_widgets.dart';

class PointsHistory extends StatefulWidget {
  const PointsHistory({Key? key}) : super(key: key);

  @override
  _PointsHistoryState createState() => _PointsHistoryState();
}

class _PointsHistoryState extends State<PointsHistory> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PointsProvider>(builder: (context, _pointsProvider, _) {
      return ListView.builder(
          itemCount: _pointsProvider.getPointsModel.transactions!.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                PointItemsVerticalWidgets(rewardsList: _pointsProvider.getPointsModel.transactions!, index: index),
                SizedBox(height: 20.h,)
              ],
            );
          });
    });
  }
}
