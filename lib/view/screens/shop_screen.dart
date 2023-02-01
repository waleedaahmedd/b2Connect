import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/services/util_service.dart';
import 'package:b2connect_flutter/model/utils/hex_to_color.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/screens/view_all_offers_screen.dart';
import 'package:b2connect_flutter/view/widgets/appBar_with_cart_notification_widget.dart';
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

import '../../model/utils/no_internet_dialog.dart';


class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  /*List<Color> _colors = [
    Colors.pink,
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.deepPurple,
    Colors.teal,
    Colors.brown,
    Colors.cyan,
    Colors.deepOrange
  ];*/

  // String tagId = ' ';
  // void active(val) {
  //   setState(() {
  //     tagId = val;
  //   });
  // }
  //List<ProductCategories> productCategoriesData=[];
  NavigationService navigationService = locator<NavigationService>();
  UtilService utilsService = locator<UtilService>();

  // bool _connectedToInternet = true;

  getData() async {
    await NoInternetDialog.checkConnection().then((value) async {
      if (value) {
        await Provider.of<OffersProvider>(context, listen: false)
            .getProductCategories().then((value) =>
            setState(() {
            }));
      }
      else {
        NoInternetDialog.getInternetAlert(newContext: context, popCount: 2);
      }
    });

  }

  //productCategoriesData.clear();

  //     .then((value){
  //   setState(() {
  //     value.forEach((element) {
  //       if(element.parent==0)
  //         Provider.of<OffersProvider>(context, listen: false).saveProductCategory(element);
  //         //productCategoriesData.add(element);
  //     });
  //
  //   });
  // });


  @override
  void initState() {
    super.initState();
    if (Provider
        .of<OffersProvider>(context, listen: false)
        .productCategories
        .isEmpty) {
      getData();
    }
  }

  //final _searchQueryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWithCartNotificationWidget(
          title: 'Shop',
          onTapIcon: () {
            Navigator.pop(context);
            Provider.of<OffersProvider>(context, listen: false)
                .clearFilterData();
          },
        ),
        body: Consumer<OffersProvider>(
          builder: (context, i, _) {
            return i.productCategories.isNotEmpty
                ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimationLimiter(
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    addRepaintBoundaries: false,
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    itemCount: i.productCategories.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      //  childAspectRatio: 0.9.w,
                      //ScreenSize.productCardWidth / ScreenSize.productCardHeight,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredGrid(
                        columnCount: 2,
                        position: index,
                        duration:
                        const Duration(milliseconds: 1000),
                        child: ScaleAnimation(
                          scale: 1,
                          child: FlipAnimation(
                            child: GestureDetector(
                              onTap: () async {
                                {
                                  if (i.productCategories[index]
                                      .id ==
                                      459) {
                                    navigationService.navigateTo(
                                        EditNumberTopUpScreenRoute);
                                  } else {
                                    var categoryId = i
                                        .productCategories[index]
                                        .id;

                                    await getOfferDetail(categoryId)
                                        .then((value) {
                                          if (value) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewAllOffersScreen(
                                                        10,
                                                        categoryId:
                                                        categoryId,
                                                      )),
                                            );
                                          }

                                    });
                                  }
                                }
                              },
                              child: Card(
                                color: i.productCategories[index].description ==
                                    "" ? Colors.orange.shade200 : HexColor(i
                                    .productCategories[index]
                                    .description) /*_colors[index].withOpacity(0.5)*/,

                                /*Colors
                                                .primaries[Random().nextInt(
                                                    Colors.primaries.length)].withOpacity(1.0)*/

                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.grey.shade300,
                                    // width: 1.w,
                                  ),
                                  borderRadius:
                                  BorderRadius.circular(20.r),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w,
                                      vertical: 10.h),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        i.productCategories[index]
                                            .imageUrl ==
                                            ""
                                            ? Image.asset(
                                          'assets/images/not_found1.png',
                                          // height: 100.h,
                                        )
                                            : Center(
                                          child:
                                          CachedNetworkImage(
                                            // width: 100.w,
                                            // height: 100.h,
                                            imageUrl: i
                                                .productCategories[
                                            index]
                                                .imageUrl,
                                            height: 100.h,

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
                                                    // height: 100,
                                                  ),
                                                ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Text(
                                          "${i.productCategories[index].name
                                              .toString()}",
                                          /*  overflow: TextOverflow.ellipsis,
                                          maxLines: 2,*/
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            // ScreenSize.productCardText,
                                            fontWeight:
                                            FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            )

            /*Padding(
                padding: const EdgeInsets.all(12.0),
                child:
                SingleChildScrollView(
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [


                        Column(
                          children: [
                            categoryWidget(
                              height: height*0.29,
                              width: height*0.2,
                              color: Color(0xFFFFF9E7),
                              imgHeight: height*0.15,
                              img: i.productCategories[0].imageUrl,
                              id: i.productCategories[0].id,
                              name: i.productCategories[0].name,
                            ),

                            SizedBox(height: 15,),
                            categoryWidget(
                              height: height*0.2,
                              width: height*0.2,
                              color: Color(0xFFDBE8FF),
                              imgHeight: height*0.12,
                              img: i.productCategories[1].imageUrl,
                              id: i.productCategories[1].id,
                              name: i.productCategories[1].name,
                            ),
                            SizedBox(height: 15,),
                            categoryWidget(
                              height: height*0.29,
                              width: height*0.2,
                              color: Color(0xFFFEE6FC),
                              imgHeight: height*0.12,
                              img: i.productCategories[2].imageUrl,
                              id: i.productCategories[2].id,
                              name: i.productCategories[2].name,
                            ),
                            */ /*   SizedBox(height: 15,),
                            categoryWidget(
                              height: height*0.2,
                              width: height*0.2,
                              color: Color(0xFFDBE8FF),
                              imgHeight: height*0.12,
                              img: i.productCategories[3].imageUrl,
                              id: i.productCategories[3].id,
                              name: i.productCategories[3].name,
                            ),*/ /*
                          ],
                        ),
                        SizedBox(width: 5,),
                        Column(
                          children: [
                            categoryWidget(
                              height: height*0.2,
                              width: height*0.2,
                              color: Color(0xFFFFE6E5),
                              imgHeight: height*0.12,
                              img: i.productCategories[3].imageUrl,
                              id: i.productCategories[3].id,
                              name: i.productCategories[3].name,
                            ),
                            SizedBox(height: 15,),
                            categoryWidget(
                              height: height*0.29,
                              width: height*0.2,
                              color: Color(0xFFDFF1FF),
                              imgHeight: height*0.13,
                              img: i.productCategories[4].imageUrl,
                              id: i.productCategories[4].id,
                              name: i.productCategories[4].name,
                            ),
                            */ /*  SizedBox(height: 15,),
                            categoryWidget(
                              height: height*0.2,
                              width: height*0.2,
                              color: Color(0xFFDBE8FF),
                              imgHeight: height*0.12,
                              img: i.productCategories[6].imageUrl,
                              id: i.productCategories[6].id,
                              name: i.productCategories[6].name,
                            ),*/ /*
                            */ /*  SizedBox(height: 15,),
                            categoryWidget(
                              height: height*0.29,
                              width: height*0.2,
                              color: Color(0xFFDFF1FF),
                              imgHeight: height*0.13,
                              img: i.productCategories[7].imageUrl,
                              id: i.productCategories[7].id,
                              name: i.productCategories[7].name,
                            ),*/ /*
                          ],
                        ),
                      ],
                    ),
                  ),
                )




              // ListView(
              //   scrollDirection: Axis.vertical,
              //   children: [
              //     // Container(
              //     //   height: height*0.09,
              //     //   // decoration: BoxDecoration(
              //     //   //   borderRadius: BorderRadius.circular(5),
              //     //   // ),
              //     //   child: Padding(
              //     //     padding: EdgeInsets.zero,
              //     //     child: TextField(
              //     //       controller: _searchQueryController,
              //     //       decoration: InputDecoration(
              //     //         contentPadding: EdgeInsets.only(left: 10),
              //     //         prefixIcon: IconButton(
              //     //             color: Colors.black,
              //     //             onPressed: () {
              //     //
              //     //             },
              //     //             icon: Icon(Icons.search)),
              //     //         enabledBorder: OutlineInputBorder(
              //     //           borderRadius: BorderRadius.circular(12),
              //     //           borderSide: BorderSide(
              //     //             color: Color(0xFFDADADA),
              //     //             width: 1,
              //     //           ),
              //     //         ),
              //     //         focusedBorder: OutlineInputBorder(
              //     //           borderRadius: BorderRadius.circular(12),
              //     //           borderSide: BorderSide(
              //     //             color: Color(0xFFDADADA),
              //     //             width: 1,
              //     //           ),
              //     //         ),
              //     //
              //     //         errorBorder: InputBorder.none,
              //     //         disabledBorder: InputBorder.none,
              //     //         hintText: 'Search Store',
              //     //         hintStyle: TextStyle(
              //     //             fontSize: 14, fontWeight: FontWeight.w500),
              //     //         fillColor: Colors.white,
              //     //
              //     //         // Color.fromRGBO(
              //     //         //   243,
              //     //         //   244,
              //     //         //   246,
              //     //         //   1,
              //     //         // ),
              //     //         filled: true,
              //     //       ),
              //     //       style: TextStyle(
              //     //           color: Colors.black,
              //     //           fontSize: 14,
              //     //           decoration: TextDecoration.none),
              //     //     ),
              //     //   ),
              //     // ),
              //
              //
              //
              //     SizedBox(height: 15.h,),
              //     Container(
              //       height: 100,
              //         width: 100,
              //
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(12),
              //             border: Border.all(color: Color(0xFFE0457B))
              //         ),
              //         child: Column(
              //           children: [
              //             Container(
              //
              //               height: height*0.18,
              //               width: height*0.18,
              //               color: Colors.green,
              //
              //               //child: Image.network(i.productCategories[index].imageUrl),
              //             ),
              //             Text("smart Phones",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
              //             SizedBox(height: 10,),
              //
              //
              //           ],
              //         )
              //
              //     ),
              //
              //
              //     // GridView.builder(
              //     // scrollDirection: Axis.vertical,
              //     // addRepaintBoundaries: false,
              //     // shrinkWrap: true,
              //     // physics: NeverScrollableScrollPhysics(),
              //     // itemCount: i.productCategories.length,
              //     // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     // mainAxisSpacing: (20.h),
              //     // crossAxisSpacing: (20.w),
              //     // childAspectRatio: 175 / 200,
              //     // crossAxisCount: 2,
              //     // ),
              //     // itemBuilder: (context, index) {
              //     //   return  InkWell(
              //     //     onTap: ()
              //     //     async {
              //     //       var categoryId = i.productCategories[index].id;
              //     //       EasyLoading.show(status: 'Please Wait...');
              //     //       await getOfferDetail(categoryId).then((value) {
              //     //         Navigator.push(
              //     //           context,
              //     //           MaterialPageRoute(
              //     //               builder: (context) =>
              //     //                   ViewAllOffersScreen(categoryId: categoryId,)),
              //     //         );
              //     //       });
              //     //     },
              //     //
              //     //     child: Container(
              //     //
              //     //         decoration: BoxDecoration(
              //     //             borderRadius: BorderRadius.circular(12),
              //     //             border: Border.all(color: Color(0xFFE0457B))
              //     //         ),
              //     //         child: Column(
              //     //           children: [
              //     //             Container(
              //     //
              //     //                height: height*0.18,
              //     //
              //     //               child: Image.network(i.productCategories[index].imageUrl),
              //     //             ),
              //     //             Text(i.productCategories[index].name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
              //     //             SizedBox(height: 10,),
              //     //
              //     //
              //     //           ],
              //     //         )
              //     //
              //     //     ),
              //     //   );
              //     // }),
              //   ],
              // ),
            )*/

            // Container(
            //   // height: height,
            //   //padding: EdgeInsets.all(6),
            //
            //   child: Column(
            //     children: [
            //       Expanded(
            //         child: ListView.builder(
            //           // physics: Scrollable(),
            //           // shrinkWrap: true,
            //             scrollDirection: Axis.vertical,
            //             itemCount: i.productCategories.length,
            //             itemBuilder: (context,index){
            //
            //               return InkWell(
            //                 onTap: ()
            //                 async {
            //                   var categoryId = i.productCategories[index].id;
            //                   EasyLoading.show(status: 'Please Wait...');
            //                   await getOfferDetail(categoryId).then((value) {
            //                     Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                           builder: (context) =>
            //                               ViewAllOffersScreen(categoryId: categoryId,)),
            //                     );
            //                   });
            //                 },
            //                 // utilsService.showToast('Still in Progress');
            //
            //                 child: CategoriesWidget(
            //                   //context,
            //                   name: i.productCategories[index].name,
            //                   img: i.productCategories[index].imageUrl,
            //                 ),
            //               );
            //
            //             }),
            //       ),
            //     ],
            //   ),
            // )

                : Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          },
        )
          );
  }

  Future<bool> getOfferDetail(int categoryId) async {
    bool connection = false;

      await NoInternetDialog.checkConnection().then((value) async {
        if (value) {
          EasyLoading.show(
              status: 'Please Wait...');
          await Provider.of<OffersProvider>(context, listen: false)
              .getOffers(categoryId: categoryId, perPage: 10, page: 1);
          connection =  true;
        }
        else {
          NoInternetDialog.getInternetAlert(newContext: context, popCount: 1);
          connection =  false;
        }
      });
    return connection;

  }
/* Widget categoryWidget({double? height,double? width,Color? color,double? imgHeight,String? img,String? name,var id}){
    return InkWell(
      onTap: ()async{
        var categoryId = id;//i.productCategories[index].id;
        EasyLoading.show(status: AppLocalizations.of(context)!.translate('please_wait')!);
        await getOfferDetail(categoryId).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ViewAllOffersScreen(categoryId: categoryId,perPage: 10,)),
          );
        });

      },
      child: Container(
        height: height,
        width: width,

        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              height: imgHeight,
              imageUrl: "$img",
              placeholder: (context, url) => Image.asset(
                'assets/images/placeholder1.png',
              ),
              errorWidget: (context, url, error) => Center(
                child: Image.asset(
                  'assets/images/not_found1.png',
                  // height: 100,
                ),
                // image: NetworkImage('$img!'), placeholder: AssetImage('assets/images/logo_icon.png'),
              ),),
            Text(name!,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }*/
}

// Widget categoriesWidget1(context,String name,String img){
//   return Container(
//
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//             children: [
//               SizedBox(
//                 width: 10.w,
//               ),
//               Container(
//                 width: 70.w,
//                 height: 70.h,
//                 child:
//                 FadeInImage(
//                   image: NetworkImage(img),
//                   placeholder: AssetImage(
//                     'assets/images/placeholder1.png',
//                   ),
//
//                   fit: BoxFit.fill,
//                 ),
//                 // Image.network(
//                 //   img,
//                 // ),
//               )
//               // Image(
//               //   image: AssetImage(
//               //     widget.img!,
//               //   ),
//               //   width: 70.w,
//               //   height: 70.h,
//               // ),
//             ]
//         ),
//         Text(
//           name,
//           style: TextStyle(
//               fontSize: 14.sp,
//               color: Theme.of(context)
//                   .primaryColor,
//               fontWeight: FontWeight.bold),
//         ),
//         Icon(
//           Icons.chevron_right_outlined,
//           color: Theme.of(context)
//               .primaryColor,
//           size: 26.h,
//         ),
//       ],
//     ),
//   );
//
// }
