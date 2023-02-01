import 'package:b2connect_flutter/model/locale/app_localization.dart';
import 'package:b2connect_flutter/model/models/history_refill.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/constant.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/widgets/appbar_with_back_icon_and_language.dart';
import 'package:b2connect_flutter/view/widgets/no_data_screen.dart';
import 'package:b2connect_flutter/view/widgets/no_internet.dart';
import 'package:b2connect_flutter/view_model/providers/auth_provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

// late Future<void> _launched;
//
// Future<void> _makePhoneCall(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

class _TransactionsState extends State<Transactions> {

  PackageOrdersModel? _packageOrderData1;
  var navigationService = locator<NavigationService>();
  // OfferOrderModel? _offerOrderData;
  bool? _showLoader;
  //bool? _showLoader1;
  //List<RefillHistory>? refillHistoryData;
  bool _connectedToInternet = true;

  getPackageData()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      Future.delayed(Duration.zero, () async {
        await Provider.of<AuthProvider>(context, listen: false).callPackageOrder().then((value) {

          if(value=="failed"){
            setState(() {
              _showLoader = true;
            });

          }

        });

      });
    }
    else{
      setState(() {
        _connectedToInternet = false;
      });
    }




  }
  // getOfferData(){
  //
  //
  //   if(Provider.of<AuthProvider>(context,listen: false).offerOrderModelData==null){
  //
  //     Future.delayed(Duration.zero, () async {
  //       await Provider.of<AuthProvider>(context, listen: false).callOfferOrder().then((value) {
  //
  //
  //         if(value=="failed"){
  //           setState(() {
  //             _showLoader1 = true;
  //           });
  //
  //
  //         }
  //         else{
  //           setState(() {
  //             _offerOrderData=value;
  //           });
  //         }
  //
  //       });
  //
  //     });
  //   }
  //   else{
  //     _offerOrderData=Provider.of<AuthProvider>(context,listen: false).offerOrderModelData;
  //   }
  //
  //
  // }

  // getData(){
  //   //if(Provider.of<AuthProvider>(context, listen: false).refillHistoryData.isEmpty){
  //     Future.delayed(Duration.zero, () async {
  //       await Provider.of<AuthProvider>(context, listen: false).callHistoryRefill().then((value) {
  //
  //
  //         if(value=="failed"){
  //           setState(() {
  //             _showLoader = true;
  //           });
  //
  //
  //         }
  //
  //
  //       });
  //
  //     });
  //  // }
  //
  //
  // }


  @override
  void initState() {
    super.initState();

    getPackageData();

  }

  @override
  Widget build(BuildContext context) {
    return _connectedToInternet? Consumer<AuthProvider>(
        builder: (context,i,_){
          return _showLoader == null
              ? Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBarWithBackIconAndLanguage(
                onTapIcon: (){
                  Navigator.pop(context);                },
              ),
              body: i.packageOrderModelData.isNotEmpty? Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        AppLocalizations.of(context)!.translate('transaction')!,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.builder(
                            itemCount: i.packageOrderModelData.length,
                            itemBuilder: (context,index){
                              double val = i.packageOrderModelData[index].packageValidSeconds! / 86400;
                              print('this is value--$val');
                              String abc = val.toStringAsFixed(0);
                              String dateTime="${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(i.packageOrderModelData[index].time!))} ";
                              //${DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(i.packageOrderModelData[index].time!))}
                              return InkWell(
                                  onTap:() async {
                                    EasyLoading.show(status: 'Please Wait...');
                                    await i.callPackageOrderDetail(i.packageOrderModelData[index].orderId!);
                                    navigationService.navigateTo(TransactionsDetailScreenRoute);
                                  },
                                  child: tile(context,abc,i.packageOrderModelData[index].packageName!.replaceAll("_", " "),i.packageOrderModelData[index].orderId,double.parse(i.packageOrderModelData[index].total.toString()).toStringAsFixed(2),dateTime,i.packageOrderModelData[index].currency!));
                            }),
                      ),
                    ),
                    // Text('offer'),
                    //  Expanded(
                    //   child: ListView.builder(
                    //       itemCount: offerOrderData!.items!.length,
                    //       itemBuilder: (context,index){
                    //         String dateTime="${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(offerOrderData!.items![index].time))} ${DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(offerOrderData!.items![index].time))}";
                    //
                    //         return tile(context,offerOrderData?.items![index].orderId.toString(),offerOrderData!.items![index].total.toString(),dateTime,offerOrderData!.items![index].currency);
                    //
                    //       }),
                    // )
                  ],
                ),
              )
                  :  Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              )


          ):NoDataScreen(
            title: AppLocalizations.of(context)!.translate('transaction')!,
            desc: "You don't have any transactions, yet!",
            buttontxt: "Get Wifi, Today!",
            ontap: ()async{

              navigationService.navigateTo(WifiScreenRoute);
            },
          );
        }
    ):NoInternet();
  }
}

Widget tile(context,String validity,String name,int? id,String price,String dateTime,String currency){
  return Column(
    children: [
      Container(
        //height: MediaQuery.of(context).size.height*0.14,
        //width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Color(0xFFEEEEEE))
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    //height:20,
                    // width: MediaQuery.of(context).size.width*0.63,
                    //color: Colors.red,
                      child: Text("Package ID-$id",overflow:TextOverflow.ellipsis,maxLines: 1, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)
                  ),

                  SizedBox(width: 3,),
                  Text("$currency $price",style: TextStyle(color: priceColor,fontSize: 15,fontWeight:FontWeight.w600),)
                ],
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(" Wifi Plan - $name",overflow:TextOverflow.ellipsis,maxLines: 1, style: TextStyle(color: Colors.grey,fontSize: 13),),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text("$dateTime",overflow:TextOverflow.ellipsis,maxLines: 1, style: TextStyle(color: Colors.grey,fontSize: 13),),
                      ),
                    ],
                  ),
                  // SizedBox(width: 5,),
                  Text("$validity Days",style: TextStyle(color: Colors.grey,fontSize: 13)),



                ],
              ),
              SizedBox(height: 10.h,),
              Container(
                //height: 22.h,
                // width: 57.w,
                decoration: BoxDecoration(
                    color: Color(0xFFFFEBF2),
                    borderRadius: BorderRadius.circular(22)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.wifi,color: Color(0xFFD93C54),size: 14,),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text('Wifi',style: TextStyle(color: Color(0xFFD93C54),fontSize: 12),),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      SizedBox(height: 10,)
    ],
  );
}



// Widget noWifiScreen(context) {
//   final double height = MediaQuery.of(context).size.height;
//   final double width = MediaQuery.of(context).size.width;
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//
//         //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SizedBox(
//             height: 40.h,
//           ),
//           Container(
//             width: double.infinity,
//             child: Center(
//               child: Image(
//                 image: AssetImage(
//                   "assets/images/notification.png",
//                 ),
//                 width: 200.w,
//                 height: 200.h,
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 40.h,
//           ),
//           Text(
//             "Oh No!",
//             style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 24.sp,
//                 fontWeight: FontWeight.w500,
//                 height: 1.5),
//           ),
//           Text(
//             "It looks like something went wrong\n try again",
//             style: TextStyle(
//                 color: Colors.grey.shade500,
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.w400,
//                 height: 1.3),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//       Padding(
//         padding: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
//         child: Column(
//           children: [
//             CustomButton(
//               height: height * 0.07,
//               width: double.infinity,
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               text: AppLocalizations.of(context)!.translate('setting')!,
//             ),
//             SizedBox(height: 10.h),
//             Container(
//               width: double.infinity,
//               height: 50.h,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   elevation: 0,
//                   textStyle: GoogleFonts.poppins(
//                       fontSize: 14, fontWeight: FontWeight.w500),
//                   shape: new RoundedRectangleBorder(
//                     borderRadius: new BorderRadius.circular(10.0),
//                   ),
//                   primary: Color(0xFFFFEBF2),
//                 ),
//                 child: new Text(
//                   "Contact Support",
//                   textAlign: TextAlign.center,
//                   style: GoogleFonts.poppins(
//                       color: Theme.of(context).primaryColor,
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w500,
//                       letterSpacing: 1),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ],
//   );
// }