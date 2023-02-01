import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/services/storage_service.dart';
import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/no_data_screen.dart';
import 'package:b2connect_flutter/view/widgets/no_internet.dart';
import 'package:b2connect_flutter/view_model/providers/order_provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/utils/no_internet_dialog.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var navigationService = locator<NavigationService>();
  var storageService = locator<StorageService>();

  bool? _showLoader;

  bool _connectedToInternet = true;

  @override
  void initState() {
    getOfferData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(builder: (context, i, _) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarWithBackIconAndLanguage(
            onTapIcon: () {
              Navigator.pop(context);
            },
          ),
          body:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      AppLocalizations.of(context)!.translate('orders')!,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  i.orderList.isNotEmpty
                      ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                          itemCount: i.orderList.length,
                          itemBuilder: (context, index) {
                            String dateTime =
                                "${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(i.orderList[index].time))} ";
                            return InkWell(
                                onTap: () async {
                                  EasyLoading.show(
                                      status: 'Please Wait...');
                                  await i.getOrderDetails(
                                      i.orderList[index].orderId);
                                  navigationService
                                      .navigateTo(OrderDetailScreenRoute);
                                },
                                child: tile1(
                                    context,
                                    i.orderList[index].salesOrderNo == null
                                        ? " "
                                        : i.orderList[index].salesOrderNo,
                                    i.orderList[index].total
                                        .toStringAsFixed(2),
                                    dateTime,
                                    i.orderList[index].currency,
                                    i.orderList[index].paymentMethod
                                        .replaceAll("_", " ")));
                          }),
                    ),
                  ) :Expanded(
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/no_order.png',
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              "You don't have any orders yet.",
                              style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                  )
                ],
              )
             );
    });
  }

  getOfferData() async {
    await NoInternetDialog.checkConnection().then((value) {
      if (value) {
        Future.delayed(Duration.zero, () async {
          await Provider.of<OrderProvider>(context, listen: false)
              .callOfferOrder();
        });
      } else {
        NoInternetDialog.getInternetAlert(newContext: context, popCount: 2);
      }
    });
  }
}

Widget tile1(context, String id, String price, String dateTime, String currency,
    String paymentMethod) {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Color(0xFFEEEEEE))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      //height:20,
                      width: MediaQuery.of(context).size.width * 0.56,
                      // color: Colors.red,
                      child: Text(
                        "Order $id",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "$currency $price",
                    style: TextStyle(
                        color: priceColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      // color:Colors.red,
                      width: MediaQuery.of(context).size.width * 0.66,
                      child: Text(
                        "$dateTime",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      )),
                  // SizedBox(width: 5,),
                  Text("1 items",
                      style: TextStyle(color: Color(0xFF000000), fontSize: 13)),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                // height: 22.h,
                //width: 100.w,
                decoration: BoxDecoration(
                    color: Color(0xFFFFEBF2),
                    borderRadius: BorderRadius.circular(22)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageIcon(
                        AssetImage(
                          'assets/images/Bag.png',
                        ),
                        size: 14,
                        color: Color(0xFFD93C54),
                      ),
                      // Icon(Icons.shopping_bag_outlined,color: Color(0xFFD93C54),size: 14,),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '$paymentMethod',
                          style:
                              TextStyle(color: Color(0xFFD93C54), fontSize: 12),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      SizedBox(
        height: 10,
      )
    ],
  );
}

// Widget tile1(context, String? id, String price, String dateTime, String currency) {
//   return Column(
//     children: [
//       Container(
//         height: MediaQuery.of(context).size.height * 0.11,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(border: Border.all(color: Color(0xFFEEEEEE))),
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Order Id - $id",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     width: 3,
//                   ),
//                   Text(
//                     "$currency $price",
//                     style: TextStyle(color: priceColor,fontSize: 15,fontWeight:FontWeight.w600),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Order at Camp: $dateTime",
//                     style: TextStyle(color: Colors.grey, fontSize: 13),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Text("1 items",
//                       style: TextStyle(color: Colors.grey, fontSize: 13)),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       SizedBox(
//         height: 10,
//       )
//     ],
//   );
// }
