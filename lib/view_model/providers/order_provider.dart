
import 'package:b2connect_flutter/model/models/offer_transactions.dart';
import 'package:b2connect_flutter/model/models/order_detail_model.dart';
import 'package:b2connect_flutter/model/services/http_service.dart';
import 'package:b2connect_flutter/model/services/util_service.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'Repository/repository_pattern.dart';

class OrderProvider with ChangeNotifier {
  OfferTransactionsModel? offerOrderModelData;
  OrderDetailModel? orderDetailModel;
  Repository? http = HttpService();
  List<Item> orderList = [];
  UtilService utilsService = locator<UtilService>();



  Future<void> callOfferOrder() async {
    EasyLoading.show(status: 'Please Wait...');
    try {
      orderList.clear();
      var response = await http!.offerOrders();
      if (response.statusCode == 200) {
        EasyLoading.dismiss();

       await saveOfferOrderModelData(OfferTransactionsModel.fromJson(response.data));
        //offerOrderModelData =OfferTransactionsModel.fromJson(response.data);
        print('id from ${offerOrderModelData!.items![0].orderId}');

        if(offerOrderModelData!.items!.isNotEmpty){
          setOrderList(offerOrderModelData!.items!);
        }


      } else {
        EasyLoading.showError('Something Went Wrong');
      }
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
    }
  }

  Future<OrderDetailModel?>getOrderDetails(int id) async {

    try {
      var response = await http!.getOrderDetail(id);
      if (response.statusCode == 200) {
        saveOrderDetailModelData(OrderDetailModel.fromJson(response.data));
        EasyLoading.dismiss();
        return orderDetailModel;
      } else {
        EasyLoading.dismiss();
        return utilsService
            .showToast("Something went wrong, Please Enter again");
      }
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
    }
  }

  saveOrderDetailModelData(OrderDetailModel value){
    orderDetailModel=value;
    print(orderDetailModel);
    notifyListeners();
  }
  
  setOrderList(List<Item> value){
    orderList.addAll(value);
    notifyListeners();

  }

  saveOfferOrderModelData(OfferTransactionsModel value){
    offerOrderModelData=value;
    notifyListeners();
  }

}