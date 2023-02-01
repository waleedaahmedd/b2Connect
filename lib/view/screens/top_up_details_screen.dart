import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/models/offers_models/product_details_model.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/screens/product_detail_screen.dart';
import 'package:b2connect_flutter/view/widgets/appBar_with_cart_notification_widget.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view/widgets/no_internet.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:b2connect_flutter/view_model/providers/pay_by_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../screen_size.dart';

class TopUpDetailsScreen extends StatefulWidget {
  final String? id;

  TopUpDetailsScreen({
    this.id,
  });

  @override
  _TopUpDetailsScreenState createState() => _TopUpDetailsScreenState();
}

class _TopUpDetailsScreenState extends State<TopUpDetailsScreen> {
  NavigationService _navigationService = locator<NavigationService>();
  CarouselController _controller = CarouselController();

  int _current = 0;
  /* bool? _like = false;*/
  bool _connectedToInternet = true;
  ProductDetailsModel? _productDetailsData;

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithCartNotificationWidget(
          title: 'Top-Up',
          onTapIcon: () {
            Provider.of<PayByProvider>(context, listen: false).serviceItemsOrder.clear();
            navigationService.closeScreen();
          },
        ),
        body: _connectedToInternet
            ? Consumer<OffersProvider>(
          builder: (context, i, _) {
            return WillPopScope(
              onWillPop: () {
                Provider.of<PayByProvider>(context, listen: false).serviceItemsOrder.clear();
                navigationService.closeScreen();
                return Future.value(false);
              },
              child: _productDetailsData != null
                  ? Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisSize: MainAxisSize.max,
                      children: [
                        Stack(
                          children: [
                            CarouselSlider(
                              carouselController: _controller,
                              options: CarouselOptions(
                                  enableInfiniteScroll: false,
                                  height: height * 0.4,
                                  viewportFraction: 1.0,
                                  enlargeCenterPage: false,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  }
                                // autoPlay: true,

                              ),
                              items: _productDetailsData!.offer.images
                                  .map(
                                    (item) => InkWell(
                                  onTap: () {
                                    showDialog1(context, item);
                                  },
                                  child: CachedNetworkImage(
                                    imageUrl: item,
                                    // placeholder: (context, url) => Image.asset(
                                    //   'assets/images/placeholder1.png',
                                    // ),
                                    errorWidget:
                                        (context, url, error) =>
                                        Center(
                                          child: Image.asset(
                                            'assets/images/not_found1.png',
                                            height: 100,
                                          ),
                                        ),
                                  ),
                                  //Image.network(item, fit: BoxFit.fill)
                                ),
                              )
                                  .toList(),

                              //PhotoView(imageProvider: NetworkImage(item, ))
                            ),
                            /* Visibility(
                                          visible: _productDetailsData!
                                                      .offer.salePrice ==
                                                  null
                                              ? false
                                              : true,
                                          child: Positioned(
                                              top: 0,
                                              left: 5,
                                              child: saleWidget()),
                                        ),*/
                            Visibility(
                              visible: _productDetailsData!
                                  .offer.stockStatus ==
                                  "instock"
                                  ? false
                                  : true,
                              child: Positioned(
                                top: height * 0.16,
                                left: height * 0.16,
                                child: Card(
                                  // height: 30.h,
                                  // width: 50.w,
                                  color: Colors.grey.shade200,
                                  elevation: 5,
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                      8.h,
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .translate('out_of_stock')!,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: pink,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        /* Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          for (int j = 0;
                                              j <
                                                  _productDetailsData!
                                                      .offer.images.length;
                                              j++)
                                            Container(
                                              width: 8.0,
                                              height: 8.0,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10.0,
                                                  horizontal: 2.0),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: j == _current
                                                    ? Color(0xFF40BFFF)
                                                    : Color(0xFFEBF0FF),
                                              ),
                                            ),
                                        ]),
                                    SizedBox(
                                      height: 20,
                                    ),*/
                        Container(
                          padding: EdgeInsets.all(10.h),
                          child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _productDetailsData!
                                      .offer.offerCategories[0].name,
                                  style: TextStyle(
                                      color: Color(0xFF9098B1),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 250.w,
                                      child: Text(
                                        _productDetailsData!
                                            .offer.name,
                                        style: TextStyle(
                                            color: Color(0xFF000000),
                                            fontSize: 18.sp,
                                            fontWeight:
                                            FontWeight.bold),
                                      ),
                                    ),
                                    /* InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        if (_like == false) {
                                                          Provider.of<WishListProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .showLoader = null;
                                                          Provider.of<WishListProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .addToWishList(
                                                                  _productDetailsData!
                                                                      .offer.id
                                                                      .toString());
                                                        }

                                                        if (_like == true) {
                                                          Provider.of<WishListProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .setLoader(true);
                                                          Provider.of<WishListProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .removeFromWishList(
                                                                  _productDetailsData!
                                                                      .offer.id);
                                                          Provider.of<WishListProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .deleteFromWishList(
                                                                  _productDetailsData!
                                                                      .offer.id
                                                                      .toString());
                                                        }
                                                        _like = !_like!;
                                                      });
                                                    },
                                                    child: _like!
                                                        ? Icon(
                                                            Icons.favorite,
                                                            color:
                                                                Theme.of(context)
                                                                    .primaryColor,
                                                            size: 25.h,
                                                          )
                                                        : Icon(
                                                            Icons.favorite_border,
                                                            color: Colors.grey,
                                                            //Theme.of(context).indicatorColor,
                                                            size: 25.h,
                                                          )),*/
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                /*RatingBar.builder(
                                              itemSize: 20.h,
                                              unratedColor: Color(0xFFEBF0FF),
                                              initialRating: 4,
                                              minRating: 0,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Color(0xFFFFC833),
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),*/
                                Visibility(
                                  visible: _productDetailsData!.offer.shortText.isNotEmpty,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .translate('description')!,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      ExpandableText(
                                        desc: _productDetailsData!
                                            .offer.shortText.toString(),
                                      ),
                                    ],
                                  ),
                                ),

                              ]),
                        ),
                        _productDetailsData!
                            .recommendations.isNotEmpty
                            ? Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0 , top: 0 , bottom: 80.0),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.010.h,
                              ),
                              Text(
                                AppLocalizations.of(
                                    context)!
                                    .translate(
                                    'you_like')!,
                                style: TextStyle(
                                    color:
                                    Color(0xFF223263),
                                    fontSize: 16.sp,
                                    fontWeight:
                                    FontWeight.bold),
                              ),
                              SizedBox(
                                height: height * 0.020.h,
                              ),
                              Container(
                                height: 260,
                                width: double.infinity,
                                //color: Colors.red,
                                child: ListView.builder(
                                  //shrinkWrap: true,
                                    scrollDirection:
                                    Axis.horizontal,
                                    itemCount:
                                    _productDetailsData!
                                        .recommendations
                                        .length,
                                    itemBuilder:
                                        (context, index) {
                                      return AnimationConfiguration
                                          .staggeredGrid(
                                        columnCount: 2,
                                        position: index,
                                        duration:
                                        const Duration(
                                            milliseconds:
                                            1000),
                                        child:
                                        ScaleAnimation(
                                          scale: 1,
                                          child:
                                          FlipAnimation(
                                            child:
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => TopUpDetailsScreen(
                                                          id: _productDetailsData!.recommendations[index].id.toString(),
                                                        )));
                                                //Provider.of<OffersProvider>(context,listen: false).productDetailsData=null;
                                              },
                                              child: Card(
                                                elevation:
                                                0,
                                                shape:
                                                RoundedRectangleBorder(
                                                  side:
                                                  BorderSide(
                                                    color: Colors
                                                        .grey
                                                        .shade300,
                                                    width:
                                                    1.w,
                                                  ),
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                ),
                                                child:
                                                Container(
                                                  width:
                                                  150.w,
                                                  padding:
                                                  EdgeInsets.all(8),
                                                  child:
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    mainAxisSize:
                                                    MainAxisSize.max,
                                                    children: [
                                                      /*Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        decoration: BoxDecoration(
                                                                          gradient: gradientColor,
                                                                          borderRadius: BorderRadius.all(
                                                                            Radius.circular(
                                                                              20.r,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        padding: EdgeInsets.only(
                                                                          left: 9.w,
                                                                          top: 1.h,
                                                                          bottom: 1.h,
                                                                          right: 9.w,
                                                                        ),
                                                                        child: Text(
                                                                          AppLocalizations.of(context)!.translate('sale')!,
                                                                          style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: ScreenSize.productContainerText,
                                                                            fontWeight: FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.star,
                                                                            size: ScreenSize.productIcon,
                                                                            color: Colors.yellowAccent.shade700,
                                                                          ),
                                                                          Text(
                                                                            " 4.5",
                                                                            style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: ScreenSize.productRate,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),*/
                                                      Center(
                                                        child: _productDetailsData!.recommendations[index].images.isNotEmpty
                                                            ? CachedNetworkImage(
                                                          imageUrl: _productDetailsData!.recommendations[index].images[0],
                                                          placeholder: (context, url) => Image.asset(
                                                            'assets/images/placeholder1.png',
                                                          ),
                                                          errorWidget: (context, url, error) => Center(
                                                            child: Image.asset(
                                                              'assets/images/not_found1.png',
                                                              height: height * 0.175,
                                                            ),
                                                          ),
                                                        )
                                                            : Image.asset(
                                                          'assets/images/not_found1.png',
                                                          height: height * 0.175,
                                                        ),
                                                        // FadeInImage(
                                                        //   image: NetworkImage(productDetailsData!.recommendations[index].images[0]),
                                                        //   placeholder: AssetImage(
                                                        //     'assets/images/placeholder1.png',
                                                        //   ),
                                                        //   imageErrorBuilder: (context,i,_)=>Center(
                                                        //     child: Image.asset(
                                                        //       'assets/images/not_found1.png',
                                                        //       height: 100,
                                                        //     ),
                                                        //   ),
                                                        //
                                                        //   fit: BoxFit.fill,
                                                        // ),
                                                        // Image.network(
                                                        //   productDetailsData!.recommendations[i].images[0],
                                                        //   scale: ScreenSize.productCardImage,
                                                        // ),
                                                      ),
                                                      Container(
                                                        width: ScreenSize.productCardTextWidth,
                                                        //height: ,
                                                        // height: 50.h,
                                                        child: Text(
                                                          _productDetailsData!.recommendations[index].name,
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 3,
                                                          style: TextStyle(
                                                            fontSize: ScreenSize.productCardText,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(bottom: 10.0),
                                                        child: Row(
                                                          children: [
                                                            /* Text(
                                                                          'AED ${_productDetailsData!.recommendations[index].regularPrice.toStringAsFixed(2)}',
                                                                          style: TextStyle(
                                                                            fontSize:ScreenSize.productCardPrice,
                                                                            color: Colors.grey,
                                                                            decoration: TextDecoration.lineThrough,
                                                                            decorationColor: Colors.grey.shade800,
                                                                            decorationStyle: TextDecorationStyle.solid,
                                                                          ),
                                                                        ),*/
                                                            SizedBox(
                                                              width: 5.w,
                                                            ),
                                                            Text(
                                                              'AED ${_productDetailsData!.recommendations[index].regularPrice.toStringAsFixed(2)}',
                                                              style: TextStyle(
                                                                fontSize:ScreenSize.productCardSalePrice,
                                                                color: priceColor,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );

                                      //   Card(
                                      //   elevation: 2,
                                      //   child: Container(
                                      //     width: 150.w,
                                      //     padding: EdgeInsets.all(10.h),
                                      //     child: Column(
                                      //       crossAxisAlignment: CrossAxisAlignment.start,
                                      //       children: [
                                      //         Center(
                                      //           child: Image.network(
                                      //             productDetailsData!.recommendations[i].images[0],
                                      //             width: 100.h,
                                      //             height: 100.h,
                                      //             fit: BoxFit.contain,
                                      //           ),
                                      //         ),
                                      //         SizedBox(
                                      //           height: height * 0.020.h,
                                      //         ),
                                      //         Container(
                                      //           width: 120.w,
                                      //           child: Text(
                                      //             productDetailsData!.recommendations[i].name,
                                      //             overflow: TextOverflow.ellipsis,
                                      //             maxLines: 3,
                                      //             style: TextStyle(
                                      //                 color: Colors.black,
                                      //                 fontSize: 12.sp,
                                      //                 fontWeight: FontWeight.bold),
                                      //           ),
                                      //         ),
                                      //         SizedBox(
                                      //           height: height * 0.020.h,
                                      //         ),
                                      //         Row(
                                      //           children: [
                                      //             Text(
                                      //               'AED ${productDetailsData!.recommendations[i].regularPrice}',
                                      //               style: TextStyle(
                                      //                 fontSize: 13.sp,
                                      //                 color: Colors.grey,
                                      //                 decoration: TextDecoration.lineThrough,
                                      //                 decorationColor: Colors.grey.shade800,
                                      //                 decorationStyle: TextDecorationStyle.solid,
                                      //               ),
                                      //             ),
                                      //             SizedBox(
                                      //               width: 5.w,
                                      //             ),
                                      //             Text(
                                      //               'AED ${productDetailsData!.recommendations[i].salePrice}',
                                      //               style: TextStyle(
                                      //                 fontSize: 13.sp,
                                      //                 color: Colors.red,
                                      //                 fontWeight: FontWeight.w400,
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //
                                      //         // Row(
                                      //         //   children: [
                                      //         //     Text(
                                      //         //       "AED 10",
                                      //         //       style: TextStyle(
                                      //         //           color: Colors.grey,
                                      //         //           fontSize: 9.sp,
                                      //         //           fontWeight: FontWeight.w500),
                                      //         //     ),
                                      //         //     SizedBox(
                                      //         //       width: 5.w,
                                      //         //     ),
                                      //         //     Text(
                                      //         //       "AED 10",
                                      //         //       style: TextStyle(
                                      //         //           color: Color.fromRGBO(
                                      //         //               254, 126, 118, 1),
                                      //         //           fontSize: 14.sp,
                                      //         //           fontWeight: FontWeight.w600),
                                      //         //     ),
                                      //         //   ],
                                      //         // ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // );
                                    }),
                              ),
                              /*  SizedBox(
                                            height: 80,
                                          )*/
                            ],
                          ),
                        )
                            : Text(' ')
                        /*  SizedBox(
                                      height: 70,
                                    ),*/
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: _productDetailsData!.offer.stockStatus ==
                          "instock"
                          ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CustomButton(
                            onPressed: () async {

                              /*  Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => EditNumberTopUpScreen(
                                                        _productDetailsData,
                                                      )),
                                                );*/
                              // navigationService.navigateTo(TopUpScreenRoute);
                              payNow();
                            },
                            width: double.infinity,
                            height: 50.h,
                            text: "Pay Now"),
                      )
                          : InkWell(
                          onTap: () {
                            openWhatsapp(context,
                                _productDetailsData!.offer.name);
                          },
                          child: checkOutBtn(context)),
                    ),
                  ),
                ],
              )
                  : Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              ),
            );
          },
        )
            : NoInternet());
  }

  getData() async {
    Provider.of<OffersProvider>(context, listen: false).productDetailsData =
    null;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      /* await Provider.of<WishListProvider>(context, listen: false)
          .checkWishList(widget.id!)
          .then((value) async {*/
      /*   setState(() {
          _like = value;
        });*/
      Provider.of<PayByProvider>(context, listen: false)
          .serviceItemsOrder.clear();
      // i.serviceItemsOrder.clear();

      await Provider.of<OffersProvider>(context, listen: false)
          .getProductDetails(widget.id!)
          .then((value) {
        _productDetailsData = value;
      });
      /*   });*/
    } else {
      setState(() {
        _connectedToInternet = false;
      });
    }
  }

  Future<void> payNow() async {
    EasyLoading.show(
        status: AppLocalizations.of(context)!.translate('please_wait')!);
    await Provider.of<PayByProvider>(context, listen: false).getPayByDeviceId();
    await Provider.of<PayByProvider>(context, listen: false)
        .addServicesToOfferItems(_productDetailsData!.offer.id);
    await Provider.of<PayByProvider>(context, listen: false)
        .payByServiceOrder(context);
  }
}
