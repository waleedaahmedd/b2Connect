// import 'package:b2connect_flutter/model/models/offers_models/product_details_model.dart';
// import 'package:b2connect_flutter/model/services/navigation_service.dart';
// import 'package:b2connect_flutter/model/utils/constant.dart';
// import 'package:b2connect_flutter/model/utils/routes.dart';
// import 'package:b2connect_flutter/model/utils/service_locator.dart';
// import 'package:b2connect_flutter/view/screens/product_detail_screen.dart';
// import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
// import 'package:b2connect_flutter/view/widgets/gradiant_color_button.dart';
// import 'package:b2connect_flutter/view/widgets/tinted_color_button.dart';
// import 'package:b2connect_flutter/view/widgets/empty_cart.dart';
// import 'package:b2connect_flutter/view/widgets/inc_dec_button.dart';
//
// import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
// import 'package:b2connect_flutter/view_model/providers/wish_list_provider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import '../../model/locale/app_localization.dart';
//
//
// class OrderReviewScreen extends StatefulWidget {
//  final List<ProductDetailsModel>? cartData;
//   const OrderReviewScreen({Key? key,this.cartData}) : super(key: key);
//
//   @override
//   _OrderReviewScreenState createState() => _OrderReviewScreenState();
// }
//
// class _OrderReviewScreenState extends State<OrderReviewScreen> {
//
//   double? _totalPrice = 0.0;
//
//   NavigationService navigationService = locator<NavigationService>();
//
//   // bool? showLoader;
//
//   // getData() async {
//   //
//   //   if (Provider.of<OffersProvider>(context, listen: false).productIds.isNotEmpty) {
//   //     Provider.of<OffersProvider>(context, listen: false).productIds.toSet().toList().forEach((element) async {
//   //     });
//   //   }
//   // }
//
//   @override
//   void initState() {
//     super.initState();
//     //getData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBarWithBackIconAndLanguage(
//           onTapIcon: () {
//             navigationService.closeScreen();
//           },
//         ),
//         body: Container(
//           padding: EdgeInsets.all(8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 AppLocalizations.of(context)!.translate('review_order')!,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 34.sp,
//                 ),
//               ),
//
//               SizedBox(
//                 height: 10,
//               ),
//
//               Expanded(
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: widget.cartData!.length,
//                   itemBuilder: (context, index) {
//                     int quantity = Provider.of<OffersProvider>(context, listen: false).productIds.where((e) => e == widget.cartData![index].offer.id).length;
//
//                     return Column(
//                       children: [
//                         Container(
//                             height: height * 0.12,
//                             width: width,
//                             decoration: BoxDecoration(
//
//                                 border: Border.all(
//                                     color: Colors.grey[200]!),
//                                 borderRadius:
//                                 BorderRadius.circular(12)),
//
//                             child: Row(
//                               children: [
//                                 Container(
//                                     width: width * 0.2,
//                                     child: FadeInImage(
//                                       image: NetworkImage(
//                                         widget.cartData![index].offer.images[0],
//                                       ),
//                                       placeholder: AssetImage(
//                                           'assets/images/placeholder1.png'),
//                                       imageErrorBuilder: (context,i,_)=>Center(
//                                         child: Image.asset(
//                                           'assets/images/not_found1.png',
//                                           height: 100,
//                                         ),
//                                       ),
//                                       //fit: BoxFit.contain,
//                                     )),
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       right: 5.0, top: 5, bottom: 5),
//                                   child: Container(
//                                     width: width * 0.7,
//                                     child: Column(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment
//                                           .spaceBetween,
//                                       children: [
//                                         Container(
//                                           child: Row(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Container(
//                                                 width: width * 0.5,
//                                                 height: 40.h,
//                                                 child: Text(
//                                                   widget.cartData![index].offer.name,
//                                                   overflow: TextOverflow.ellipsis,
//                                                   maxLines: 2,
//                                                   style: TextStyle(
//                                                       fontSize: 13.sp,
//                                                       fontWeight: FontWeight.w500),
//                                                 ),
//                                               ),
//
//                                               Icon(
//                                                 Icons.delete_outline,
//                                                 size: 25.sp,
//                                                 color: Colors.grey[300],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           child: Row(
//                                             crossAxisAlignment: CrossAxisAlignment.end,
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 'AED ${widget.cartData![index].offer.salePrice.toString()}',
//                                                 style: TextStyle(
//                                                   fontSize: 14.sp,
//                                                   color: pink,
//                                                   fontWeight:
//                                                   FontWeight.w500,
//                                                 ),
//                                               ),
//                                               widget.cartData![index].offer.offerCategories[0].slug=="smart-phones"?Text(' '):IncDecButton(
//                                                 isEdit:false,
//                                                 value: quantity,
//                                                 priceNow: widget.cartData![index].offer.salePrice,
//                                                 priceLater: widget.cartData![index].offer.regularPrice,
//                                                 id: widget.cartData![index].offer.id,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             )),
//                         SizedBox(
//                           height: 10.h,
//                         )
//                       ],
//                     );
//
//
//                   },
//                 ),
//               ),
//
//               SizedBox(
//                 height: 10,
//               ),
//
//               SizedBox(
//                 height: 15.h,
//               ),
//               Container(
//                   height: height * 0.12,
//                   width: width,
//                   decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey[200]!),
//                       borderRadius: BorderRadius.circular(5)),
//                   child: Padding(
//                     padding: EdgeInsets.all(8),
//                     child: Column(
//                       children: [
//                         Consumer<OffersProvider>(
//                             builder: (context, i, _) {
//                               return Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     '${AppLocalizations.of(context)!.translate('items')!} (${i.productIds.length})',
//                                     style:
//                                     TextStyle(color: Color(0xFF9098B1)),
//                                   ),
//                                   Text('AED ${i.totalPriceNow}',
//                                       style: TextStyle(
//                                           color: Color(0xFF223263))),
//                                 ],
//                               );
//                             }),
//
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Divider(),
//                         Row(
//                           mainAxisAlignment:
//                           MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               AppLocalizations.of(context)!
//                                   .translate('total_price')!,
//                               style: TextStyle(
//                                   color: Color(0xFF223263),
//                                   fontWeight: FontWeight.w600),
//                             ),
//                             Consumer<OffersProvider>(
//                                 builder: (context, i, _) {
//                                   return Text('AED ${i.totalPriceNow}',
//                                       style: TextStyle(
//                                           color: Color(0xFFE0457B),
//                                           fontWeight: FontWeight.w600));
//                                 }),
//                           ],
//                         ),
//                       ],
//                     ),
//                   )),
//               SizedBox(
//                 height: 8.h,
//               ),
//
//               CustomButton(
//                 height: 50.h,
//                 width: double.infinity,
//                 onPressed: () {
//                   navigationService.navigateTo(ShippingScreenRoute);
//                 },
//                 text:
//                 AppLocalizations.of(context)!.translate('checkout')!,
//               ),
//               SizedBox(
//                 height: 8.h,
//               ),
//             ],
//           ),
//         )
//     );
//   }
// }
//
//
