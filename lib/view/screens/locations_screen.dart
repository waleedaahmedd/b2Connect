import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../model/locale/app_localization.dart';
import '../../view_model/providers/location_provider.dart';
import '../widgets/appbar_with_back_icon_and_language.dart';
import '../widgets/custom_buttons/gradiant_color_button.dart';
import '../widgets/showOnWillPop.dart';

class LocationsScreen extends StatelessWidget {
  const LocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBarWithBackIconAndLanguage(
        onTapIcon: () {
          Navigator.pop(context);
        },
      ),
      body:
          Consumer<LocationProvider>(builder: (context, _locationProvider, _) {
        return Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Around Me',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 25.sp,
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.search),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 70.h,
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      itemExtent: 75.0,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          _locationProvider.getLocationCategoriesList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                            onTap: () {
                              _locationProvider.setSelectedCategory(index);
                            },
                            child: Column(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: _locationProvider
                                                        .getSelectedCategory ==
                                                    index
                                                ? Theme.of(context).primaryColor
                                                : Colors.grey.shade200),
                                        color: Colors.grey.shade200,
                                        shape: BoxShape.circle),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            _locationProvider
                                                .getLocationCategoriesList[
                                                    index]
                                                .image!,
                                            scale: 3,
                                            color: _locationProvider
                                                        .getSelectedCategory ==
                                                    index
                                                ? Theme.of(context).primaryColor
                                                : Colors.black,
                                          ),
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                    _locationProvider
                                        .getLocationCategoriesList[index].name!,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w200)),
                              ],
                            ),
                          )),
                ),
                /*SizedBox(
                  height: 15.h,
                ),*/
                Flexible(
                  child: AnimationLimiter(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0,bottom: 80.0),
                      itemCount: _locationProvider.getLocationsList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            navigationService
                                .navigateTo(LocationDetailScreenRoute);
                            /* setState(() {
                              _categoryId = _locationProvider
                                  .getLocationCategoriesList[index].id!;
                            });*/
                          },
                          child: Column(
                            children: [
                              Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  child: Row(
                                    children: [
                                      Card(
                                        child: Image.asset(
                                            'assets/images/sample2.png'),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _locationProvider
                                                  .getLocationsList[index]
                                                  .name!,
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                              _locationProvider
                                                  .getLocationsList[index]
                                                  .area!,
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w200),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  _locationProvider
                                                      .getLocationsList[index]
                                                      .rating!
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                RatingBar.builder(
                                                  ignoreGestures: true,
                                                  itemSize: 15.h,
                                                  unratedColor:
                                                      Color(0xFFEBF0FF),
                                                  initialRating:
                                                      _locationProvider
                                                          .getLocationsList[
                                                              index]
                                                          .rating!,
                                                  minRating: 0,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    color: Color(0xFFFFC833),
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12.h,
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  constraints: BoxConstraints(),
                                                  color: Colors.grey,
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.location_on,
                                                    size: 12.h,
                                                  ),
                                                  padding: EdgeInsets.zero,
                                                  alignment: Alignment.topLeft,
                                                ),
                                                //SizedBox(width: 5.w,),
                                                Expanded(
                                                  child: Text(
                                                    _locationProvider
                                                        .getLocationsList[index]
                                                        .location!,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w200),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    height: 50.h,
                    width: double.infinity,
                    onPressed: () async {
                      Navigator.pop(context);
/*
                        if (i.topUpCategoryName == '') {
                          EasyLoading.showError(
                              'Please select category');
                        } else {
                          i.topUpCategoryName == 'Mobile Top Up'
                              ? navigationService.navigateTo(
                              EditNumberTopUpScreenRoute)
                              : topUpSubCategories(
                              i.topUpCategoryName);
                        }*/
                    },
                    text: 'Back to Home',
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
