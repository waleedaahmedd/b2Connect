import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/models/offers_models/offers_list_model.dart';
import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/view/screens/product_detail_screen.dart';
import 'package:b2connect_flutter/view/screens/top_up_details_screen.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../screen_size.dart';

class OffersListWidget extends StatelessWidget {
  const OffersListWidget(this.offerList) : super();

  final List<OffersList>? offerList;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
          scrollDirection: Axis.vertical,
          addRepaintBoundaries: false,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: offerList!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 10.0.h,
            crossAxisSpacing: 10.0.w,
            childAspectRatio: 0.7.w,
            //ScreenSize.productCardWidth / ScreenSize.productCardHeight,
            crossAxisCount: 2,
          ),
          itemBuilder: (context, i) {
            return AnimationConfiguration.staggeredGrid(
              columnCount: 2,
              position: i,
              duration: const Duration(milliseconds: 1000),
              child: ScaleAnimation(
                scale: 1,
                child: FlipAnimation(
                  child: GestureDetector(
                    onTap: () {
                      Provider.of<OffersProvider>(context, listen: false)
                          .productDetailsData = null;
                      //TODO: CHANGE CATEGORY ID AS 492 FOR PRODUCTION 459 FOR QA
                      offerList![i].offerCategories!.length > 1
                          ? offerList![i].offerCategories![1].id == 492 ||
                                  offerList![i].offerCategories![0].id == 492
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TopUpDetailsScreen(
                                            id: offerList![i].id.toString(),
                                          )))
                              : setRoute(context, i)
                          : offerList![i].offerCategories![0].id == 492
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TopUpDetailsScreen(
                                            id: offerList![i].id.toString(),
                                          )))
                              : setRoute(context, i);
                    },
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.w,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*      Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [*/
                            if (offerList![i].salePrice != null)
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
                                  AppLocalizations.of(context)!
                                      .translate('sale')!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenSize.productContainerText,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            /* Visibility(
                                  visible: offerList![i].offerCategories![0].id == 493 ? false : true,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
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
                                  ),
                                )*/
                            /*   ],
                            ),*/
                            Container(
                              child: Stack(
                                children: [
                                  offerList![i].images == []
                                      ? Image.asset(
                                          'assets/images/not_found1.png',
                                          height: 120.h,
                                        )
                                      : Center(
                                          child: CachedNetworkImage(
                                            height: 100.h,
                                            imageUrl:
                                                offerList![i].images!.first,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              'assets/images/placeholder1.png',
                                            ),
                                            errorWidget:
                                                (context, url, error) => Center(
                                              child: Image.asset(
                                                'assets/images/not_found1.png',
                                                // height: 100,
                                              ),
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                  // FadeInImage(
                                  //   image: NetworkImage(offerList![i].images!.first),
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
                                  Visibility(
                                    visible:
                                        offerList![i].stockStatus! == "instock"
                                            ? false
                                            : true,
                                    child: Container(
                                      height: 120.h,
                                      child: Center(
                                        child: Card(
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
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${offerList![i].name.toString()}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 10.sp,
                                // ScreenSize.productCardText,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Visibility(
                                  visible: offerList![i].salePrice == null
                                      ? false
                                      : true,
                                  child: Text(
                                    //'AED ${offerList![i].regularPrice.toString()}',
                                    'AED ${double.parse(offerList![i].regularPrice.toString()).toStringAsFixed(2)}',

                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.grey.shade800,
                                      decorationStyle:
                                          TextDecorationStyle.solid,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  offerList![i].salePrice == null
                                      ? 'AED ${double.parse(offerList![i].regularPrice.toString()).toStringAsFixed(2)}'
                                      : 'AED ${double.parse(offerList![i].salePrice.toString()).toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: priceColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
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
    );
  }

  setRoute(BuildContext context, int i) {
    /*Provider.of<OffersProvider>(context, listen: false)
        .setComingFromCartIcon(false);*/
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProductDetailScreen(
                id: offerList![i].id.toString(),
              )),
    );
  }
}
