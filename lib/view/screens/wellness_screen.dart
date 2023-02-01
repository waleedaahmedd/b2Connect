import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/view/widgets/appBar_with_cart_notification_widget.dart';
import 'package:b2connect_flutter/view/widgets/blog_item_widget.dart';

import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view/widgets/web_view_page.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:b2connect_flutter/view_model/providers/blogs_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'blog_list_screen.dart';
import 'popular_details_screen.dart';

class WellnessScreen extends StatefulWidget {
  const WellnessScreen({Key? key}) : super(key: key);

  @override
  _WellnessScreenState createState() => _WellnessScreenState();
}

class _WellnessScreenState extends State<WellnessScreen> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  void initState() {
    // TODO: implement initState
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false)
          .setOtherBannersData('wellness');
    });

    loadData();
    super.initState();
  }

  /*final List<String> _imgList = [
    'assets/images/wellnessBanner.png',
   */ /* 'assets/images/wellnessBanner.png',
    'assets/images/wellnessBanner.png'*/ /*
  ];*/

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogsProvider>(
      builder: (context, i, _) {
        return Scaffold(
          appBar: AppBarWithCartNotificationWidget(
            title: AppLocalizations.of(context)!.translate('wellness')!,
            onTapIcon: () {
              i.wellnessBlogsList.clear();
              navigationService.closeScreen();
            },
          ) /*AppBar(
            leading: IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () {
                  i.wellnessBlogsList.clear();
                  navigationService.closeScreen();
                },
                icon: Icon(Icons.arrow_back_ios)),
            automaticallyImplyLeading: false,
            elevation: 0,
            centerTitle: false,
            toolbarHeight: height * 0.08,
            title: Text(
              AppLocalizations.of(context)!.translate('wellness')!,
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenSize.appbarText,
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(gradient: gradientColor),
            ),
          )*/
          ,
          body: WillPopScope(
            onWillPop: () {
              i.wellnessBlogsList.clear();
              Navigator.pop(context, false);
              return Future.value(false);
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      //height: height * 0.23,
                      child: Consumer<AuthProvider>(builder: (context, i, _) {
                        //_imgList.forEach((element) {});
                        return Provider.of<AuthProvider>(context, listen: false)
                                .otherBannerData
                                .isNotEmpty
                            ? Container(
                                //height: 170,
                                child: Image.network(
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .otherBannerData[0]
                                      .imageLink!,
                                  fit: BoxFit.fill,
                                ),
                              ) /*Column(
                                children: [
                                  CarouselSlider(
                                    carouselController: _controller,
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      height: height * 0.2,
                                      //ScreenSize.sliderHeight,
                                      viewportFraction: 1.0,
                                      enlargeCenterPage: false,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _current = index;
                                        });
                                      },
                                    ),
                                    items: _imgList
                                        .map((item) => GestureDetector(
                                              onTap: () {
                                                */ /* print(
                                                'index---${item.clickRedirectTo}');
                                            if (item.clickRedirectTo == 'WIFI')
                                              navigationService
                                                  .navigateTo(WifiScreenRoute);
                                            else if (item.clickRedirectTo ==
                                                'SHOP')
                                              navigationService.navigateTo(
                                                  CategoriesScreenRoute);
                                            else if (item.clickRedirectTo ==
                                                'GAMES') {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      WebViewPage(
                                                    url:
                                                        "https://go-games.gg/tournament?app=b2connect&country=ae&userid=${Provider.of<AuthProvider>(context, listen: false).getUID}",
                                                    title: AppLocalizations.of(
                                                            context)!
                                                        .translate('play')!,
                                                  ),
                                                ),
                                              );
                                            }*/ /*
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0, right: 5),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      12.r,
                                                    ),
                                                  ),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r),
                                                      child: Image.asset(
                                                        item,
                                                        fit: BoxFit.fill,
                                                      )
                                                      */ /* CachedNetworkImage(
                                                        imageUrl:
                                                            item.mediaUrLs![0],
                                                        */ /* */ /*placeholder: (context, url) => Image.asset(
                                              ),*/ /* */ /*
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Center(
                                                          child: Image.asset(
                                                            'assets/images/not_found1.png',
                                                            height: 100,
                                                          ),
                                                        ),
                                                        fit: BoxFit.cover,
                                                      )*/ /*

                                                      // FadeInImage(
                                                      //   image: NetworkImage(item.mediaUrLs![0]),
                                                      //   placeholder: AssetImage(
                                                      //   ),
                                                      //   fit: BoxFit.cover,
                                                      //
                                                      // ),
                                                      ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                  SizedBox(
                                    height:20,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: _imgList.asMap().entries.map(
                                        (entry) {
                                          return GestureDetector(
                                            onTap: () => _controller
                                                .animateToPage(entry.key),
                                            child: Container(
                                              width: 15.w,
                                              height: 7.h,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: _current == entry.key
                                                    ? pink
                                                    : Colors.grey,
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ],
                              )*/
                            : Center(
                                child: Container(
                                  //color: Colors.red,
                                ),
                              );
                      }),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Category',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 0.0, top: 15.0, bottom: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () async {
                                   // EasyLoading.show(status: 'Loading..');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebViewPage(
                                          url:
                                              "https://b2microapps.netlify.app/workout",
                                          title: "Fitness",
                                        ),
                                      ),
                                    );
                                    /* EasyLoading.show(status: 'Please Wait..');
                                    await Provider.of<BlogsProvider>(context,
                                            listen: false)
                                        .getBlogsContent(
                                            page: 1,
                                            category: "Fitness",
                                            screen: "fitness");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlogListScreen(
                                                i.fitnessBlogsList, 'Fitness')));*/
                                  },
                                  elevation: 0,
                                  fillColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  child: Icon(
                                    Icons.directions_bike,
                                    size: 25.0.h,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(25.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Fitness',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () async {
                                   // EasyLoading.show(status: 'Loading..');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebViewPage(
                                          url:
                                              "https://meditation-native.netlify.app/",
                                          title: "Meditation",
                                        ),
                                      ),
                                    );
                                    /*EasyLoading.show(status: 'Please Wait..');
                                    await Provider.of<BlogsProvider>(context,
                                        listen: false)
                                        .getBlogsContent(
                                        page: 1,
                                        category: "Meditation",
                                        screen: "meditation");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BlogListScreen(
                                                i.meditationBlogsList, 'Meditation')));*/
                                  },
                                  elevation: 0,
                                  fillColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  child: Icon(
                                    Icons.favorite,
                                    size: 25.0.h,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(25.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Meditation',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () async {
                                    EasyLoading.show(status: 'Please Wait..');
                                    await Provider.of<BlogsProvider>(context,
                                            listen: false)
                                        .getBlogsContent(
                                            page: 1,
                                            category: "health",
                                            screen: "health");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BlogListScreen(
                                                    i.healthBlogsList,
                                                    'Health')));
                                  },
                                  elevation: 0,
                                  fillColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  child: Icon(
                                    Icons.spa_outlined,
                                    size: 25.0.h,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(25.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Health',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                          /* Expanded(
                            child: Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 0,
                                  fillColor: */ /*Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1)*/ /*
                                      Colors.black12,
                                  child: Icon(
                                    Icons.supervisor_account_outlined,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Social',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),*/
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    /*  Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 0.0, top: 15.0, bottom: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 0,
                                  fillColor: */ /*Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1)*/ /*
                                      Colors.black12,
                                  child: Icon(
                                    Icons.local_hospital_outlined,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Hygiene',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 0,
                                  fillColor: */ /*Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1)*/ /*
                                      Colors.black12,
                                  child: Icon(
                                    Icons.supervisor_account_outlined,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Environmental',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 0,
                                  fillColor: */ /*Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1)*/ /*
                                      Colors.black12,
                                  child: Icon(
                                    Icons.airline_seat_flat_outlined,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Tele-Health',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 0,
                                  fillColor: */ /*Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1)*/ /*
                                  Colors.black12,
                                  child: Icon(
                                    Icons.favorite,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Meditation',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),*/
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Popular',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlogListScreen(
                                        i.wellnessBlogsList, 'Wellness')));
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'View All',
                              style: TextStyle(
                                  //fontWeight: FontWeight.w400,
                                  // fontSize: 15,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    GridView.builder(
                      // scrollDirection: Axis.horizontal,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: i.wellnessBlogsList.length < 2
                          ? i.wellnessBlogsList.length
                          : 2,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PopularDetailsScreen(
                                          i.wellnessBlogsList,
                                          index,
                                        )));
                          },
                          child: BlogItemWidget(i.wellnessBlogsList, index),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        // mainAxisSpacing: 4.0,
                        // crossAxisSpacing: 4.0,
                        childAspectRatio: 0.6.w,
                        //ScreenSize.productCardWidth / ScreenSize.productCardHeight,
                        crossAxisCount: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> loadData() async {
    EasyLoading.show(status: 'Please Wait..');
    await Provider.of<BlogsProvider>(context, listen: false)
        .getBlogsContent(page: 1, category: "Wellness", screen: "wellness");
    setState(() {});
  }

/* void confirmPhoneBottomSheet(context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          topLeft: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return ConfirmPhoneBottomSheet();
      },
    );
  }*/
}
