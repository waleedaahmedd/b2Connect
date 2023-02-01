import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/view/screens/product_detail_screen.dart';
import 'package:b2connect_flutter/view/screens/view_all_offers_screen.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/gradiant_color_button.dart';
import 'package:b2connect_flutter/view/widgets/custom_buttons/tinted_color_button.dart';
import 'package:b2connect_flutter/view/widgets/empty_cart.dart';
import 'package:b2connect_flutter/view/widgets/inc_dec_button.dart';
import 'package:b2connect_flutter/view/widgets/showOnWillPop.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:b2connect_flutter/view_model/providers/pay_by_provider.dart';
import 'package:b2connect_flutter/view_model/providers/wish_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../model/locale/app_localization.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  //List<ProductDetailsModel> cartData=[];
  //double? totalPrice = 0.0;

  //NavigationService navigationService = locator<NavigationService>();

  //bool? _showLoader;
  bool _hideShow = false;

  getData() async {
    Provider.of<OffersProvider>(context, listen: false).cartData.clear();

    if (Provider.of<PayByProvider>(context, listen: false)
        .offerItemsOrder
        .isNotEmpty) {
      Provider.of<PayByProvider>(context, listen: false)
          .offerItemsOrder.toSet().toList().forEach((element) async {
        //   print('id after filter--$element');

        await Provider.of<OffersProvider>(context, listen: false)
            .getProductDetails(element.offerId.toString())
            .then((value) {
          setState(() {
            Provider.of<OffersProvider>(context, listen: false)
                .cartData
                .add(value!);
          });
        });
      });
    } else {
      print('get into empty');
      //setState(() {
      Provider.of<OffersProvider>(context, listen: false).showLoader = true;
      // });
    }
  }

  @override
  void initState() {
    super.initState();

    Provider.of<OffersProvider>(context, listen: false).showLoader = null;

    getData();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithBackIconAndLanguage(
          onTapIcon: () {
            Provider.of<OffersProvider>(context, listen: false)
                .setComingFromCartIcon(true);
            Navigator.pop(context);
          },
        ),
        body: Consumer<OffersProvider>(builder: (context, i, _) {
          return WillPopScope(
            onWillPop: () {
              Provider.of<OffersProvider>(context, listen: false)
                  .setComingFromCartIcon(true);
              Navigator.pop(context, false);
              return Future.value(false);
            },
            child: i.cartData.isNotEmpty
                ? Container(
              padding: EdgeInsets.all(15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${AppLocalizations.of(context)!.translate('cart')!} (${Provider.of<PayByProvider>(context, listen: false).totalCartCount})",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 34.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: _hideShow
                          ? ScrollPhysics()
                          : NeverScrollableScrollPhysics(),
                      //scrollDirection: ,
                      shrinkWrap: true,
                      itemCount: i.cartData.length,
                      itemBuilder: (context, index) {
                        final offerIndex = Provider.of<PayByProvider>(context,listen: false)
                            .offerItemsOrder.indexWhere((element) => element.offerId ==
                            i.cartData[index].offer.id);
                        int? quantity = Provider.of<PayByProvider>(context,
                            listen: false).offerItemsOrder[offerIndex].amount /*where((e) => e.offerId == i.cartData[index].offer.id).length*/;
                        return Column(
                          children: [
                            Container(
                              // height: height * 0.25,
                                width: width,
                                decoration: BoxDecoration(
                                  //color: Colors.yellow,
                                    border: Border.all(
                                        color: Colors.grey[200]!),
                                    borderRadius:
                                    BorderRadius.circular(12)),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailScreen(
                                                      id: i.cartData[index]
                                                          .offer.id
                                                          .toString(),
                                                    )));
                                      },
                                      child: Container(
                                          width: width * 0.180,
                                          child: FadeInImage(
                                            image: NetworkImage(
                                              i.cartData[index].offer
                                                  .images[0],
                                            ),
                                            placeholder: AssetImage(
                                                'assets/images/placeholder1.png'),
                                            imageErrorBuilder:
                                                (context, i, _) => Center(
                                              child: Image.asset(
                                                'assets/images/not_found1.png',
                                                // height: 100,
                                              ),
                                            ),
                                            //fit: BoxFit.contain,
                                          )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5.0, top: 5, bottom: 5),
                                      child: Container(
                                        width: width * 0.7,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Container(
                                              // width: width*0.7,

                                              // color:Colors.green,
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                  ProductDetailScreen(
                                                                    id: i.cartData[index].offer.id.toString(),
                                                                  )));
                                                    },
                                                    child: Container(
                                                      width: width * 0.5,
                                                      height: 40.h,
                                                      //color: Colors.green,
                                                      child: Text(
                                                        i.cartData[index].offer.name,
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                            fontSize: 13.sp,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                      ),
                                                    ),
                                                  ),

                                                  // ToggleButton(
                                                  //   id: cartData[index].offer.id.toString(),
                                                  //   like:fal!,
                                                  //
                                                  // ),
                                                  InkWell(
                                                    onTap: () {
                                                      //setState(() {
                                                      if (i.cartData
                                                          .length >
                                                          1) {
                                                        if (i.cartData[index].offer.emiEnabled) {
                                                          i.onlySmartPhone = false;
                                                          i.remove3xInstallmentPrice((i.cartData[index].offer
                                                              .installmentPrices[0].monthlyPrice!), (i.cartData[index]
                                                              .offer.installmentPrices[0].monthlyPriceAddon!));
                                                          i.remove6xInstallmentPrice((i.cartData[index]
                                                              .offer.installmentPrices[1].monthlyPrice!), (i.cartData[index]
                                                              .offer.installmentPrices[1].monthlyPriceAddon!));
                                                          i.minusTotalNow(i.cartData[index].offer.salePrice == null?
                                                          i.cartData[index].offer.regularPrice.toDouble():
                                                          i.cartData[index].offer.salePrice.toDouble());
                                                          i.b2PayTag = true;
                                                        } else {
                                                          final offerIndex = Provider.of<
                                                              PayByProvider>(
                                                              context,
                                                              listen:
                                                              false)
                                                              .offerItemsOrder
                                                              .indexWhere((offer) =>
                                                          offer
                                                              .offerId ==
                                                              i
                                                                  .cartData[
                                                              index]
                                                                  .offer
                                                                  .id);
                                                          i.cartData[index]
                                                              .offer.salePrice !=
                                                              null
                                                              ? i.removeOtherProductsPriceWithEmiProduct((i
                                                              .cartData[
                                                          index]
                                                              .offer
                                                              .salePrice *
                                                              Provider.of<PayByProvider>(context, listen: false)
                                                                  .offerItemsOrder[
                                                              offerIndex]
                                                                  .amount!
                                                                  .toDouble()))
                                                              : i.removeOtherProductsPriceWithEmiProduct((i
                                                              .cartData[
                                                          index]
                                                              .offer
                                                              .regularPrice *
                                                              Provider.of<PayByProvider>(context, listen: false)
                                                                  .offerItemsOrder[offerIndex]
                                                                  .amount!
                                                                  .toDouble()));
                                                          i.cartData[index]
                                                              .offer.salePrice !=
                                                              null
                                                              ? i.minusTotalNow((i
                                                              .cartData[
                                                          index]
                                                              .offer
                                                              .salePrice *
                                                              Provider.of<PayByProvider>(context, listen: false)
                                                                  .offerItemsOrder[
                                                              offerIndex]
                                                                  .amount!
                                                                  .toDouble()))
                                                              : i.minusTotalNow((i
                                                              .cartData[
                                                          index]
                                                              .offer
                                                              .regularPrice *
                                                              Provider.of<PayByProvider>(context, listen: false)
                                                                  .offerItemsOrder[offerIndex]
                                                                  .amount!
                                                                  .toDouble()));
                                                        }

                                                        Provider.of<PayByProvider>(
                                                            context,
                                                            listen:
                                                            false)
                                                            .removeItemFromCart(i
                                                            .cartData[
                                                        index]
                                                            .offer
                                                            .id);
                                                        i.removeCartData(i
                                                            .cartData[index]
                                                            .offer
                                                            .id);

                                                        //cartData1=cartData.toSet().toList();
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                    CartScreen()));
                                                      } else {
                                                        getAlert(context,
                                                                () {
                                                              if (i.cartData[index].offer.emiEnabled) {
                                                                i.onlySmartPhone = false;
                                                                i.remove3xInstallmentPrice((i.cartData[index]
                                                                    .offer.installmentPrices[0].monthlyPrice!), (i.cartData[index]
                                                                    .offer.installmentPrices[0].monthlyPriceAddon!));
                                                                i.remove6xInstallmentPrice((i.cartData[index]
                                                                    .offer.installmentPrices[1].monthlyPrice!), (i.cartData[index]
                                                                    .offer.installmentPrices[1].monthlyPriceAddon!));
                                                                i.minusTotalNow(i.cartData[index].offer.salePrice == null? i.cartData[index].offer.regularPrice.toDouble():i.cartData[index].offer.salePrice.toDouble());
                                                                i.b2PayTag = true;
                                                              } else {
                                                                final offerIndex = Provider.of<
                                                                    PayByProvider>(
                                                                    context,
                                                                    listen:
                                                                    false)
                                                                    .offerItemsOrder
                                                                    .indexWhere((offer) =>
                                                                offer
                                                                    .offerId ==
                                                                    i
                                                                        .cartData[index]
                                                                        .offer
                                                                        .id);

                                                                i.cartData[index].offer.salePrice !=
                                                                    null
                                                                    ? i.removeOtherProductsPriceWithEmiProduct((i
                                                                    .cartData[
                                                                index]
                                                                    .offer
                                                                    .salePrice *
                                                                    Provider.of<PayByProvider>(context, listen: false)
                                                                        .offerItemsOrder[
                                                                    offerIndex]
                                                                        .amount!
                                                                        .toDouble()))
                                                                    : i.removeOtherProductsPriceWithEmiProduct((i
                                                                    .cartData[
                                                                index]
                                                                    .offer
                                                                    .regularPrice *
                                                                    Provider.of<PayByProvider>(context,
                                                                        listen: false)
                                                                        .offerItemsOrder[offerIndex]
                                                                        .amount!
                                                                        .toDouble()));

                                                                i.cartData[index].offer.salePrice !=
                                                                    null
                                                                    ? i.minusTotalNow((i
                                                                    .cartData[
                                                                index]
                                                                    .offer
                                                                    .salePrice *
                                                                    Provider.of<PayByProvider>(context, listen: false)
                                                                        .offerItemsOrder[
                                                                    offerIndex]
                                                                        .amount!
                                                                        .toDouble()))
                                                                    : i.minusTotalNow((i
                                                                    .cartData[
                                                                index]
                                                                    .offer
                                                                    .regularPrice *
                                                                    Provider.of<PayByProvider>(context,
                                                                        listen: false)
                                                                        .offerItemsOrder[offerIndex]
                                                                        .amount!
                                                                        .toDouble()));
                                                              }
                                                              Provider.of<PayByProvider>(
                                                                  context,
                                                                  listen:
                                                                  false)
                                                                  .removeItemFromCart(i
                                                                  .cartData[
                                                              index]
                                                                  .offer
                                                                  .id);
                                                              i.removeCartData(i
                                                                  .cartData[
                                                              index]
                                                                  .offer
                                                                  .id);
                                                              navigationService
                                                                  .closeScreen();
                                                              i.showLoader =
                                                              true;
                                                            });
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.delete_outline,
                                                      size: 25.sp,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible: i
                                                  .cartData[
                                              index]
                                                  .offer
                                                  .emiEnabled == false ||
                                                  i.b2PayTag == false
                                                  ? false
                                                  : true,
                                              child: Align(
                                                alignment:
                                                Alignment.centerLeft,
                                                child: Container(
                                                    height: 22.h,
                                                    width: width * 0.25,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    child: Center(
                                                      //padding: const EdgeInsets.all(4.0),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                            context)!
                                                            .translate(
                                                            'b2pay_later')!,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white),
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            Container(
                                              //width: width*0.7,
                                              //color: Colors.yellow,
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    'AED ${i.cartData[index].offer.salePrice == null ? double.parse(i.cartData[index].offer.regularPrice.toString()) : double.parse(i.cartData[index].offer.salePrice.toString())}0',
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: priceColor,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                    ),
                                                  ),
                                                  i
                                                      .cartData[
                                                  index]
                                                      .offer
                                                      .emiEnabled
                                                      ? Text(' ')
                                                      : IncDecButton(
                                                    isEdit: true,
                                                    value: quantity,
                                                    priceNow: i.cartData[index].offer.salePrice == null ?
                                                    i.cartData[index].offer.regularPrice
                                                        : i.cartData[index].offer.salePrice,
                                                    priceLater: i.cartData[index].offer.installmentPrices,
                                                    id: i.cartData[index].offer.id,
                                                    categoryId: i.cartData[index].offer.offerCategories[0].id,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 10.h,
                            )
                          ],
                        );

                        //
                        // cartCard(context,Provider.of<OffersProvider>(context,listen: false).cartData[index].offer.images[0],Provider.of<OffersProvider>(context,listen: false).cartData[index].offer.name,Provider.of<OffersProvider>(context,listen: false).cartData[index].offer.salePrice.toString());
                      },
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),

                  i.cartData.length > 3
                      ? InkWell(
                    onTap: () {
                      setState(() {
                        _hideShow = true;
                      });
                    },
                    child: _hideShow
                        ? Text(' ')
                        : Container(
                      height: 40.h,
                      color: Color(0xFFFFEBF2),
                      child: Center(
                        child: Text(
                          'SHOW ${i.cartData.length - 3} MORE ITEMS',
                          style: TextStyle(
                              color: Color(0xFFE0457B),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )
                      : Text(' '),

                  // SizedBox(
                  //   height: 20.h,
                  // ),

                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                      height: height * 0.12,
                      width: width,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[200]!),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Consumer<OffersProvider>(
                                builder: (context, i, _) {
                                  return Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${AppLocalizations.of(context)!.translate('items')!} (${Provider.of<PayByProvider>(context, listen: false).offerItemsOrder.length})',
                                        style:
                                        TextStyle(color: Color(0xFF9098B1)),
                                      ),
                                      Text(
                                          'AED ${i.totalPriceNow.toStringAsFixed(2)}',
                                          style: TextStyle(
                                              color: Color(0xFF223263))),
                                      // SizedBox(width: 10,),
                                      // Text('AED ${i.totalPriceLater}',
                                      //     style: TextStyle(
                                      //         color: Color(0xFF223263))),
                                    ],
                                  );
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .translate('total_price')!,
                                  style: TextStyle(
                                      color: Color(0xFF223263),
                                      fontWeight: FontWeight.w600),
                                ),
                                Consumer<OffersProvider>(
                                    builder: (context, i, _) {
                                      return Text(
                                          'AED ${i.totalPriceNow.toStringAsFixed(2)}',
                                          style: TextStyle(
                                              color: priceColor,
                                              fontWeight: FontWeight.w600));
                                    }),
                              ],
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 8.h,
                  ),
                  CustomButton2(
                    onTap: () async {

                      i.comingFromCartIcon
                          ? moveToShopping()
                          : moveBack(context);
                      Provider.of<OffersProvider>(context, listen: false)
                          .setComingFromCartIcon(true);
                    },
                    txt: AppLocalizations.of(context)!.translate('back')!,
                  ),

                  SizedBox(
                    height: 8.h,
                  ),
                  CustomButton(
                    height: 50.h,
                    width: double.infinity,
                    onPressed: () {
                   /*   Provider.of<OffersProvider>(context, listen: false)
                          .setComingFromCartIcon(true);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShippingScreen(
                                totalPriceNow: i.totalPriceNow,
                                *//*totalPriceLater: i.totalPriceLater,*//*
                              )));*/
                    },
                    text:
                    AppLocalizations.of(context)!.translate('proceed')!,
                  ),
                  // SizedBox(
                  //   height: 10.h,
                  // ),
                ],
              ),
            )
                : i.showLoader == null
                ? Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
                : EmptyCart(
              name:
              "${AppLocalizations.of(context)!.translate('cart')!}(0)",
              desc: AppLocalizations.of(context)!
                  .translate('no_items_in_cart')!,
              showButton: true,
            ),
          );
        }));
  }

  Future<void> getAllOfferData(int perPage) async {
    await Provider.of<OffersProvider>(context, listen: false)
        .getOffers(perPage: perPage);
  }

  Future<void> moveToShopping() async {
    EasyLoading.show(
        status: AppLocalizations.of(context)!.translate('please_wait')!);
    await getAllOfferData(10).then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewAllOffersScreen(
            // categoryId: widget.categoryId,
            //  filterBy: _name,
            10,
          ),
        ),
      );
    });
  }

  moveBack(BuildContext context) {
    var count = 0;

    Navigator.popUntil(context, (route) {
      return count++ == 2;
    });

    Provider.of<OffersProvider>(context, listen: false)
        .setComingFromCartIcon(true);
  }
}

class ToggleButton extends StatefulWidget {
  final String? id;
  bool? like;

  ToggleButton({this.id, this.like});

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  //bool? like;

  // getData()async{
  //   EasyLoading.show(status: "Loading");
  //   await Provider.of<WishListProvider>(context,listen: false).checkWishList(widget.id!).then((value)async {
  //     setState(() {
  //       like = value;
  //     });
  //     EasyLoading.dismiss();
  //   });
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //
  //   getData();
  //
  // }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        EasyLoading.show(status: 'Loading');
        setState(() {
          if (widget.like == false) {
            Provider.of<WishListProvider>(context, listen: false)
                .addToWishList(widget.id!);
            EasyLoading.dismiss();
          }

          if (widget.like == true) {
            Provider.of<WishListProvider>(context, listen: false)
                .deleteFromWishList(widget.id!);

            EasyLoading.dismiss();
          }
          widget.like = !widget.like!;
        });
      },
      child: widget.like!
          ? Icon(
        Icons.favorite,
        color: Theme.of(context).primaryColor,
        size: 25.sp,
      )
          : Icon(
        Icons.favorite_border,
        //color: Theme.of(context).primaryColor,
        size: 25.sp,
      ),
    );
  }
}

// Widget emptyCart(context,String name){
//   var height = MediaQuery.of(context).size.height;
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       Center(
//         child: Container(
//             height: height*0.2,
//             child: Image.asset('assets/images/cart_empty.png')
//         ),
//       ),
//       Text(name,style: TextStyle(fontSize: 19),)
//     ],
//   );
// }

getAlert(context, VoidCallback onTap) {
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
                Text('Do you really want to remove product?'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      height: 25.h,
                      width: 100,
                      text: "Yes",
                      onPressed: onTap,
                    ),
                    // InkWell(
                    //     onTap: () {
                    //       Navigator.pop(context);
                    //     },
                    //     child: Text(
                    //       'Cancel',
                    //       style: TextStyle(color: Colors.blue),
                    //     )),
                    SizedBox(
                      width: 10,
                    ),
                    CustomButton(
                      height: 25.h,
                      width: 100,
                      text: "Cancel",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    // InkWell(
                    //     onTap: onTap,
                    //     child: Text(
                    //       'Yes',
                    //       style: TextStyle(color: Colors.blue),
                    //     )),
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
