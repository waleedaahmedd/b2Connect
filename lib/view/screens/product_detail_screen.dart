import 'dart:io';
import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/models/offers_models/product_details_model.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/choose_payment_plan_bottom_sheet.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view/widgets/no_internet.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:b2connect_flutter/view_model/providers/pay_by_provider.dart';
import 'package:b2connect_flutter/view_model/providers/wish_list_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity/connectivity.dart';

//import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

//import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:simple_html_css/simple_html_css.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html2md/html2md.dart' as html2md;

import '../../screen_size.dart';

//TODO: new installment 6x plan
class ProductDetailScreen extends StatefulWidget {
  final String? id;

  ProductDetailScreen({
    this.id,
  });

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  CarouselController _controller = CarouselController();
  NavigationService _navigationService = locator<NavigationService>();

  int _current = 0;
  bool? _like = false;
  bool _connectedToInternet = true;
  ProductDetailsModel? _productDetailsData;

  getData() async {
    Provider.of<OffersProvider>(context, listen: false).productDetailsData =
        null;
    Provider.of<OffersProvider>(context, listen: false).showLoader = null;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      await Provider.of<WishListProvider>(context, listen: false)
          .checkWishList(widget.id!)
          .then((value) async {
        await Provider.of<OffersProvider>(context, listen: false)
            .getProductDetails(widget.id!)
            .then((data) {
          _productDetailsData = data;
        });
        setState(() {
          _like = value;
        });
      });
    } else {
      setState(() {
        _connectedToInternet = false;
      });
    }
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Consumer<OffersProvider>(builder: (context, i, _) {
      return WillPopScope(
        onWillPop: () {
          removeItemFromCart(i, context);
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarWithBackIconAndLanguage(
              onTapIcon: () {
                removeItemFromCart(i, context);
                _navigationService.closeScreen();
              },
            ),
            body: _connectedToInternet
                ? _productDetailsData != null
                    ? Stack(
                        children: <Widget>[
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    Visibility(
                                      visible: _productDetailsData!
                                                  .offer.salePrice ==
                                              null
                                          ? false
                                          : true,
                                      child: Positioned(
                                          top: 0, left: 5, child: saleWidget()),
                                    ),
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
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                              vertical: 10.0, horizontal: 2.0),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: j == _current
                                                ? Color(0xFF40BFFF)
                                                : Color(0xFFEBF0FF),
                                          ),
                                        ),
                                    ]),
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
                                              fontWeight: FontWeight.w600),
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
                                                _productDetailsData!.offer.name,
                                                style: TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            InkWell(
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
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        size: 25.h,
                                                      )
                                                    : Icon(
                                                        Icons.favorite_border,
                                                        color: Colors.grey,
                                                        //Theme.of(context).indicatorColor,
                                                        size: 25.h,
                                                      )),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        RatingBar.builder(
                                          ignoreGestures: true,
                                          itemSize: 20.h,
                                          unratedColor: Color(0xFFEBF0FF),
                                          initialRating: 4.5,
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
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            // Text(
                                            //   "Smartphone",
                                            //   style: TextStyle(
                                            //       color: Colors.grey,
                                            //       fontSize: 10.sp,
                                            //       fontWeight: FontWeight.w600),
                                            // ),
                                            // SizedBox(
                                            //   width: 10.w,
                                            // ),
                                            // Text(
                                            //   "AED 10",
                                            //   style: TextStyle(
                                            //       color: Color.fromRGBO(254, 126, 118, 1),
                                            //       fontSize: 14.sp,
                                            //       fontWeight: FontWeight.w600),
                                            // ),

                                            Row(
                                              children: [
                                                Visibility(
                                                  visible: _productDetailsData!
                                                              .offer
                                                              .salePrice ==
                                                          null
                                                      ? false
                                                      : true,
                                                  child: Text(
                                                    'AED ${double.parse(_productDetailsData!.offer.regularPrice.toString())}0',
                                                    style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Colors.grey,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationColor:
                                                          Colors.grey.shade800,
                                                      decorationStyle:
                                                          TextDecorationStyle
                                                              .solid,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    removeItemFromCart(
                                                        i, context);
                                                    addProductToCart(i);
                                                    i.b2PayTag = false;
                                                  },
                                                  child: Text(
                                                    _productDetailsData!.offer
                                                                .salePrice !=
                                                            null
                                                        ? 'AED ${double.parse(_productDetailsData!.offer.salePrice.toString())}0'
                                                        : 'AED ${double.parse(_productDetailsData!.offer.regularPrice.toString())}0',
                                                    style: TextStyle(
                                                      fontSize: 19.sp,
                                                      color: priceColor,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            removeItemFromCart(i, context);
                                            addProductToCart(i);
                                          },
                                          child: Visibility(
                                            visible: _productDetailsData!
                                                        .offer.emiEnabled ==
                                                    false
                                                /*_productDetailsData!.offer.offerCategories[0].id == 54 ||
                                                    _productDetailsData!.offer.offerCategories[0].id == 458 ||
                                                        _productDetailsData!.offer.offerCategories[0].id == 118*/
                                                ? false
                                                : true,
                                            child: Container(
                                              height: 45.h,
                                              width: width,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFF6F6F6),
                                                borderRadius:
                                                    BorderRadius.circular(22),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10,
                                                    top: 8,
                                                    bottom: 5),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                'pay_as_low')!,
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                    Text(
                                                        //TODO: REMOVE 6X INSTALLMENT
                                                        'AED ${_productDetailsData!.offer.emiEnabled == true ? _productDetailsData!.offer.installmentPrices[1].monthlyPrice! == 0.0? _productDetailsData!.offer.installmentPrices[0].monthlyPrice!.toStringAsFixed(2):_productDetailsData!.offer.installmentPrices[1].monthlyPrice!.toStringAsFixed(2) : 0.0}',
                                                    //    'AED ${_productDetailsData!.offer.emiEnabled == true ? _productDetailsData!.offer.installmentPrices[0].monthlyPrice!.toStringAsFixed(2) : 0.0}',
                                                        //'AED ${_productDetailsData!.offer.emiEnabled == true ? _productDetailsData!.offer.installmentPrices.length == 2 ? _productDetailsData!.offer.installmentPrices[1].monthlyPrice!.toStringAsFixed(2) : _productDetailsData!.offer.installmentPrices[0].monthlyPrice!.toStringAsFixed(2) : 0.0}',
                                                        style: TextStyle(
                                                            color: priceColor,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                    Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .translate(
                                                                'per_month')!,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.020.h,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .translate('description')!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        ExpandableText(
                                          desc: _productDetailsData!
                                              .offer.shortText,
                                        ),
                                        _productDetailsData!
                                                .recommendations.isNotEmpty
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: height * 0.010.h,
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .translate('you_like')!,
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
                                                    height: height * 0.37,
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
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) => ProductDetailScreen(
                                                                                  id: _productDetailsData!.recommendations[index].id.toString(),
                                                                                )));
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
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width:
                                                                          150.w,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Visibility(
                                                                                visible: _productDetailsData!.recommendations[index].salePrice == null ? false : true,
                                                                                child: Center(
                                                                                  child: Container(
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
                                                                                        fontWeight: FontWeight.w600,
                                                                                      ),
                                                                                    ),
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
                                                                                      fontWeight: FontWeight.w600,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                            ],
                                                                          ),
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
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                ScreenSize.productCardTextWidth,
                                                                            //height: ,
                                                                            // height: 50.h,
                                                                            child:
                                                                                Text(
                                                                              _productDetailsData!.recommendations[index].name,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              maxLines: 3,
                                                                              style: TextStyle(
                                                                                fontSize: ScreenSize.productCardText,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Spacer(),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(bottom: 10.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Visibility(
                                                                                  visible: _productDetailsData!.recommendations[index].salePrice != null,
                                                                                  child: Text(
                                                                                    'AED ${_productDetailsData!.recommendations[index].regularPrice.toStringAsFixed(2)}',
                                                                                    style: TextStyle(
                                                                                      fontSize: ScreenSize.productCardPrice,
                                                                                      color: Colors.grey,
                                                                                      decoration: TextDecoration.lineThrough,
                                                                                      decorationColor: Colors.grey.shade800,
                                                                                      decorationStyle: TextDecorationStyle.solid,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 5.w,
                                                                                ),
                                                                                Text(
                                                                                  'AED ${_productDetailsData!.recommendations[index].salePrice == null ? _productDetailsData!.recommendations[index].regularPrice.toStringAsFixed(2) : _productDetailsData!.recommendations[index].salePrice.toStringAsFixed(2)}',
                                                                                  style: TextStyle(
                                                                                    fontSize: ScreenSize.productCardSalePrice,
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
                                                        }),
                                                  ),
                                                ],
                                              )
                                            : Text(' ')
                                      ]),
                                ),
                                SizedBox(
                                  height: 70,
                                )
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
                                          removeItemFromCart(i, context);
                                          addProductToCart(i);
                                        },
                                        width: double.infinity,
                                        height: 50.h,
                                        text: 'Proceed',
                                      ),
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
                      )
                /* },
                )*/
                : NoInternet()),
      );
    });
  }

  allReadyAdded(context, VoidCallback onTap) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      //transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 100,
            margin: EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Only one item can be added at a time'),
                  CustomButton(
                    height: 25.h,
                    width: 100,
                    text: "Ok",
                    onPressed: onTap,
                  ),
                ],
              ),
            ),
            //child: PhotoView(imageProvider: NetworkImage(url),backgroundDecoration: BoxDecoration(color: Colors.white))
          ),
        );
      },
    );
  }

  Future<void> addProductToCart(OffersProvider i) async {
    Provider.of<OffersProvider>(context, listen: false)
        .setComingFromCartIcon(false);
    if (_productDetailsData!.offer.stockStatus == "instock") {
      if (_productDetailsData!.offer.emiEnabled) {
        if (i.onlySmartPhone == false) {
          Provider.of<PayByProvider>(context, listen: false)
              .addToCartList(_productDetailsData!.offer.id);

          await i.set3xInstallmentPrice(
              _productDetailsData!.offer.installmentPrices[0].monthlyPrice!
                  .toDouble(),
              _productDetailsData!.offer.installmentPrices[0].monthlyPriceAddon!
                  .toDouble());
          await i.set6xInstallmentPrice(
              _productDetailsData!.offer.installmentPrices[1].monthlyPrice!
                  .toDouble(),
              _productDetailsData!.offer.installmentPrices[1].monthlyPriceAddon!
                  .toDouble());

          i.setOnlySmartPhone(true);
          i.saveTotalNow(_productDetailsData!.offer.salePrice == null
              ? _productDetailsData!.offer.regularPrice.toDouble()
              : _productDetailsData!.offer.salePrice.toDouble());
          i.updatedOfInstallmentPrice(
              _productDetailsData!.offer.installmentPrices[0].monthlyPrice!
                  .toDouble(),
              _productDetailsData!.offer.installmentPrices[1].monthlyPrice!
                  .toDouble(),
              _productDetailsData!.offer.installmentPrices[0].monthlyPriceAddon!
                  .toDouble(),
              _productDetailsData!.offer.installmentPrices[1].monthlyPriceAddon!
                  .toDouble());
          //  _navigationService.navigateTo(CartScreenRoute);
          WidgetsBinding.instance.addPostFrameCallback((_) =>
              _paymentPlanBottomSheet(
                  context,
                  Provider.of<OffersProvider>(context, listen: false)
                      .totalPriceNow /*,widget.totalPriceLater!*/));
        } else {
          allReadyAdded(context, () {
            _navigationService.closeScreen();
          });
        }
      } else {
        Provider.of<PayByProvider>(context, listen: false)
            .addToCartList(_productDetailsData!.offer.id);
        if (_productDetailsData!.offer.salePrice == null) {
          i.saveTotalNow(_productDetailsData!.offer.regularPrice.toDouble());
          i.addOtherProductsPriceWithEmiProduct(
              _productDetailsData!.offer.regularPrice.toDouble());
        } else {
          i.saveTotalNow(_productDetailsData!.offer.salePrice.toDouble());
          i.addOtherProductsPriceWithEmiProduct(
              _productDetailsData!.offer.salePrice.toDouble());
        }
        WidgetsBinding.instance.addPostFrameCallback((_) =>
            _paymentPlanBottomSheet(
                context,
                Provider.of<OffersProvider>(context, listen: false)
                    .totalPriceNow /*,widget.totalPriceLater!*/));
      }
    } else {}
  }
}

/*void addProductToCart(OffersProvider i) {
    Provider.of<OffersProvider>(context, listen: false)
        .setComingFromCartIcon(false);
    if (i.cartData.length == 1) {
      allReadyAdded(context, () {
        _navigationService.closeScreen();
      });
    } else {
      if (_productDetailsData!.offer.stockStatus == "instock") {
        if (_productDetailsData!.offer.emiEnabled) {
          if (i.onlySmartPhone == false) {
            Provider.of<PayByProvider>(context, listen: false)
                .addToCartList(_productDetailsData!.offer.id);
            i.saveTotalNow(_productDetailsData!.offer.salePrice.toDouble());
            i.calculate3xInstallmentPrice(
                _productDetailsData!.offer.regularPrice.toDouble());
            i.total3xInstallmentPrice(
                _productDetailsData!.offer.salePrice.toDouble(),
                _productDetailsData!.offer.regularPrice.toDouble());
            i.setOnlySmartPhone(true);
            Provider.of<OffersProvider>(context, listen: false)
                .setComingFromCartIcon(true);

            WidgetsBinding.instance!.addPostFrameCallback((_) =>
                _paymentPlanBottomSheet(
                    context,
                    Provider.of<OffersProvider>(context, listen: false)
                        .totalPriceNow */ /*,widget.totalPriceLater!*/ /*));
            // _navigationService.navigateTo(CartScreenRoute);
          } else {
            allReadyAdded(context, () {
              _navigationService.closeScreen();
            });
          }
        } else {
          Provider.of<PayByProvider>(context, listen: false)
              .addToCartList(_productDetailsData!.offer.id);
          if (_productDetailsData!.offer.salePrice == null) {
            i.saveTotalNow(_productDetailsData!.offer.regularPrice.toDouble());
            i.addOtherProductsPriceIn3xInstallmentPrice(
                _productDetailsData!.offer.regularPrice.toDouble());
          } else {
            i.saveTotalNow(_productDetailsData!.offer.salePrice.toDouble());
            i.addOtherProductsPriceIn3xInstallmentPrice(
                _productDetailsData!.offer.salePrice.toDouble());
          }
          Provider.of<OffersProvider>(context, listen: false)
              .setComingFromCartIcon(true);

          WidgetsBinding.instance!.addPostFrameCallback((_) =>
              _paymentPlanBottomSheet(
                  context,
                  Provider.of<OffersProvider>(context, listen: false)
                      .totalPriceNow */ /*,widget.totalPriceLater!*/ /*));
          //_navigationService.navigateTo(CartScreenRoute);
        }
      } else {}
    }
  }*/

void _paymentPlanBottomSheet(
    context, double totalPriceNow /*,double totalPriceLater*/) {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          topLeft: Radius.circular(30.0),
        ),
      ),
      context: context,
      builder: (BuildContext bc) {
        return Wrap(
          children: [
            ChoosePaymentPlanBottomSheet(
                totalPriceNow:
                    totalPriceNow /*,totalPriceLater: totalPriceLater,*/),
          ],
        );
      });
}

void removeItemFromCart(OffersProvider i, BuildContext context) {
  //i.cartData.clear();
  i.clearAllData();
  /* i.onlySmartPhone = false;
    i.totalPriceNow = 0.0;
    i.updatedThreeInstallmentPrice = 0.0;
    i.updatedSixInstallmentPrice = 0.0;
    i.updatedThreePriceAddon = 0.0;
    i.updatedSixPriceAddon = 0.0;
    i.threeInstallmentPrice = 0.0;
    i.sixInstallmentPrice = 0.0;*/
  Provider.of<PayByProvider>(context, listen: false).offerItemsOrder.clear();

  /*if (i.cartData[0].offer.installmentPrice == null) {
      i.onlySmartPhone = false;
      i.removeInstallmentPrice((i.cartData[0].offer.regularPrice.toDouble()));
      i.minusTotalNow(i.cartData[0].offer.salePrice.toDouble());
      i.b2PayTag = true;
    } else {
      final offerIndex = Provider.of<PayByProvider>(context,listen:false)
          .offerItemsOrder.indexWhere((offer) => offer.offerId == i.cartData[0].offer.id);
      i.cartData[0].offer.salePrice != null
          ? i.removeOtherProductsPriceInInstallmentPrice((i.cartData[0].offer.salePrice *
          Provider.of<PayByProvider>(context, listen: false).offerItemsOrder[offerIndex].amount!.toDouble()))
          : i.removeOtherProductsPriceInInstallmentPrice((i.cartData[0].offer.regularPrice *
          Provider.of<PayByProvider>(context, listen: false).offerItemsOrder[offerIndex].amount!.toDouble()));
      i.cartData[0].offer.salePrice != null
          ? i.minusTotalNow((i.cartData[0].offer.salePrice *
          Provider.of<PayByProvider>(context, listen: false).offerItemsOrder[offerIndex].amount!.toDouble()))
          : i.minusTotalNow((i.cartData[0].offer.regularPrice *
          Provider.of<PayByProvider>(context, listen: false).offerItemsOrder[offerIndex].amount!.toDouble()));
    }

    Provider.of<PayByProvider>(context,listen:false)
        .removeItemFromCart(i.cartData[0].offer.id);
    i.removeCartData(i.cartData[0].offer.id);*/
}

Widget checkOutBtn(context) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
          color: Color(0xFF757575), borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(
          AppLocalizations.of(context)!.translate('notify_arrival')!,
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

void showDialog1(context, String url) {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: Duration(milliseconds: 400),
    context: context,
    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.center,
        child: Container(
            height: 400,
            margin: EdgeInsets.only(left: 12, right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.clear)),
                Container(
                  height: 330,
                  child: PhotoView(
                      imageProvider: NetworkImage(url),
                      backgroundDecoration: BoxDecoration(color: Colors.white)),
                ),
              ],
            )),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(1, 0), end: Offset(0, 0)).animate(anim),
        //Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}

openWhatsapp(context, String name) async {
  var whatsapp = "+97148753894";
  var whatsappURlAndroid = "whatsapp://send?phone=" +
      whatsapp +
      "&text=Hello. I would like to be notified when $name is available";
  var whatappURLIos =
      "https://wa.me/$whatsapp?text=${Uri.parse("Hello. I would like to be notified when $name is available")}";
  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunch(whatappURLIos)) {
      await launch(whatappURLIos, forceSafariVC: false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
    }
  } else {
    // android , web
    if (await canLaunch(whatsappURlAndroid)) {
      await launch(whatsappURlAndroid);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
    }
  }
}

class ExpandableText extends StatefulWidget {
  //final Widget child;
  final String? desc;

  ExpandableText({Key? key, this.desc}) : super(key: key);

  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  //String descText = "Description Line 1\nDescription Line 2\nDescription Line 3\nDescription Line 4\nDescription Line 5\nDescription Line 6\nDescription Line 7\nDescription Line 8";
  bool descTextShowFlag = false;

  @override
  Widget build(BuildContext context) {
    //final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Container(
      //margin: EdgeInsets.all(16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          descTextShowFlag
              ? Container(
                  //height: 100,
                  width: width,
                  //color: Colors.red,
                  child: RichText(
                    text: HTML.toTextSpan(context, widget.desc!),
                    overflow: TextOverflow.clip,
                    //maxLines: 6,
                  ),
                )
              : Container(
                  //height: height*0.15,
                  width: width,
                  //color: Colors.red,
                  child: RichText(
                    text: HTML.toTextSpan(context, widget.desc!),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              setState(() {
                var html = '${widget.desc!}';
                print(html2md.convert(html));

                //print(HTML.toTextSpan(context, ).text);
                descTextShowFlag = !descTextShowFlag;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                descTextShowFlag
                    ? Text(
                        "Show Less",
                        style: TextStyle(color: pink),
                      )
                    : Text(
                        AppLocalizations.of(context)!.translate('show_more')!,
                        style: TextStyle(color: pink))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class saleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(left: 3.0),
        child: Container(
          height: 20,
          width: 50,
          decoration: BoxDecoration(
            gradient: gradientColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                20.r,
              ),
            ),
          ),
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.translate('sale')!,
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenSize.productContainerText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),

      // Container(
      //     height: 40,
      //     width: 100,
      //   //color: pink,
      //   decoration: BoxDecoration(
      //       //color: pink,
      //     image: DecorationImage(
      //     ),
      //     borderRadius: BorderRadius.only(
      //       bottomRight: Radius.circular(12),
      //       topRight: Radius.circular(12),
      //     )
      //   ),
      // ),
    ]);
  }
}
