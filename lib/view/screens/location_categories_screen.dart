/*
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../model/locale/app_localization.dart';
import '../../model/utils/routes.dart';
import '../../view_model/providers/location_provider.dart';
import '../widgets/appbar_with_back_icon_and_language.dart';
import '../widgets/custom_buttons/gradiant_color_button.dart';
import '../widgets/showOnWillPop.dart';

class LocationCategoriesScreen extends StatefulWidget {
  const LocationCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<LocationCategoriesScreen> createState() =>
      _LocationCategoriesScreenState();
}

class _LocationCategoriesScreenState extends State<LocationCategoriesScreen> {
  int _categoryId = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<LocationProvider>(context, listen: false)
          .callLocationCategoriesList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithBackIconAndLanguage(
          onTapIcon: () {
            Navigator.pop(context);
          },
        ),
        body: Consumer<LocationProvider>(
            builder: (context, _locationProvider, _) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!.translate('categories')!,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 25.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Flexible(
                      child: AnimationLimiter(
                        child: GridView.builder(
                          itemCount: _locationProvider
                              .getLocationCategoriesList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _categoryId = _locationProvider
                                      .getLocationCategoriesList[index].id!;
                                });
                              },
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: _categoryId ==
                                              _locationProvider
                                                  .getLocationCategoriesList[
                                                      index]
                                                  .id
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            _locationProvider
                                                .getLocationCategoriesList[
                                                    index]
                                                .name
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 12.h,
                                                fontWeight: FontWeight.w500),
                                          )),
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: _locationProvider
                                                              .getLocationCategoriesList[
                                                                  index]
                                                              .image ==
                                                          ""
                                                      ? Image.asset(
                                                          'assets/images/not_found1.png',
                                                          // height: 100.h,
                                                        )
                                                      : Image.asset(
                                                          _locationProvider
                                                              .getLocationCategoriesList[
                                                                  index]
                                                              .image!,
                                                          height: 40.h,
                                                        )

                                                  */
/*CachedNetworkImage(
                                                    // width: 100.w,
                                                    // height: 100.h,
                                                    imageUrl: _locationProvider
                                                        .getLocationCategoriesList[
                                                            index]
                                                        .image!,
                                                    height: 50.h,

                                                    placeholder:
                                                        (context, url) =>
                                                            Image.asset(
                                                      'assets/images/placeholder1.png',
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Image.asset(
                                                      'assets/images/not_found1.png',
                                                      // height: 100,
                                                    ),
                                                    fit: BoxFit.fill,
                                                  ),*//*

                                                  )),
                                          SizedBox(
                                            height: 20.h,
                                            width: 20.w,
                                            child: Transform.scale(
                                              scale: 1.5,
                                              child: Checkbox(
                                                checkColor: Colors.white,
                                                activeColor: Theme.of(context)
                                                    .primaryColor,
                                                side: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey.shade400,
                                                ),
                                                value: _categoryId ==
                                                        _locationProvider
                                                            .getLocationCategoriesList[
                                                                index]
                                                            .id
                                                    ? true
                                                    : false,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    _categoryId = _locationProvider
                                                        .getLocationCategoriesList[
                                                            index]
                                                        .id!;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 2.3,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20),
                        ),
                      ),
                    ),
                  ],
                ),
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
                        _locationProvider.callLocationsList();
                        navigationService.navigateTo(LocationsScreenRoute);
*/
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
                        }*//*

                      },
                      text: AppLocalizations.of(context)!
                          .translate('ship_next_button')!,
                    ),
                  ],
                ),
              )
            ],
          );
        }));
  }
}
*/
