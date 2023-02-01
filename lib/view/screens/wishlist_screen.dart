import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/screen_size.dart';
import 'package:b2connect_flutter/view/screens/product_detail_screen.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/empty_cart.dart';
import 'package:b2connect_flutter/view/widgets/no_internet.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:b2connect_flutter/view_model/providers/wish_list_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';

//import 'package:b2connect_flutter/view/widgets/offers_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  //List<OffersList> wishListData = [];
  bool _connectedToInternet = true;
  // bool? _showLoader;
  NavigationService _navigationService = locator<NavigationService>();

  getData() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Future.delayed(Duration.zero, () async {
        await Provider.of<WishListProvider>(context, listen: false).showWishList().then((value) {
          if (value == "Failed") {
            setState(() {
              Provider.of<WishListProvider>(context, listen: false).setLoader(true);
            });
          }
        });
      });
    } else {
      setState(() {
        _connectedToInternet = false;
      });
      //utilsService.showToast("Sorry! but you don't seem to connected to any internet connection");
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWithBackIconAndLanguage(
        onTapIcon: () {
          _navigationService.closeScreen();
        },
      ),
      body: _connectedToInternet
          ? Consumer<WishListProvider>(builder: (context, i, _) {
        return i.wishListData.isNotEmpty
            ? SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              top: 10.h,
              bottom: 10.h,
              right: 10.w,
              left: 10.w,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.translate('wishlist')!,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      //height: 1.1.h,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),

                  //WishListWidget(i.wishListData)

                  AnimationLimiter(
                    child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        addRepaintBoundaries: false,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: i.wishListData.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: (4.0.h),
                          crossAxisSpacing: (4.0.w),
                          childAspectRatio:
                          ScreenSize.productCardWidth /
                              ScreenSize.productCardHeight,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return AnimationConfiguration
                              .staggeredGrid(
                            columnCount: 2,
                            position: index,
                            duration:
                            const Duration(milliseconds: 1000),
                            child: ScaleAnimation(
                              scale: 1,
                              child: FlipAnimation(
                                child: GestureDetector(
                                  onTap: () {
                                    //abcdef
                                    //Provider.of<OffersProvider>(context,listen: false).productDetailsData=null;
                                    Provider.of<OffersProvider>(context, listen: false)
                                        .setComingFromCartIcon(false); 
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailScreen(
                                                id: i
                                                    .wishListData[
                                                index]
                                                    .id
                                                    .toString(),
                                              )),
                                    );
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => abcdef()),
                                    // );
                                  },
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 1.w,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 8,
                                          right: 8,
                                          top: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .center,
                                        mainAxisSize:
                                        MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              //TODO: CART WORK
                                              Container(),
                                             /* Visibility(
                                                visible: i.wishListData[index].stockStatus! == "instock"
                                                ,child: InkWell(
                                                    onTap: () {
                                                      if (i
                                                          .wishListData[
                                                      index]
                                                          .offerCategories![
                                                      0]
                                                          .slug ==
                                                          "smart-phones") {
                                                        if (Provider.of<OffersProvider>(
                                                            context,
                                                            listen: false)
                                                            .onlySmartPhone ==
                                                            false) {
                                                          Provider.of<PayByProvider>(context,listen: false).addToCartList(i.wishListData[index].id!);

                                                          //productIds.add(productDetailsData!.offer.id);
                                                          Provider.of<OffersProvider>(
                                                              context,
                                                              listen:
                                                              false)
                                                              .saveTotalNow(i
                                                              .wishListData[index]
                                                              .salePrice!
                                                              .toDouble());
                                                          *//* Provider.of<OffersProvider>(
                                                                              context,
                                                                              listen:
                                                                                  false)
                                                                          .saveTotalLater(i
                                                                              .wishListData[index]
                                                                              .regularPrice!
                                                                             .toDouble());*//*
//TODO: new installment 6x plan

                                                          *//*Provider.of<OffersProvider>(
                                                              context,
                                                              listen:
                                                              false).calculate3xInstallmentPrice(
                                                              i
                                                                  .wishListData[index]
                                                                  .regularPrice!
                                                                  .toDouble());
                                                          Provider.of<OffersProvider>(
                                                              context,
                                                              listen:
                                                              false).total3xInstallmentPrice( i
                                                              .wishListData[index]
                                                              .salePrice!
                                                              .toDouble(), i
                                                              .wishListData[index]
                                                              .regularPrice!
                                                              .toDouble());*//*
                                                          Provider.of<OffersProvider>(
                                                              context,
                                                              listen:
                                                              false)
                                                              .onlySmartPhone = true;
                                                          _navigationService
                                                              .navigateTo(
                                                              CartScreenRoute);
                                                        } else {
                                                          allReadyAdded(
                                                              context,
                                                                  () {
                                                                _navigationService
                                                                    .closeScreen();
                                                              });
                                                        }
                                                      } else {
                                                        Provider.of<PayByProvider>(context,listen: false).addToCartList(i.wishListData[index].id!);

                                                        // productIds.add(productDetailsData!.offer.id);
                                                        Provider.of<OffersProvider>(
                                                            context,
                                                            listen:
                                                            false)
                                                            .saveTotalNow(i
                                                            .wishListData[
                                                        index]
                                                            .salePrice!
                                                            .toDouble());
                                                        *//* Provider.of<OffersProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .saveTotalLater(i
                                                                            .wishListData[
                                                                                index]
                                                                            .regularPrice!
                                                                            .toDouble());*//*
                                                        *//*  Provider.of<OffersProvider>(
                                                                         context,
                                                                         listen:
                                                                         false).updationOfInstallmentPrice();*//*
                                                        _navigationService
                                                            .navigateTo(
                                                            CartScreenRoute);
                                                      }

                                                      // Provider.of<OffersProvider>(context,listen: false).addToCartList(i.wishListData[index].id!); //productIds.add(productDetailsData!.offer.id);
                                                      // Provider.of<OffersProvider>(context,listen: false).saveTotal(i.wishListData[index].salePrice!.toDouble());
                                                      //
                                                      // navigationService.navigateTo(CartScreenRoute);
                                                    },
                                                    child: Icon(Icons
                                                        .shopping_cart_outlined)),
                                              ),*/
                                              InkWell(
                                                  onTap: () {
                                                    // setState(() {
                                                    //   _showLoader = true;
                                                    // });
                                                    Provider.of<WishListProvider>(context, listen: false).setLoader(true);
                                                    Provider.of<WishListProvider>(context, listen: false).deleteFromWishList(i.wishListData[index].id!.toString());
                                                    Provider.of<WishListProvider>(context, listen: false).removeFromWishList(i.wishListData[index].id!);
                                                  },
                                                  child: Icon(
                                                    Icons.clear,
                                                    size: 20,
                                                  ))
                                            ],
                                          ),
                                          Container(
                                            height: 150,
                                            child: Stack(
                                              children: [
                                                CachedNetworkImage(
                                                  imageUrl: i
                                                      .wishListData[
                                                  index]
                                                      .images!
                                                      .first,
                                                  placeholder:
                                                      (context,
                                                      url) =>
                                                      Image
                                                          .asset(
                                                        'assets/images/placeholder1.png',
                                                      ),
                                                  errorWidget:
                                                      (context, url,
                                                      error) =>
                                                      Center(
                                                        child:
                                                        Image.asset(
                                                          'assets/images/not_found1.png',
                                                          height: 100,
                                                        ),
                                                      ),
                                                  fit: BoxFit.fill,
                                                ),

                                                // FadeInImage(
                                                //   image: NetworkImage(i.wishListData[index].images!.first),
                                                //   placeholder: AssetImage(
                                                //     'assets/images/placeholder1.png',
                                                //   ),
                                                //
                                                //   fit: BoxFit.fill,
                                                // ),
                                                Visibility(
                                                  visible: i.wishListData[index]
                                                      .stockStatus! ==
                                                      "instock"
                                                      ? false
                                                      : true,
                                                  child: Center(
                                                    child: Card(
                                                      color: Colors
                                                          .white,
                                                      elevation: 5,
                                                      child:
                                                      Padding(
                                                        padding:
                                                        EdgeInsets
                                                            .all(
                                                          8.h,
                                                        ),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                              context)!
                                                              .translate(
                                                              'out_of_stock')!,
                                                          style:
                                                          TextStyle(
                                                            fontSize:
                                                            14.sp,
                                                            color: Theme.of(context)
                                                                .primaryColor,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            //width: ScreenSize.productCardTextWidth,
                                            height: 50.h,
                                            //color: Colors.red,
                                            child: Text(
                                              i.wishListData[index]
                                                  .name
                                                  .toString(),
                                              overflow: TextOverflow
                                                  .ellipsis,
                                              maxLines: 3,
                                              style: TextStyle(
                                                fontSize: ScreenSize
                                                    .productCardText,
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            //color: Colors.green,
                                            child: Row(
                                              children: [
                                                Visibility(
                                                  visible:
                                                  i.wishListData[index]
                                                      .salePrice ==
                                                      null
                                                      ? false
                                                      : true,
                                                  child: Text(
                                                    'AED ${i.wishListData[index].regularPrice!.toStringAsFixed(2)}',
                                                    style:
                                                    TextStyle(
                                                      fontSize:
                                                      ScreenSize
                                                          .productCardPrice,
                                                      color: Colors
                                                          .grey,
                                                      decoration:
                                                      TextDecoration
                                                          .lineThrough,
                                                      decorationColor:
                                                      Colors
                                                          .grey
                                                          .shade800,
                                                      decorationStyle:
                                                      TextDecorationStyle
                                                          .solid,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                Text(
                                                  i.wishListData[index]
                                                      .salePrice ==
                                                      null
                                                      ? 'AED ${i.wishListData[index].regularPrice!.toStringAsFixed(2)}'
                                                      : 'AED ${i.wishListData[index].salePrice!.toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                    fontSize: ScreenSize
                                                        .productCardSalePrice,
                                                    color: priceColor,
                                                    fontWeight:
                                                    FontWeight
                                                        .w700,
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
                  )
                ]),
          ),
        )
            : i.showLoader == null
            ? Center(
          child: CircularProgressIndicator(
            color: Colors.red,

          ),
        )
            : EmptyCart(
          name: AppLocalizations.of(context)!.translate('wishlist')!,
          desc: AppLocalizations.of(context)!.translate('no_items_in_wishlist')!,
          showButton: false,
        );
      })
          : NoInternet(),
    );
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Smart Phone is already in Cart'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Ok',
                                style: TextStyle(color: Colors.blue),
                              )),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          // InkWell(
                          //     onTap: onTap,
                          //     child: Text(
                          //       '0k',
                          //       style: TextStyle(color: Colors.blue),
                          //     )),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            //child: PhotoView(imageProvider: NetworkImage(url),backgroundDecoration: BoxDecoration(color: Colors.white))
          ),
        );
      },
    );
  }

}

Widget noDataInWishList() {
  return Container(
    child: Center(
      child: Text('no Data'),
    ),
  );
}