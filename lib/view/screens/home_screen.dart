import 'dart:async';
import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/models/offers_models/get_offers_model.dart';
import 'package:b2connect_flutter/model/models/offers_models/offers_list_model.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/services/storage_service.dart';
import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/screens/view_all_offers_screen.dart';
import 'package:b2connect_flutter/view/widgets/appBar_with_cart_notification_widget.dart';
import 'package:b2connect_flutter/view/widgets/no_internet.dart';
import 'package:b2connect_flutter/view/widgets/offers_list_widget.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view/widgets/web_view_page.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:b2connect_flutter/view_model/providers/fortune_provider.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:b2connect_flutter/view_model/providers/pay_by_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

//import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import '../../model/services/navigation_service.dart';
import '../../model/services/storage_service.dart';
import '../../model/utils/routes.dart';
import '../../model/utils/service_locator.dart';
import '../../view/widgets/showOnWillPop.dart';
import '../../view/widgets/web_view_page.dart';
import '../../view_model/providers/auth_provider.dart';
import '../../model/models/notification_model.dart';
import '../../view_model/providers/location_provider.dart';
import '../../view_model/providers/points_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

late GetOffers _offersData;
//List<AdvertismentModel> _data = [];
//List imgList = [];
//List onClickAgainstImg = [];
List<OffersList> _offerList = [];

class _HomeScreenState extends State<HomeScreen> {
  bool _showMore = false;
  final CarouselController _controller = CarouselController();
  int _current = 0;
  NavigationService navigationService = locator<NavigationService>();
  var storageService = locator<StorageService>();
  List<NotificationModel> _notificationData = [];
  bool _connectedToInternet = true;
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  loadData() async {
    await storageService.setBoolData('isShowHome', true);
  }

  callData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      loadData();
      setListData();

      Future.delayed(Duration.zero, () async {
        await Provider.of<AuthProvider>(context, listen: false)
            .callUserInfo(context)
            .then((value) async {
          Provider.of<AuthProvider>(context, listen: false)
              .saveUid(value.uid.toString());
          Provider.of<PayByProvider>(context, listen: false).topUpMobileNumber =
              Provider.of<AuthProvider>(context, listen: false)
                  .userInfoData!
                  .uid
                  .toString()
                  .substring(3);
        });

        await Provider.of<AuthProvider>(context, listen: false).callAdvert();

        await analytics
            .setUserProperty(
                name: 'login',
                value: Provider.of<AuthProvider>(context, listen: false)
                    .userInfoData!
                    .uid)
            .then((value) => print('success analytics'));

        await analytics
            .setUserProperty(
                name: 'role',
                value: Provider.of<AuthProvider>(context, listen: false)
                    .userInfoData!
                    .userRole)
            .then((value) => print('success analytics'));

        await analytics
            .setUserProperty(
                name: 'type',
                value: Provider.of<AuthProvider>(context, listen: false)
                        .userInfoData!
                        .isCorporate!
                    ? 'Corporate Users'
                    : 'Normal Users')
            .then((value) => print('success analytics'));

        await analytics
            .setUserProperty(
                name: 'mac',
                value: Provider.of<AuthProvider>(context, listen: false)
                    .getMacAddress)
            .then((value) => print('success analytics'));

        await analytics
            .setUserProperty(
                name: 'zone',
                value: Provider.of<AuthProvider>(context, listen: false)
                    .userInfoData!
                    .zone)
            .then((value) => print('success analytics'));

        /*Future<void> _testSetUserId() async {*/
        //
        // setMessage('setUserId succeeded');
        /* }*/

        /*Provider.of<AuthProvider>(context, listen: false)
                    .userInfoData
                    ?.spinEligable ==
                false */ /*&&
                Provider.of<AuthProvider>(context, listen: false)
                        .userInfoData
                        ?.spinResult ==
                    null*/ /*
            ? _spinnerVisibility = false
            : _spinnerVisibility = true;*/

        if (Provider.of<AuthProvider>(context, listen: false)
                .notificationData
                .isEmpty ==
            true) {
          await Provider.of<AuthProvider>(context, listen: false)
              .callNotifications(context, '1', '30')
              .then((value) {
            setState(() {
              _notificationData.addAll(value);
            });
          });
        } else {
          _notificationData.addAll(
              Provider.of<AuthProvider>(context, listen: false)
                  .notificationData);
        }
        if (Provider.of<AuthProvider>(context, listen: false)
                    .userInfoData!
                    .firstName ==
                '' ||
            Provider.of<AuthProvider>(context, listen: false)
                    .userInfoData!
                    .lastName ==
                '') {
          navigationService.navigateTo(EditPersonalInformationScreenRoute);
        }
      });
    } else {
      setState(() {
        _connectedToInternet = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    callData();
  }

  bool _spinnerVisibility = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Consumer<AuthProvider>(builder: (context, i, _) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarWithCartNotificationWidget(
            tawasalIcon: true,
           //TODO: SHOW NEW FEATURES
            showPoints: true,
            title: i.userInfoData != null
                ? "${AppLocalizations.of(context)!.translate('welcome2')!} ${i.userInfoData!.firstName}"
                : "${AppLocalizations.of(context)!.translate('welcome2')!}",
            onTapIcon: () {},
            leadingWidget: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image.asset(
                "assets/images/logo_icon.png",
                scale: 8,
                height: 30.h,
              ),
            ),
          ),
          body: _connectedToInternet
              ? WillPopScope(
                  onWillPop: () async {
                    showOnWillPop(context);
                    return false;
                  },
                  child: i.userInfoData != null
                      ? Padding(
                          padding: EdgeInsets.only(left: 15.h, right: 15.h),
                          child: SingleChildScrollView(
                            child: AnimationLimiter(
                              child: Column(
                                children:
                                    AnimationConfiguration.toStaggeredList(
                                  duration: const Duration(milliseconds: 1000),
                                  childAnimationBuilder: (widget) =>
                                      ScaleAnimation(
                                    scale: 1,
                                    child: FlipAnimation(
                                      child: widget,
                                    ),
                                  ),
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 2.w,
                                          color: Colors.grey.shade200,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0, bottom: 20.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: tile(
                                                      context: context,
                                                      url:
                                                          "assets/images/Consultation.png",
                                                      title: AppLocalizations
                                                              .of(context)!
                                                          .translate('wifi')!,
                                                      onTap: () {
                                                        navigationService
                                                            .navigateTo(
                                                                WifiScreenRoute);
                                                      }),
                                                ),
                                                Expanded(
                                                  child: tile(
                                                      context: context,
                                                      url:
                                                          "assets/images/Dental.png",
                                                      title: AppLocalizations
                                                              .of(context)!
                                                          .translate('shop')!,
                                                      onTap: () {
                                                        navigationService
                                                            .navigateTo(
                                                                ShopScreenRoute);
                                                      }),
                                                ),
                                                Expanded(
                                                  child: tile(
                                                      context: context,
                                                      url:
                                                          "assets/images/Heart.png",
                                                      title: AppLocalizations
                                                              .of(context)!
                                                          .translate('play')!,
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    WebViewPage(
                                                              url:
                                                                  "https://b2-games.vercel.app/",
                                                              title: AppLocalizations
                                                                      .of(
                                                                          context)!
                                                                  .translate(
                                                                      'play')!,
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: tile(
                                                      context: context,
                                                      url:
                                                          "assets/images/Medicines.png",
                                                      title: AppLocalizations
                                                              .of(context)!
                                                          .translate('money')!,
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    WebViewPage(
                                                              url:
                                                                  "https://b2microapps.netlify.app/exchange",
                                                              title:
                                                                  "Exchange Rates",
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                ),
                                                Expanded(
                                                  child: tile(
                                                      context: context,
                                                      url:
                                                          "assets/images/Hospitals.png",
                                                      title:
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .translate(
                                                                  'wellness')!,
                                                      onTap: () {
                                                        navigationService
                                                            .navigateTo(
                                                                WellnessScreenRoute);
                                                      }),
                                                ),
                                                Expanded(
                                                  child: tile(
                                                      context: context,
                                                      url:
                                                          "assets/images/Physician.png",
                                                      title: AppLocalizations
                                                              .of(context)!
                                                          .translate(
                                                              'entertainment')!,
                                                      onTap: () {
                                                        navigationService
                                                            .navigateTo(
                                                                MediaScreenRoute);
                                                      }),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            //TODO:HIDE OLD FEATURES
                                          /*  Row(
                                              children: [
                                                Expanded(
                                                  child: tile(
                                                      context: context,
                                                      url:
                                                      "assets/images/TopUp.png",
                                                      title: AppLocalizations
                                                          .of(context)!
                                                          .translate('top_up')!,
                                                      onTap: () {
                                                        navigationService
                                                            .navigateTo(
                                                            TopUpCategoriesScreenRoute);
                                                        *//*navigationService.navigateTo(
                                                    EditNumberTopUpScreenRoute);*//*
                                                      }),
                                                ),
                                                Expanded(
                                                  child: tile(
                                                      context: context,
                                                      url:
                                                      "assets/images/travel.png",
                                                      title: AppLocalizations
                                                          .of(
                                                          context)!
                                                          .translate(
                                                          'travel')!,
                                                      onTap: () {
                                                       *//* EasyLoading.show(
                                                            status: 'Loading..');*//*
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                WebViewPage(
                                                                  url:
                                                                  "https://asfartrip.com/en/affiliate-login?id=TVRrek56VT0=",
                                                                  title:
                                                                  'Travel',
                                                                ),
                                                          ),
                                                        );

                                                      *//*  navigationService.navigateTo(
                                                            TravelScreenRoute);*//*
                                                      }),
                                                ),
                                                i.userInfoData != null
                                                    ? i.userInfoData!
                                                    .isCorporate!
                                                    ? Expanded(
                                                  child: tile(
                                                      context:
                                                      context,
                                                      url:
                                                      "assets/images/corporate.png",
                                                      title:
                                                      "Corporate",
                                                      onTap: () {
                                                        navigationService
                                                            .navigateTo(
                                                            CorporateScreenRoute);
                                                      }),
                                                )
                                                    : Expanded(
                                                  child: tile(
                                                    context: context,
                                                    url:
                                                    "assets/images/jobs.png",
                                                    title: AppLocalizations
                                                        .of(
                                                        context)!
                                                        .translate(
                                                        'jobs')!,
                                                    onTap: () {
                                                      navigationService
                                                          .navigateTo(
                                                          JobScreenRoute);
                                                    },
                                                  ),
                                                )
                                                    : Container(),

                                              ],
                                            ),*/
                                            //TODO: SHOW NEW FEATURES
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: tile(
                                                      context: context,
                                                      url:
                                                          "assets/images/TopUp.png",
                                                      title: AppLocalizations
                                                              .of(context)!
                                                          .translate('top_up')!,
                                                      onTap: () {
                                                        navigationService
                                                            .navigateTo(
                                                                TopUpCategoriesScreenRoute);
                                                        navigationService.navigateTo(
                                                    EditNumberTopUpScreenRoute);
                                                      }),
                                                ),
                                                i.userInfoData != null
                                                    ? i.userInfoData!
                                                            .isCorporate!
                                                        ? Expanded(
                                                            child: tile(
                                                                context:
                                                                    context,
                                                                url:
                                                                    "assets/images/corporate.png",
                                                                title:
                                                                    "Corporate",
                                                                onTap: () {
                                                                  navigationService
                                                                      .navigateTo(
                                                                          CorporateScreenRoute);
                                                                }),
                                                          )
                                                        : Expanded(
                                                            child: tile(
                                                              context: context,
                                                              url:
                                                                  "assets/images/jobs.png",
                                                              title: AppLocalizations
                                                                      .of(
                                                                          context)!
                                                                  .translate(
                                                                      'jobs')!,
                                                              onTap: () {
                                                                navigationService
                                                                    .navigateTo(
                                                                        JobScreenRoute);
                                                              },
                                                            ),
                                                          )
                                                    : Container(),
                                                Expanded(
                                                  child: tile(
                                                      context: context,
                                                      url:
                                                          "assets/images/reward.png",
                                                      title: 'Rewards',
                                                      onTap: () async {
                                                      /*await Provider.of<PointsProvider>(
                                                            context,
                                                            listen: false).callPointsApi();
                                                        Provider.of<PointsProvider>(
                                                                context,
                                                                listen: false)
                                                            .setPointsMainView(
                                                                true);
                                                        navigationService
                                                            .navigateTo(
                                                                PointsScreenRoute);*/

                                                      navigationService.navigateTo(ComingSoonScreenRoute);

                                                      }),
                                                ),
                                              ],
                                            ),
                                            Visibility(
                                              visible: _showMore ? true : false,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: tile(
                                                            context: context,
                                                            url:
                                                                "assets/images/around_me.png",
                                                            title: 'Around-Me',
                                                            onTap: () async {
                                                              await Provider.of<LocationProvider>(
                                                                  context,
                                                                  listen: false).callLocationCategoriesList();
                                                             await Provider.of<LocationProvider>(
                                                                  context,
                                                                  listen: false).callLocationsList();
                                                              navigationService.navigateTo(LocationsScreenRoute);

                                                            }),
                                                      ),
                                                      Expanded(
                                                        child: tile(
                                                            context: context,
                                                            url:
                                                                "assets/images/travel.png",
                                                            title: AppLocalizations
                                                                    .of(
                                                                        context)!
                                                                .translate(
                                                                    'travel')!,
                                                            onTap: () {
                                                              /*  EasyLoading.show(
                                                          status: 'Loading..');*/
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          WebViewPage(
                                                                    url:
                                                                        "https://asfartrip.com/en/affiliate-login?id=TVRrek56VT0=",
                                                                    title:
                                                                        'Travel',
                                                                  ),
                                                                ),
                                                              );

                                                           /*   navigationService.navigateTo(
                                                    TravelScreenRoute);*/
                                                            }),
                                                      ),
                                                      Expanded(
                                                          child: Container(
                                                        width: 20.w,
                                                      )),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    //TODO: SHOW NEW FEATURES
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _showMore = !_showMore;
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              _showMore
                                                  ? 'Show Less'
                                                  : 'Show More',
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            Icon(
                                              _showMore
                                                  ? Icons
                                                      .keyboard_double_arrow_up
                                                  : Icons
                                                      .keyboard_double_arrow_down,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )
                                          ],
                                        )),
                                    Visibility(
                                      visible: Provider.of<AuthProvider>(
                                              context,
                                              listen: false)
                                          .userInfoData!
                                          .spinEligable!,
                                      child: GestureDetector(
                                        onTap: () async {
                                          await Provider.of<FortuneProvider>(
                                                  context,
                                                  listen: false)
                                              .getFortuneList()
                                              .then((value) =>
                                                  navigationService.navigateTo(
                                                      SpinnerScreenRoute));
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/game_background.png"),
                                                  scale: 1,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              child:
                                                  /*  Image.asset(
                                      "assets/images/game_background.png"),*/
                                                  Row(
                                                //mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Image.asset(
                                                      "assets/images/wheel_of_fortune.png",
                                                      width: 50.w,
                                                      height: 50.h,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Special Spin & Win',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.yellow,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8.0),
                                                            child: Text(
                                                                'Click here to open'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      //height: height * 0.23,
                                      child: Consumer<AuthProvider>(
                                          builder: (context, i, _) {
                                        i.bannerData.forEach((element) {});

                                        return i.bannerData.isNotEmpty
                                            ? Column(
                                                children: [
                                                  CarouselSlider(
                                                    carouselController:
                                                        _controller,
                                                    options: CarouselOptions(
                                                      autoPlay: true,
                                                      viewportFraction: 1.0,
                                                      enlargeCenterPage: false,
                                                      onPageChanged:
                                                          (index, reason) {
                                                        setState(() {
                                                          _current = index;
                                                        });
                                                      },
                                                    ),
                                                    items: i.homeBannerData
                                                        .map(
                                                            (item) =>
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    if (item.navigation ==
                                                                        'wifi')
                                                                      navigationService
                                                                          .navigateTo(
                                                                              WifiScreenRoute);
                                                                    else if (item
                                                                            .navigation ==
                                                                        'shop')
                                                                      navigationService
                                                                          .navigateTo(
                                                                              ShopScreenRoute);
                                                                    else if (item
                                                                            .navigation ==
                                                                        'topop') {
                                                                      navigationService
                                                                          .navigateTo(
                                                                              TopUpCategoriesScreenRoute);
                                                                    } else if (item
                                                                            .navigation ==
                                                                        'job') {
                                                                      navigationService
                                                                          .navigateTo(
                                                                              JobScreenRoute);
                                                                    } else if (item
                                                                            .navigation ==
                                                                        'engage') {
                                                                      navigationService
                                                                          .navigateTo(
                                                                              MediaScreenRoute);
                                                                    } else if (item
                                                                            .navigation ==
                                                                        'wellness') {
                                                                      navigationService
                                                                          .navigateTo(
                                                                              WellnessScreenRoute);
                                                                    } else if (item
                                                                            .navigation ==
                                                                        'money') {
                                                                      /* EasyLoading.show(
                                                                          status:
                                                                              'Loading..');*/
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              WebViewPage(
                                                                            url:
                                                                                "https://b2microapps.netlify.app/exchange",
                                                                            title:
                                                                                "Exchange Rates",
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (item
                                                                            .navigation ==
                                                                        'money/live-exchange-rates') {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              WebViewPage(
                                                                            url:
                                                                                "https://b2microapps.netlify.app/exchange",
                                                                            title:
                                                                                "Live Exchange Rates",
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (item
                                                                            .navigation ==
                                                                        'wellness/meditation') {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              WebViewPage(
                                                                            url:
                                                                                "https://meditation-native.netlify.app/",
                                                                            title:
                                                                                "Meditation",
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (item
                                                                            .navigation ==
                                                                        'engage/live-radio') {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              WebViewPage(
                                                                            url:
                                                                                "https://b2microapps.netlify.app/radio",
                                                                            title:
                                                                                "Live Radio",
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (item
                                                                            .navigation ==
                                                                        'engage/live-news') {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              WebViewPage(
                                                                            url:
                                                                                "https://b2microapps.netlify.app/news",
                                                                            title:
                                                                                "Live News",
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (item
                                                                            .navigation ==
                                                                        'wellness/fitness') {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              WebViewPage(
                                                                            url:
                                                                                "https://b2microapps.netlify.app/workout",
                                                                            title:
                                                                                "Fitness",
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (item
                                                                            .navigation ==
                                                                        'travel') {
                                                                      /*EasyLoading.show(
                                                                          status:
                                                                              'Loading..');*/
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              WebViewPage(
                                                                            url:
                                                                                "https://asfartrip.com/en/affiliate-login?id=TVRrek56VT0=",
                                                                            title:
                                                                                'Travel',
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else if (item
                                                                            .navigation ==
                                                                        'play') {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              WebViewPage(
                                                                            url:
                                                                                "https://b2-games.vercel.app/",
                                                                            title:
                                                                                AppLocalizations.of(context)!.translate('play')!,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      EasyLoading.show(
                                                                          status:
                                                                              AppLocalizations.of(context)!.translate('please_wait')!);
                                                                      await getData(
                                                                              10)
                                                                          .then(
                                                                              (value) {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                ViewAllOffersScreen(
                                                                              10,
                                                                              categoryId: 54,
                                                                              //  filterBy: _name,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      });
                                                                    }
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5.0,
                                                                        right:
                                                                            5),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          12.r,
                                                                        ),
                                                                      ),
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      child: ClipRRect(
                                                                          borderRadius: BorderRadius.circular(12.r),
                                                                          child: //Image.asset("assets/images/banner_img.png",fit: BoxFit.cover,)
                                                                              CachedNetworkImage(
                                                                            imageUrl:
                                                                                item.imageLink!,
                                                                            errorWidget: (context, url, error) =>
                                                                                Center(
                                                                              child: Image.asset(
                                                                                'assets/images/not_found1.png',
                                                                                height: 100,
                                                                              ),
                                                                            ),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ))
                                                        .toList(),
                                                  ),
                                                  SizedBox(
                                                    height: 5.h,
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: i.homeBannerData
                                                          .asMap()
                                                          .entries
                                                          .map(
                                                        (entry) {
                                                          return GestureDetector(
                                                            onTap: () => _controller
                                                                .animateToPage(
                                                                    entry.key),
                                                            child: Container(
                                                              width: 15.w,
                                                              height: 7.h,
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: _current ==
                                                                        entry
                                                                            .key
                                                                    ? pink
                                                                    : Colors
                                                                        .grey,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ).toList(),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.red,
                                                ),
                                              );
                                      }),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .translate('our_products')!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        InkWell(
                                            onTap: () async {
                                              //Printy();
                                              EasyLoading.show(
                                                  status: AppLocalizations.of(
                                                          context)!
                                                      .translate(
                                                          'please_wait')!);
                                              await getData(10).then((value) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ViewAllOffersScreen(
                                                      10,
                                                    ),
                                                  ),
                                                );
                                              }); /*navigationService.navigateTo(ViewAllOffersScreenRoute));*/
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .translate('view_all')!,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    OffersListWidget(_offerList),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                  ],
                                ),
                                mainAxisSize: MainAxisSize.max,
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            // backgroundColor: Colors.grey,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                )
              : NoInternet());
    });
  }

  Future<void> getData(int perPage) async {
    await Provider.of<OffersProvider>(context, listen: false)
        .getOffers(perPage: perPage);
  }

  Future<void> setListData() async {
    await getData(4);
    _offersData =
        Provider.of<OffersProvider>(context, listen: false).offersData!;
    _offerList = _offersData.offers;
    // offerList.addAll(offersData.offers);
  }
}

// btn3(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         titlePadding: EdgeInsets.all(0),
//         title: Container(
//           height: 130.h,
//           width: 130.w,
//           child: Center(
//             child: Image.asset('assets/images/login_success.gif'),
//           ),
//         ),
//         content:
//             Text(AppLocalizations.of(context)!.translate('welcome_on_board')!),
//         actions: [
//           TextButton(
//             onPressed: () {
//               // Navigator.pop(context);
//             },
//             child: Text(
//               AppLocalizations.of(context)!.translate('ok')!,
//               style: TextStyle(
//                 color: Color(0xFF4A843E),
//               ),
//             ),
//           )
//         ],
//       );
//     },
//   );
// }

Widget tile({context, String? url, String? title, VoidCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        Image.asset(
          url!,
          height: MediaQuery.of(context).size.height * 0.075,
          //scale:2.6 //ScreenSize.categoryImage,
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          title!,
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.sp),
        )
      ],
    ),
  );
}
