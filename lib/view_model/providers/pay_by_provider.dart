import 'dart:convert';

import 'package:b2connect_flutter/model/models/offer_item_list_model.dart';
import 'package:b2connect_flutter/model/models/offers_models/offers_order_model.dart';
import 'package:b2connect_flutter/model/models/package_order_model.dart';
import 'package:b2connect_flutter/model/models/pay_by_success_model.dart';
import 'package:b2connect_flutter/model/models/service_order_model.dart';
import 'package:b2connect_flutter/model/services/http_service.dart';
import 'package:b2connect_flutter/model/services/navigation_service.dart';
import 'package:b2connect_flutter/model/utils/routes.dart';
import 'package:b2connect_flutter/model/utils/service_locator.dart';
import 'package:b2connect_flutter/view/screens/success_screen.dart';
import 'package:b2connect_flutter/view_model/providers/offers_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'Repository/repository_pattern.dart';

class PayByProvider with ChangeNotifier {
  String topUpMobileNumber = "";
  OffersOrder? _offersOrder;
  ServiceOrder? _serviceOrder;
  PackageOrder? _packageOrder;
  PayBySuccessModel? payBySuccessModel;
  List<OfferItems> offerItemsOrder = [];
  List<OfferItems> serviceItemsOrder = [];

  String deviceId = "";
  String paymentOrderId = "";

  String comment = "";
  String salesAgentCode = "";
  bool isInstallment = false;
  String? orderNumber;
  OfferItems? offer;
  Repository? http = HttpService();
  int? totalCartCount;
  int tenure = 0;
  bool isAddon = false;
  bool payLater = false;

  var _navigationService = locator<NavigationService>();

  static const platform = MethodChannel('PayBy.Method.Channel');

  Future<dynamic> payByOffersOrder(BuildContext context) async {
    try {
      var response = await http!.payByOffersOrder(
        this.offerItemsOrder,
        this.deviceId,
        this.comment,
        this.salesAgentCode,
        this.isInstallment,
        this.tenure,
        this.isAddon,
      );

      if (response.statusCode == 200) {
        _offersOrder = OffersOrder.fromJson(json.decode(response.body));
        if (_offersOrder!.success == true) {
          print(_offersOrder);
          isInstallment = false;
          comment = "";
          salesAgentCode = "";
          startPay(deviceId, 'products', context);
          EasyLoading.showSuccess('Verified Successfully');
        }

        //  utilService.showToast('Sending data successfully');
      } else {
        EasyLoading.showError('Please check your verification');
        return null;
      }
    }
    on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
    }
  }

  Future<dynamic> payByServiceOrder(BuildContext context) async {
    try {
      var response = await http!.payByServiceOrder(
        this.serviceItemsOrder,
        this.deviceId,
        this.comment,
        this.salesAgentCode,
        this.isInstallment,
        this.topUpMobileNumber,
      );

      if (response.statusCode == 200) {
        _serviceOrder = ServiceOrder.fromJson(json.decode(response.body));
        if (_serviceOrder!.success == true) {
          print(_serviceOrder);
          isInstallment = false;
          comment = "";
          salesAgentCode = "";
          EasyLoading.showSuccess('Verified Successfully');
          startPay(deviceId, 'services', context);
        }

        //  utilService.showToast('Sending data successfully');
      } else {
        EasyLoading.showError('Please check your verification');
        return null;
      }
    }
    on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
    }
  }

  Future<dynamic> cashOffersOrder(BuildContext context) async {
    try {
      var response = await http!.cashOffersOrder(
          this.offerItemsOrder,
          this.isInstallment,
          this.comment,
          this.salesAgentCode,
          this.tenure,
          this.isAddon
      );

      if (response.statusCode == 200) {
        _offersOrder = OffersOrder.fromJson(json.decode(response.body));
        if (_offersOrder!.success == true) {
          print("cash done---$_offersOrder");
          orderNumber = _offersOrder!.salesOrderNo.toString();
          comment = "";
          salesAgentCode = "";

          // paymentOrderId = _offersOrder!.paymentOrderId.toString();

          // EasyLoading.showSuccess('Verified Successfully');
          // startPay(deviceId, 'products');
          Provider.of<OffersProvider>(context, listen: false).clearAllData();
          /* Provider.of<OffersProvider>(context, listen: false).totalPriceNow = 0.0;
        Provider.of<OffersProvider>(context, listen: false)
            .updated3xInstallmentPrice = 0.0;
        Provider.of<OffersProvider>(context, listen: false).installment3xPrice =
            0.0;*/
          //Provider.of<OffersProvider>(context, listen: false).cartData.clear();
          offerItemsOrder.clear();
          getTotalCartCount(0);
          context
              .read<OffersProvider>()
              .b2PayTag = true;

          Provider
              .of<OffersProvider>(context, listen: false)
              .onlySmartPhone =
          false;
          context.read<OffersProvider>().clearCartData();
          context
              .read<OffersProvider>()
              .onlySmartPhone = false;
          context
              .read<OffersProvider>()
              .showLoader = true;
          EasyLoading.dismiss();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SuccessScreen(
                        comingFrom: 'cash',
                      )));
          //_navigationService.navigateTo(SuccessScreenRoute);
        }

        //  utilService.showToast('Sending data successfully');
      } else {
        EasyLoading.showError("The Purchase can't be done at the moment");
        return null;
      }
    }
    on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
    }
  }

  Future<dynamic> payByPackageOrder(
      BuildContext context, int? packageId) async {
    try{
    var response = await http!.payByPackageOrder(
      packageId!,
      this.deviceId,
    );

    if (response.statusCode == 200) {
      _packageOrder = PackageOrder.fromJson(json.decode(response.body));
      if (_packageOrder!.success == true) {
        print(_packageOrder);
        EasyLoading.showSuccess('Verified Successfully');
        startPay(deviceId, 'package', context);
        /*Provider.of<OffersProvider>(context, listen: false).totalPriceNow=0.0;
        Provider.of<OffersProvider>(context, listen: false).totalPriceLater=0.0;
        Provider.of<OffersProvider>(context, listen: false).cartData.clear();
        Provider.of<OffersProvider>(context, listen: false).productIds.clear();
        Provider.of<OffersProvider>(context, listen: false).onlySmartPhone = false;*/
      }

      //  utilService.showToast('Sending data successfully');
    } else {
      EasyLoading.showError('Please check your verification');
      return null;
    }}
    on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
    }
  }

  Future<void> getPayByDeviceId() async {
    //String deviceId;
    try {
      final String result = await platform.invokeMethod('getDeviceId');
      this.deviceId = '$result';
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      this.deviceId = "${e.message}";
    }
    //  = deviceId;
  }

  Future<void> startPay(
      String deviceId, String payFor, BuildContext context) async {
    // String results;
    if (payFor == 'package') {
      try {
        var args = <String, String>{
          'mToken': _packageOrder!.tokenUrl.toString(),
          'mIapDeviceId': deviceId.toString(),
          'mPartnerId': _packageOrder!.partnerId.toString(),
          'sign': _packageOrder!.signature.toString(),
          'mAppId': _packageOrder!.appId.toString(),
        };
        // print(args);
        platform.setMethodCallHandler((MethodCall call) async {
          if (call.method == 'onCallFinish') {
            //print('onCallFinish = ${call.arguments}');
          }
          if (call.arguments == "SUCCESS") {
            getTotalCartCount(0);
            context.read<OffersProvider>().b2PayTag = true;

            _navigationService.navigateTo(HomeScreenRoute);
          }
        });
        String res = await platform.invokeMethod('startPay', args);
        print(res);
        // results = '$result';
      } on PlatformException catch (e) {
        EasyLoading.dismiss();
        deviceId = "${e.message}";
      }
    } else if (payFor == 'products') {
      try {
        var args = <String, String>{
          'mToken': _offersOrder!.tokenUrl.toString(),
          'mIapDeviceId': deviceId.toString(),
          'mPartnerId': _offersOrder!.partnerId.toString(),
          'sign': _offersOrder!.signature.toString(),
          'mAppId': _offersOrder!.appId.toString(),
        };
        print(args);

        platform.setMethodCallHandler((MethodCall call) async {
          if (call.method == 'onCallFinish') {
            //print('onCallFinish = ${call.arguments}');
          }
          if (call.arguments == "SUCCESS") {
            getTotalCartCount(0);
            context.read<OffersProvider>().b2PayTag = true;
            Provider.of<OffersProvider>(context, listen: false).clearAllData();
            /*Provider.of<OffersProvider>(context, listen: false).totalPriceNow =
                0.0;
            Provider.of<OffersProvider>(context, listen: false)
                .updated3xInstallmentPrice = 0.0;
            Provider.of<OffersProvider>(context, listen: false)
                .installment3xPrice = 0.0;
            Provider.of<OffersProvider>(context, listen: false)
                .cartData
                .clear();*/
            offerItemsOrder.clear();
          /*  Provider.of<OffersProvider>(context, listen: false).onlySmartPhone =
                false;*/
            _navigationService.navigateTo(HomeScreenRoute);
          }
        });
        /*final String result = */
        String res = await platform.invokeMethod('startPay', args);
        print(res);
        /*print(result);
      results = '$result';*/
      } on PlatformException catch (e) {
        EasyLoading.dismiss();
        deviceId = "${e.message}";
      }
    } else {
      try {
        var args = <String, String>{
          'mToken': _serviceOrder!.tokenUrl.toString(),
          'mIapDeviceId': deviceId.toString(),
          'mPartnerId': _serviceOrder!.partnerId.toString(),
          'sign': _serviceOrder!.signature.toString(),
          'mAppId': _serviceOrder!.appId.toString(),
        };
        print(args);

        platform.setMethodCallHandler((MethodCall call) async {
          if (call.method == 'onCallFinish') {
            // print('onCallFinish = ${call.arguments}');

          }

          if (call.arguments == "SUCCESS") {
            EasyLoading.show(status: "Please Wait");
            try {
              var response = await http!
                  .payBySuccess(this._serviceOrder!.internalOrderId.toString());
              print(response.data);
              payBySuccessModel = PayBySuccessModel.fromJson(response.data);
              print(payBySuccessModel);
              if (payBySuccessModel!.serviceUUID != null) {
                orderNumber = payBySuccessModel!.salesOrderNo.toString();
                paymentOrderId = payBySuccessModel!.serviceUUID.toString();
                serviceItemsOrder.clear();
               /* var count = 0;
                Navigator.popUntil(context, (route) {
                  return count++ == 2;
                });*/
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SuccessScreen(
                              comingFrom: 'topup',
                            )));
                EasyLoading.dismiss();
              } else {
                EasyLoading.dismiss();
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
        });
        /*final String result = */
        String res = await platform.invokeMethod('startPay', args);
        print(res);
        /*print(result);
      results = '$result';*/
      } on PlatformException catch (e) {
        EasyLoading.dismiss();
        deviceId = "${e.message}";
      }
    }

    /* print(results);*/
  }

  addServicesToOfferItems(int updatedOfferId) {
    serviceItemsOrder.clear();
    offer = OfferItems(offerId: updatedOfferId, amount: 1);
    serviceItemsOrder.add(offer!);
  }

  addToCartList(int updatedOfferId) {
    int _totalCartItems = 0;

    OfferItems _checkOfferOrders = offerItemsOrder.firstWhere(
        (offer) => offer.offerId == updatedOfferId,
        orElse: () => OfferItems());

    if (_checkOfferOrders.amount == null) {
      offer = OfferItems(offerId: updatedOfferId, amount: 1);
      offerItemsOrder.add(offer!);
      offerItemsOrder.forEach((offer) {
        //getting the key direectly from the name of the key
        _totalCartItems += offer.amount!;
        //totalCartCount = _totalCartItems;
        getTotalCartCount(_totalCartItems);
      });
      print(offerItemsOrder);
    } else {
      int index = offerItemsOrder
          .indexWhere((offer) => offer.offerId == updatedOfferId);
      int _quantity = offerItemsOrder[index].amount!;
      _quantity = _quantity + 1;
      offerItemsOrder[index].amount = _quantity;
      offerItemsOrder.forEach((offer) {
        //getting the key direectly from the name of the key
        _totalCartItems += offer.amount!;
        //totalCartCount = _totalCartItems;
        getTotalCartCount(_totalCartItems);
      });
      print(offerItemsOrder);
    }
  }

  removeItemQuantityFromCartList(int updatedOfferId) {
    int _totalCartItems = 0;
    int index =
        offerItemsOrder.indexWhere((offer) => offer.offerId == updatedOfferId);
    int _quantity = offerItemsOrder[index].amount!;

    _quantity = _quantity - 1;
    offerItemsOrder[index].amount = _quantity;
    offerItemsOrder.forEach((offer) {
      //getting the key direectly from the name of the key
      _totalCartItems += offer.amount!;
      getTotalCartCount(_totalCartItems);
      //totalCartCount = _totalCartItems;
    });
    print(offerItemsOrder);
  }

  removeItemFromCart(int offerId) {
    offerItemsOrder.removeWhere((offer) => offer.offerId == offerId);
    int _totalCartItems = 0;
    offerItemsOrder.forEach((offer) {
      //getting the key direectly from the name of the key
      _totalCartItems += offer.amount!;
      //totalCartCount = _totalCartItems;
    });
    getTotalCartCount(_totalCartItems);

    notifyListeners();
  }

  getTotalCartCount(int cartCount) {
    this.totalCartCount = cartCount;
    notifyListeners();
  }
}
