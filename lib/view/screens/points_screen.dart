import 'package:b2connect_flutter/view/screens/points_history.dart';
import 'package:b2connect_flutter/view/screens/points_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../view_model/providers/points_provider.dart';
import '../widgets/appbar_with_back_icon_and_language.dart';

class PointsScreen extends StatefulWidget {
  const PointsScreen({Key? key}) : super(key: key);

  @override
  _PointsScreenState createState() => _PointsScreenState();
}

class _PointsScreenState extends State<PointsScreen> {
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
              child: Text(
                _pointsProvider.getPointsMainView ? 'B2 Points' : 'History',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 25.sp,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _pointsProvider.setPointsMainView(true);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                              width: 2.0,
                              color: _pointsProvider.getPointsMainView
                                  ? Theme.of(context).primaryColor
                                  : Colors.white),
                        )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5),
                          child: Text(
                            'Main',
                            style: TextStyle(
                                color: _pointsProvider.getPointsMainView
                                    ? Theme.of(context).primaryColor
                                    : Colors.black),
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      _pointsProvider.setPointsMainView(false);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(
                              width: 2.0,
                              color: _pointsProvider.getPointsMainView
                                  ? Colors.white
                                  : Theme.of(context).primaryColor),
                        )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5),
                          child: Text(
                            'History',
                            style: TextStyle(
                                color: _pointsProvider.getPointsMainView
                                    ? Colors.black
                                    : Theme.of(context).primaryColor),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 10, left: 20.0, right: 20.0),
                child: _pointsProvider.getPointsMainView
                    ? PointsMain()
                    : PointsHistory(),
              ),
            )
          ],
        ),
      );
    });
  }
}
