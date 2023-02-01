import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/view/widgets/appBar_with_cart_notification_widget.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view/widgets/web_view_page.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:b2connect_flutter/view_model/providers/blogs_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'announcement_details_screen.dart';
import 'announcement_screen.dart';

class CorporateScreen extends StatefulWidget {
  const CorporateScreen({Key? key}) : super(key: key);

  @override
  _CorporateScreenState createState() => _CorporateScreenState();
}

class _CorporateScreenState extends State<CorporateScreen> {
  @override
  void initState() {
    // TODO: implement initState
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false)
          .setOtherBannersData('corporate');
    });
    loadData();
    super.initState();
/*    EasyLoading.show(
        status: 'Please Wait...');*/
  }

  final CarouselController _controller = CarouselController();
  int _current = 0;

  /* final List<String> _imgList = [
    'assets/images/moneyBanner.png',
    */ /*'assets/images/moneyBanner.png',
    'assets/images/moneyBanner.png'*/ /*
  ];*/

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogsProvider>(
      builder: (context, i, _) {
        return Scaffold(
          appBar: AppBarWithCartNotificationWidget(
            title: 'Corporate',
            onTapIcon: () {
              i.announcementList.clear();
              navigationService.closeScreen();
            },
          )
          /*AppBar(
            leading: IconButton(
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () {
                  i.moneyBlogsList.clear();
                  navigationService.closeScreen();
                },
                icon: Icon(Icons.arrow_back_ios)),
            automaticallyImplyLeading: false,
            elevation: 0,
            centerTitle: false,
            toolbarHeight: height * 0.08,
            title: Text(
              AppLocalizations.of(context)!.translate('money')!,
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
              i.announcementList.clear();
              Navigator.pop(context, false);
              return Future.value(false);
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // height: height * 0.23,
                      child: Consumer<AuthProvider>(builder: (context, i, _) {
/*
                        _imgList.forEach((element) {});
*/
                        return Provider.of<AuthProvider>(context, listen: false)
                                .otherBannerData
                                .isNotEmpty
                            ? Container(
                                //height: 10.h,
                                child: Image.network(
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .otherBannerData[0]
                                      .imageLink!,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Center(
                                child: Container(
                                    //color: Colors.red,
                                    ),
                              );
                      }),
                    ),
                    SizedBox(height: 30.h),
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
                    SizedBox(height: 20.h),
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
                                    /* then((value) {*/
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AnnouncementScreen(
                                                  i.announcementList,
                                                  'Announcements')),
                                    );
                                    // navigationService.navigateTo(AnnouncementScreenRoute);
                                    /*    });*/
                                    /* Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditNumberTopUpScreen()),
                                    );*/
                                  },
                                  elevation: 0,
                                  fillColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  child: Icon(
                                    Icons.volume_up_outlined,
                                    size: 25.0.h,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(25.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Announcement',
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
                                  onPressed: () {
                                    navigationService
                                        .navigateTo(JobScreenRoute);
                                    //  EasyLoading.show(status: 'Loading..');
                                    /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebViewPage(
                                          url:
                                          "https://b2exchange.netlify.app/",
                                          title: "Exchange Rates",
                                        ),
                                      ),
                                    );*/
                                  },
                                  elevation: 0,
                                  fillColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  child: Icon(
                                    Icons.card_travel,
                                    size: 25.0.h,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(25.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Jobs',
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
                                  onPressed: () {
                                    //EasyLoading.show(status: 'Loading..');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebViewPage(
                                          url:
                                              "https://survey.zohopublic.com/zs/WWBUfc",
                                          title: "Survey",
                                        ),
                                      ),
                                    );
                                    //  EasyLoading.show(status: 'Loading..');
                                    /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebViewPage(
                                          url:
                                          "https://b2exchange.netlify.app/",
                                          title: "Exchange Rates",
                                        ),
                                      ),
                                    );*/
                                  },
                                  elevation: 0,
                                  fillColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  child: Icon(
                                    Icons.content_paste,
                                    size: 25.0.h,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(25.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Survey',
                                  textAlign: TextAlign.center,
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
                                    Icons.chrome_reader_mode_outlined,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10),
                                Text('Payments',style: TextStyle(
                                    fontSize: 12
                                ),),
                              ],
                            ),
                          ),*/
                        ],
                      ),
                    ),
                    /* SizedBox(height: 20.h),

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
                                    */ /* Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditNumberTopUpScreen()),
                                    );*/ /*

                                  },
                                  elevation: 0,
                                  fillColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  child: Icon(
                                    Icons.public,
                                    size: 25.0.h,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(25.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'News',
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
                                  onPressed: () {
                                    //  EasyLoading.show(status: 'Loading..');
                                    */ /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebViewPage(
                                          url:
                                          "https://b2exchange.netlify.app/",
                                          title: "Exchange Rates",
                                        ),
                                      ),
                                    );*/ /*
                                  },
                                  elevation: 0,
                                  fillColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  child: Icon(
                                    Icons.content_paste,
                                    size: 25.0.h,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(25.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Survey',
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
                                    */ /*   EasyLoading.show(status: 'Please Wait..');
                                    await Provider.of<BlogsProvider>(context,
                                        listen: false)
                                        .getBlogsContent(
                                        page: 1,
                                        category: "Payments",
                                        screen: "payments");*/ /*
                                    */ /*  Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BlogListScreen(
                                                    i.paymentsBlogsList,
                                                    'Payments')));*/ /*
                                  },
                                  elevation: 0,
                                  fillColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  child: Icon(
                                    Icons.schedule,
                                    size: 25.0.h,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(25.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Calendar',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,),
                                ),
                              ],
                            ),
                          ),
                          */ /* Expanded(
                            child: Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 0,
                                  fillColor: */ /* */ /*Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1)*/ /* */ /*
                                      Colors.black12,
                                  child: Icon(
                                    Icons.chrome_reader_mode_outlined,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10),
                                Text('Payments',style: TextStyle(
                                    fontSize: 12
                                ),),
                              ],
                            ),
                          ),*/ /*
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
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
                                    */ /* Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditNumberTopUpScreen()),
                                    );*/ /*

                                  },
                                  elevation: 0,
                                  fillColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  child: Icon(
                                    Icons.where_to_vote_outlined,
                                    size: 25.0.h,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(25.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Around Me',
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
                                  onPressed: () {
                                    //  EasyLoading.show(status: 'Loading..');
                                    */ /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WebViewPage(
                                          url:
                                          "https://b2exchange.netlify.app/",
                                          title: "Exchange Rates",
                                        ),
                                      ),
                                    );*/ /*
                                  },
                                  elevation: 0,
                                  fillColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  child: Icon(
                                    Icons.gamepad_outlined,
                                    size: 25.0.h,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(25.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Sports',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                         */ /* Expanded(
                            child: Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () async {
                                    */ /**/ /*   EasyLoading.show(status: 'Please Wait..');
                                    await Provider.of<BlogsProvider>(context,
                                        listen: false)
                                        .getBlogsContent(
                                        page: 1,
                                        category: "Payments",
                                        screen: "payments");*/ /**/ /*
                                    */ /**/ /*  Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BlogListScreen(
                                                    i.paymentsBlogsList,
                                                    'Payments')));*/ /**/ /*
                                  },
                                  elevation: 0,
                                  fillColor: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  child: Icon(
                                    Icons.fastfood_outlined,
                                    size: 25.0.h,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(25.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Meal',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,),
                                ),
                              ],
                            ),
                          ),*/ /*
                          */ /* Expanded(
                            child: Column(
                              children: [
                                RawMaterialButton(
                                  onPressed: () {},
                                  elevation: 0,
                                  fillColor: */ /* */ /*Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1)*/ /* */ /*
                                      Colors.black12,
                                  child: Icon(
                                    Icons.chrome_reader_mode_outlined,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10),
                                Text('Payments',style: TextStyle(
                                    fontSize: 12
                                ),),
                              ],
                            ),
                          ),*/ /*
                        ],
                      ),
                    ),*/
                    SizedBox(height: 20.h),
                    /* Padding(
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
                                    Icons.gradient,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10),
                                Text('Scan to Pay',style: TextStyle(
                                    fontSize: 12
                                ),),
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
                                    Icons.local_atm,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10),
                                Text('Loans',style: TextStyle(
                                    fontSize: 12
                                ),),
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
                                    Icons.monetization_on_outlined,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10),
                                Text('Send Money',style: TextStyle(
                                    fontSize: 12
                                ),),
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
                                    Icons.speaker_group_outlined,
                                    size: 25.0,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                ),
                                SizedBox(height: 10),
                                Text('Pay Later',style: TextStyle(
                                    fontSize: 12
                                ),),
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
/*
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlogListScreen(
                                        i.moneyBlogsList, 'Money')));
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'View All',
                              style: TextStyle(
                                //fontWeight: FontWeight.w400,
                                //fontSize: 15,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
*/
                      ],
                    ),
                    SizedBox(height: 30.h),
                    GridView.builder(
                      // scrollDirection: Axis.horizontal,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: i.announcementList.length < 2
                          ? i.announcementList.length
                          : 2,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            EasyLoading.show(status: 'Please Wait...');
                            Provider.of<BlogsProvider>(context, listen: false)
                                .getAnnouncementDetail(
                                    id: i.announcementList[index].id)
                                .then((value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AnnouncementDetailsScreen(
                                          announcementDetails:
                                              Provider.of<BlogsProvider>(
                                                      context,
                                                      listen: false)
                                                  .announcementDetails,
                                          screenName:
                                              '${i.announcementList[index].category}',
                                        )),
                              );
                              // navigationService.navigateTo(AnnouncementScreenRoute);
                            });
                          },
                          child: Container(
                              child: Wrap(
                            children: [
                              Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0,
                                      right: 10.0,
                                      top: 10.0,
                                      bottom: 10.0),
                                  child: Container(
                                    //width: 150,
                                    child: Column(
                                      //crossAxisAlignment:
                                      // CrossAxisAlignment.start,
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0.r),
                                          child: Center(
                                            child: CachedNetworkImage(
                                              height: 130.h,
                                              imageUrl: i
                                                      .announcementList[index]
                                                      .image!
                                                      .isNotEmpty
                                                  ? i.announcementList[index]
                                                      .image!
                                                  : 'assets/images/not_found1.png',
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                      'assets/images/placeholder1.png'),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Center(
                                                child: Image.asset(
                                                  'assets/images/not_found1.png',
                                                  height: 100,
                                                ),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ), /*Image.network(
                                              i.moneyPopularList[index].mediaURLs!.first,
                                              fit: BoxFit.fitHeight,
                                              height: 120,
                                            ),*/
                                        ),
                                        SizedBox(height: 10),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${i.announcementList[index].title}",
                                            /*
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,*/
                                            //textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${i.announcementList[index].category}",
                                            /* overflow: TextOverflow.ellipsis,
                                        maxLines: 2,*/
                                            //textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
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
        .getAnnouncementList();

    setState(() {});
  }
}
