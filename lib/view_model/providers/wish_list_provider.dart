import 'package:b2connect_flutter/model/models/offers_models/offers_list_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../model/services/http_service.dart';
import '../../model/services/navigation_service.dart';
import '../../model/services/storage_service.dart';
import '../../model/services/util_service.dart';
import '../../model/utils/service_locator.dart';

class WishListProvider extends ChangeNotifier {
  HttpService? http = locator<HttpService>();
  NavigationService navigationService = locator<NavigationService>();
  StorageService storageService = locator<StorageService>();
  UtilService utilsService = locator<UtilService>();


  List<OffersList> wishListData = [];
  bool? showLoader;


  Future<dynamic> showWishList() async {
    wishListData.clear();
    try {
      var response = await http!.showWishList();
      if (response.statusCode == 200) {

        var usersjson = response.data;

        for (var userjson in usersjson) {
          saveWishList(OffersList.fromJson(userjson));
        }
        if(wishListData.isNotEmpty){
          //saveWishList(wishListData);
          return wishListData;
        }

        else
          return "Failed";
      } else {
        print('failed to get data from userinfo');

        return "Failed";
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



  Future<dynamic> addToWishList(String id) async {
    try {
      var response = await http!.addWishList(id);
      if (response.statusCode == 200) {
        print('added suncessfull');
        return 'ok';
      } else {
        print('failed to get data from userinfo');

        return "Failed";
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

  Future<dynamic> deleteFromWishList(String id) async {
    try {
      var response = await http!.deleteFromWishList(id);
      if (response.statusCode == 200) {
        //print('delete suncessfull');
        return 'ok';
      } else {
        print('failed to get data from userinfo');

        return "Failed";
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

  Future<bool> checkWishList(String id) async {
    try {
      var response = await http!.checkWishList(id);
      if (response.statusCode == 200) {
        return response.data;
      }
      else {
        return false;
      }
    }

    on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
      return false;
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
      return false;
    }
  }


  saveWishList(OffersList value){
    wishListData.add(value);
    notifyListeners();
  }
  removeFromWishList(int value){
    wishListData.removeWhere((element) => element.id==value);  //addAll(value);
    notifyListeners();
  }
  setLoader(bool value){
    showLoader=value;
    notifyListeners();
  }
}
