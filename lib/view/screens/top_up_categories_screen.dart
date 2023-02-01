
import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/services/util_service.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/screens/view_all_service_screen.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view/widgets/no_internet.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

//import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';


class TopUpCategoriesScreen extends StatefulWidget {
  @override
  _TopUpCategoriesScreenState createState() => _TopUpCategoriesScreenState();
}

class _TopUpCategoriesScreenState extends State<TopUpCategoriesScreen> {
  NavigationService navigationService = locator<NavigationService>();
  UtilService utilsService = locator<UtilService>();
  bool _connectedToInternet = true;

  getData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      await Provider.of<OffersProvider>(context, listen: false)
          .getTopUpCategories();
    } else {
      setState(() {
        _connectedToInternet = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (Provider.of<OffersProvider>(context, listen: false)
        .topUpCategories
        .isEmpty) {
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithBackIconAndLanguage(
          onTapIcon: () {
            Navigator.pop(context);
            Provider.of<OffersProvider>(context, listen: false)
                .clearFilterData();
          },
        ),
        body: _connectedToInternet
            ? Consumer<OffersProvider>(
                builder: (context, i, _) {
                  return i.topUpCategories.isNotEmpty
                      ? Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('categories')!,
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
                                        itemCount: i.topUpCategories.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              i.setTopUpCategoryId(i
                                                  .topUpCategories[index].name);
                                            },
                                            child: Card(
                                              elevation: 10,
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: i.topUpCategoryName ==
                                                            i
                                                                .topUpCategories[
                                                                    index]
                                                                .name
                                                        ? Theme.of(context)
                                                            .primaryColor
                                                        : Colors.grey,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          i
                                                              .topUpCategories[
                                                                  index]
                                                              .name
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12.h,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: i
                                                                      .topUpCategories[
                                                                          index]
                                                                      .imageUrl ==
                                                                  ""
                                                              ? Image.asset(
                                                                  'assets/images/not_found1.png',
                                                                  // height: 100.h,
                                                                )
                                                              : CachedNetworkImage(
                                                                  // width: 100.w,
                                                                  // height: 100.h,
                                                                  imageUrl: i
                                                                      .topUpCategories[
                                                                          index]
                                                                      .imageUrl,
                                                                  height: 40.h,

                                                                  placeholder: (context,
                                                                          url) =>
                                                                      Image
                                                                          .asset(
                                                                    'assets/images/placeholder1.png',
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Image
                                                                          .asset(
                                                                    'assets/images/not_found1.png',
                                                                    // height: 100,
                                                                  ),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                        )),
                                                        SizedBox(
                                                          height: 20.h,
                                                          width: 20.w,
                                                          child:
                                                              Transform.scale(
                                                            scale: 1.5,
                                                            child: Checkbox(
                                                              checkColor:
                                                                  Colors.white,
                                                              activeColor: Theme
                                                                      .of(context)
                                                                  .primaryColor,
                                                              side: BorderSide(
                                                                width: 1,
                                                                color: Colors
                                                                    .grey
                                                                    .shade400,
                                                              ),
                                                              value: i.topUpCategoryName ==
                                                                      i.topUpCategories[index]
                                                                          .name
                                                                  ? true
                                                                  : false,
                                                              onChanged: (bool?
                                                                  value) {
                                                                i.setTopUpCategoryId(i
                                                                    .topUpCategories[
                                                                        index]
                                                                    .name);
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

                                      if (i.topUpCategoryName == '') {
                                        EasyLoading.showError(
                                            'Please select category');
                                      } else {
                                        i.topUpCategoryName == 'Mobile Top Up'
                                            ? navigationService.navigateTo(
                                                EditNumberTopUpScreenRoute)
                                            : topUpSubCategories(
                                                i.topUpCategoryName);
                                      }
                                    },
                                    text: AppLocalizations.of(context)!
                                        .translate('ship_next_button')!,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        );
                },
              )
            : NoInternet());
  }

  topUpSubCategories(String topUpCategoryName) async {
    EasyLoading.show(status: 'Please Wait...');
    var selectedCategory;
    topUpCategoryName == 'VoIP'
        ? selectedCategory = 'voip'
        : topUpCategoryName == 'App Stores'
            ? selectedCategory = 'store'
            : topUpCategoryName == 'Entertainment'
                ? selectedCategory = 'netflix'
                : topUpCategoryName == 'Games'
                    ? selectedCategory = 'pubg'
                    : selectedCategory = 'salik';
    await getServiceDetail(selectedCategory, context).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewAllServiceScreen(
            name: topUpCategoryName,
          ),
        ),
      );
    });
  }

  Future<void> getServiceDetail(String _name, BuildContext context) async {
    await Provider.of<OffersProvider>(context, listen: false)
        .getOffers(/*categoryId: _categoryId,*/ perPage: 10, name: _name);
  }
}
