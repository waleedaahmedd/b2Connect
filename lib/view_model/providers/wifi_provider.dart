import 'dart:convert';
import 'package:b2connect_flutter/model/models/wifi_plan_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../model/models/activate_corporate_model.dart';
import '../../model/models/wifi_package_model.dart';
import '../../model/services/http_service.dart';
import '../../model/services/navigation_service.dart';
import '../../model/services/storage_service.dart';
import '../../model/services/util_service.dart';
import '../../model/utils/service_locator.dart';
import 'Repository/repository_pattern.dart';

class WifiProvider extends ChangeNotifier {
  Repository? http = locator<HttpService>();
  NavigationService navigationService = locator<NavigationService>();
  StorageService storageService = locator<StorageService>();
  UtilService utilsService = locator<UtilService>();

  List<WifiModel> wifiData = [];
  WifiPlanModel? wifiPlanData;
  bool noWifiAvailable = false;

  Future<dynamic> activateCorporateWifi() async {
    try {
      var response = await http!.payWifiCorporate();
      ActivateCorporateModel data = ActivateCorporateModel.fromJson(json.decode(response.body));

      if (response.statusCode == 200) {
        EasyLoading.showSuccess(data.message!);
        return 'Success';
  
      } else {
        EasyLoading.showError(data.message!);
        return 'failed';
      }
    } on PlatformException catch (e) {
      EasyLoading.showError('Something went wrong');
      print(e);
    }
    catch(e){
      EasyLoading.showError('Something went wrong');
      print(e);
    }
  }

  Future<dynamic> callWifi() async {

    try {
      var response = await http!.wifi();
      if (response.statusCode == 200) {
        var usersjson = await json.decode(response.body);

        for (var userjson in usersjson) {

          setWifiData(WifiModel.fromJson(userjson));

        }
        /*wifiData.forEach((element) {
          print('${element.id}');
        });*/

        wifiData.isEmpty? setNoWifiAvailable(true) : setNoWifiAvailable(false);

        return wifiData;
      } else {
        print('failed to get data from userinfo');
        EasyLoading.dismiss();

        return "failed";
        //utilsService.showToast("Something went wrong, Please Enter again");
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

  Future<dynamic> callWifiPlan() async {
    try {
      var response = await http!.wifiPlan();
      if (response.statusCode == 200) {

        saveWifiPlanData(WifiPlanModel.fromJson(response.data));
        print('from api$wifiPlanData');

        if(wifiPlanData!=null){
          return wifiPlanData;
        }
        else{
          return "failed";
        }
      } else {
        return "failed";
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


  saveWifiPlanData(WifiPlanModel value){
    wifiPlanData=value;
    notifyListeners();
  }

  void setWifiData(WifiModel wifiModel) {
    this.wifiData.add(wifiModel);
    notifyListeners();
  }

  void setNoWifiAvailable(bool value) {
    this.noWifiAvailable = value;
    notifyListeners();
  }




}
