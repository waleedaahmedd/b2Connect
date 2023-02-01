import 'dart:convert';
import 'package:b2connect_flutter/model/models/history_refill.dart';
import 'package:b2connect_flutter/model/package_detail_model.dart';
import 'package:b2connect_flutter/view_model/providers/Repository/repository_pattern.dart';
import 'package:b2connect_flutter/view_model/providers/pay_by_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:salesiq_mobilisten/salesiq_mobilisten.dart';
import '../../model/models/banners_model.dart';
import '../../model/models/userinfo_model.dart';
import '../../model/models/verify_otp.dart';
import '../../model/models/notification_model.dart';
import '../../model/services/http_service.dart';
import '../../model/services/navigation_service.dart';
import '../../model/services/storage_service.dart';
import '../../model/services/util_service.dart';
import '../../model/utils/routes.dart';
import '../../model/utils/service_locator.dart';
import '../../view/widgets/showOnWillPop.dart';
import 'offers_provider.dart';

//
class AuthProvider with ChangeNotifier {
  String _phoneNumber = '';
  String? _ipaddress = '';
  String _macaddress = '';
  String _token = '';
  String _uid = '';
  String _appVersion = '';
  String? fcmToken;
  bool notificationSeen = false;
  bool? emailNotiOnOFF;
  bool? inAppNotiONOFF;
  bool? changeInEid = false;
  bool? changeInExpiry = false;
  String? expiryDate;
  String? emiratesIdTextMask1;
  String? emiratesIdTextMask2;
  String? emiratesIdTextMask3;
  String? emiratesIdTextMask4;
  String? expiryDateController;
  List<String> emiratesIdList = [];
  List<BannersModel> homeBannerData = [];
  List<BannersModel> otherBannerData = [];

  int? reasonId;

  List<BannersModel> bannerData = [];

  // List<AdvertismentModel> bannerData = [];
  List<NotificationModel> notificationData = [];

  UserInfoModel? userInfoData;

  //PackageOrdersModel? packageOrderModelData;
  List<PackageOrdersModel> packageOrderModelData = [];
  PackageDetails? packageDetails;

  //List<RefillHistory> refillHistoryData=[];
  // List imgList = [];
  // List onClickAgainstImg = [];

  Repository? http = HttpService();
  NavigationService navigationService = locator<NavigationService>();
  StorageService storageService = locator<StorageService>();
  UtilService utilsService = locator<UtilService>();

  get getPhoneNumber {
    return this._phoneNumber;
  }

  get getIpAddress {
    return this._ipaddress;
  }

  get getMacAddress {
    return this._macaddress;
  }

  get gettoken {
    return this._token;
  }

  get getUID {
    return this._uid;
  }

  get getAppVersion {
    return this._appVersion;
  }

  get getNotificationSeen {
    return this.notificationSeen;
  }

  get getEmailONOFF {
    return this.emailNotiOnOFF;
  }

  get getInAppONOFF {
    return this.inAppNotiONOFF;
  }

  // get getImgList{
  //   return this._imgList;
  // }
  // get getOnClickAgainstImg{
  //   return this._onClickAgainstImg;
  // }

  Future<dynamic> callOTP(String number) async {
    try {
      var response = await http!.sendOTP(number);
      if (response == 'OK') {
        //navigationService.closeScreen();

      } else {
        //navigationService.closeScreen();
        return utilsService.showToast('Please Check Phone Number');
      }
    }
    on PlatformException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Something went wrong please try again');
      print(e);
    }
    catch(e){
      EasyLoading.dismiss();
      EasyLoading.showError('Something went wrong please try again');
      print(e);
    }
  }

  Future<dynamic> updateUserInfo(
      BuildContext context,
      String location,
      String property,
      String room,
      int spinDate,
      String spinResult,
      String firstName,
      String lastName) async {
    try {
      var response = await http!.updateUserInfo(
          _uid,
          location,
          property,
          room,
          spinDate,
          spinResult,
          firstName,
          lastName);

      if (response.statusCode == 200) {
        // EasyLoading.showSuccess('Verified Successfully');
        //  utilService.showToast('Sending data successfully');
      } else {
        utilsService.showToast('Please fill all location related fields');

        //EasyLoading.showError('Please fill all location related fields');
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

  Future<dynamic> deleteUserAccount(BuildContext context) async {
    EasyLoading.show(status: 'Please Wait...');
    try {
      var response = await http!.deleteAccount(reasonId: reasonId!);
      if (response.statusCode == 200) {
        print(response);
        EasyLoading.showSuccess('Account Deleted Successfully');
        ZohoSalesIQ.unregisterVisitor();
        await storageService.setBoolData('isShowHome', false);
        navigationService.navigateTo(LoginScreenRoute);
        Provider.of<PayByProvider>(context, listen: false).getTotalCartCount(0);
        context.read<OffersProvider>().b2PayTag = true;
        return 'Success';
      } else {
        EasyLoading.showError('Something went wrong');
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

  Future<dynamic> callVerifyOTP(context, String number, String code,
      String? ipAddress, String deviceMac) async {
    try {
      var response =
      await http!.verifyOTP(context, number, code, ipAddress, deviceMac);

      if (response.statusCode == 200) {
        print('response is not empty');
        // print('this is  response status${response.statusCode}');
        // print('type 1${json.decode(response.body).runtimeType}');
        Token data = Token.fromJson(json.decode(response.body));
        Provider.of<AuthProvider>(context, listen: false)
            .saveToken(data.token.toString());
        print(
            'this is provider token--${Provider
                .of<AuthProvider>(context, listen: false)
                .gettoken}');

        await storageService.setData('token', data.token.toString());
        await storageService.setData('appVersion', this._appVersion);

        // await Provider.of<AuthProvider>(context, listen: false).callUserInfo(context).then((value) async {
        //   Provider.of<AuthProvider>(context, listen: false).saveUid(value.uid.toString());
        //   print('UID--${Provider.of<AuthProvider>(context, listen: false).getUID}');
        //
        //   print('value.profileValidToUt---value--${value.profileValidToUT}');
        //   userInfoData=value;
        //   await Provider.of<AuthProvider>(context, listen: false).callAdvert();
        //
        // });

        return "Done";
        //navigationService.navigateTo(HomeScreenRoute);
      } else {
        return "Wrong";
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

  Future<dynamic> callLogin(
      String number, String? ipAddress, String deviceMac) async {
    try {
      var response = await http!.login(number, ipAddress, deviceMac);
      if (response.statusCode == 404) {

        print('i get into 404 send otp called');
        await callOTP(number);
        //return navigationService.navigateTo(WelcomeScreenRoute);
      } else if (response.statusCode == 200) {
        print('successfull signUp');
       // return navigationService.navigateTo(HomeScreenRoute);
      } else {
        EasyLoading.showError('Something went wrong please try again');

        print('status code is different');

        //return utilsService.showToast("Wrong Credentials, Please Enter again");
      }
    } on PlatformException catch (e) {
      EasyLoading.showError('$e');
      print(e);
    }
    catch(e){
      EasyLoading.showError('$e');
      print(e);
    }
  }

  Future<dynamic> callResetLogin(String number) async {
    try {
      var response = await http!.sendResetPassword(number);
      if (response.statusCode == 200) {
        print('password reset successfully!!!');

        return navigationService.navigateTo(SignupScreenRoute);
        //return navigationService.navigateTo(WelcomeScreenRoute);
      } else {
        print('password reset error!!!');

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

  Future<List<BannersModel>> callAdvert() async {
    try {
      //List<AdvertismentModel> saveData=[];
      bannerData.clear();
      homeBannerData.clear();
      otherBannerData.clear();
      var response = await http!.advertisement();

      if (response.statusCode == 200) {
        for (var abc in response.data) {
          saveBannerData(BannersModel.fromJson(abc));
        }
        //saveBannerData(bannerData);

        // saveAdvertData.forEach((element) {
        //
        //   imgList.clear();
        //
        //   onClickAgainstImg.clear();
        //
        //   //DefaultCacheManager().downloadFile(element.mediaUrLs.toString()).then((_) {});
        //   imgList.add(element.mediaUrLs?[0].toString());
        //   onClickAgainstImg.add(element.clickRedirectTo.toString());
        //
        // });
        // print('rizwan2');
        // saveAdvertData.add(data);

        return bannerData;
      } else {
        //print('password reset error!!!');

        return utilsService.showToast('Fail to load Banners');
      }
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
      return bannerData;
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
    }
    return bannerData;
  }

/*
  Future<List<AdvertismentModel>> callAdvert() async {
    try {
      //List<AdvertismentModel> saveData=[];
      bannerData.clear();
      var response = await http!.advertisement();

      if (response.statusCode == 200) {
        for (var abc in response.data) {
          saveBannerData(AdvertismentModel.fromJson(abc));
        }
        //saveBannerData(bannerData);

        // saveAdvertData.forEach((element) {
        //
        //   imgList.clear();
        //
        //   onClickAgainstImg.clear();
        //
        //   //DefaultCacheManager().downloadFile(element.mediaUrLs.toString()).then((_) {});
        //   imgList.add(element.mediaUrLs?[0].toString());
        //   onClickAgainstImg.add(element.clickRedirectTo.toString());
        //
        // });
        // print('rizwan2');
        // saveAdvertData.add(data);

        return bannerData;
      } else {
        print('password reset error!!!');

        return utilsService.showToast('Fail to load Banners');
      }
    } catch (e) {
      print('this is exception  $e');
      return utilsService.showToast(e.toString());
    }
  }
*/

  Future<dynamic> callUserInfo(BuildContext context) async {
    try {
      var response = await http!.userInfo();
      if (response.statusCode == 200) {
        print('i get into 200');

        UserInfoModel data = UserInfoModel.fromJson(json.decode(response.body));

        //saveUserInfo(UserInfoModel.fromJson(json.decode(response.body)));

        //  userInfoData = UserInfoModel.fromJson(json.decode(response.body));
        saveUserDetail(data);
        saveEmiratesExpiry(data.emiratesExpiry);
        emiratesIdList.clear();
        /*if (data.emiratesId! == "") {
          saveEmiratesId([]);
        }
        else{*/
        saveEmiratesId(data.emiratesId!.split("-"));
        /* }*/

        //TODO: SET USER DATA ANALYTICS

        //  await _analytics!.setUserProperty(name: 'login', value: this.userInfoData!.uid);

        return data;
        //return navigationService.navigateTo(WelcomeScreenRoute);
      } else {
        ZohoSalesIQ.unregisterVisitor();
        await storageService.setBoolData('isShowHome', false);
        navigationService.navigateTo(LoginScreenRoute);
        Provider.of<PayByProvider>(context, listen: false).getTotalCartCount(0);
        context.read<OffersProvider>().b2PayTag = true;
        return utilsService.showToast("Something went wrong, Please Try again");
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

  Future<List<NotificationModel>> callNotifications(
      context, String pages, String perPage) async {
    try {
      var response = await http!.notifications(pages, perPage);

      if (response.statusCode == 200) {
        print('reponse${response.data}');
        //var jsonDecode= json.decode(response.body);
        notificationData.clear();

        for (var abc in response.data) {
          notificationData.add(NotificationModel.fromJson(abc));
        }

        // if(notificationData.isNotEmpty){
        //   Provider.of<AuthProvider>(context,listen:false ).notificationSeen=true;
        // }

        notificationData.forEach((element) {
          print('data from function${element.title}');
        });

        return notificationData;
      } else {
        print('password reset error!!!');

        return utilsService.showToast('Fail to load notifications');
      }
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
      return notificationData;
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
      return notificationData;
    }
  }

  Future<dynamic> callPackageOrderDetail(int id) async {
    try {
      var response = await http!.packageOrdersDetail(id);
      if (response.statusCode == 200) {
        print('response--${response.data["items"]}');

        savePackageDetails(PackageDetails.fromJson(response.data));

        print(packageDetails);
      } else {
        return "failed";
        //utilsService.showToast("Something went wrong, Please Enter again");
      }
      EasyLoading.dismiss();
    } on PlatformException catch (e) {
      EasyLoading.dismiss();
      print(e);
    }
    catch(e){
      EasyLoading.dismiss();
      print(e);
    }
  }

  Future<dynamic> callPackageOrder() async {
    try {
      var response = await http!.packageOrders();
      if (response.statusCode == 200) {
        print('response--${response.data["items"]}');
        packageOrderModelData.clear();
        //PackageOrdersModel  packageOrderModelData1 =PackageOrdersModel.fromJson(response.data);
        for (var abc in response.data["items"]) {
          savePackageOrdersModel(PackageOrdersModel.fromJson(abc));
        }

        print('response-fgf-${packageOrderModelData.length}');

        if (packageOrderModelData.length > 0) {
          return packageOrderModelData;
        } else {
          //print('i get into else of transctions-----');
          packageOrderModelData = [];
          return "failed";
        }
      } else {
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

  // Future<dynamic> callHistoryRefill() async {
  //   try {
  //     var response = await http!.historyRefill();
  //     print('response--${response.data}');
  //     if (response.statusCode == 200) {
  //
  //
  //       print('response--${response.data}');
  //       refillHistoryData.clear();
  //       for(var abc in response.data){
  //         saveRefillHistory(RefillHistory.fromJson(abc));
  //       }
  //       // refillHistoryData.forEach((element) {
  //       //   print(element.price);
  //       // });
  //
  //
  //       //print('response--${response.data}');
  //
  //       if(refillHistoryData.isNotEmpty){
  //
  //         return refillHistoryData;
  //
  //       }
  //       else{
  //
  //         refillHistoryData=[];
  //         return "failed";
  //       }
  //
  //     } else {
  //       return "failed";
  //       //utilsService.showToast("Something went wrong, Please Enter again");
  //     }
  //   } catch (e) {
  //     print(e);
  //     return "failed";
  //     //utilsService.showToast(e.toString());
  //   }
  // }

  Future<dynamic> callFcmToken(String token) async {
    try {
      var response = await http!.fcmToken(token);
      if (response.statusCode == 200) {
        print('fcm token save in DB');
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

  setEmailONOFF(bool value) {
    this.emailNotiOnOFF = value;
    notifyListeners();
  }

  setInAppONOFF(bool value) {
    this.inAppNotiONOFF = value;
    notifyListeners();
  }

  savePhneNumber(String number) {
    this._phoneNumber = number;
    notifyListeners();
  }

  saveUid(String uid) {
    this._uid = uid;
    notifyListeners();
  }

  setReasonId(int value) {
    this.reasonId = value;
    notifyListeners();
  }

  saveIpAddress(String? ipAddress) {
    this._ipaddress = ipAddress;
    notifyListeners();
  }

  saveMacAddress(String macAddress) {
    this._macaddress = macAddress;
    notifyListeners();
  }

  saveToken(String token) {
    this._token = token;
    notifyListeners();
  }

  saveAppVersion(String version) {
    this._appVersion = version;
    notifyListeners();
  }

  saveUserDetail(UserInfoModel value) {
    userInfoData = value;
    notifyListeners();
  }

// saveNotificationSeen(bool value) {
//   this.notificationSeen = value;
//   notifyListeners();
// }
/* saveUserInfo(UserInfoModel value){
    this.userInfoData=value;
    notifyListeners();
 }*/

  saveBannerData(BannersModel value) {
    this.bannerData.add(value);
    if (value.location == 'home') {
      setHomeBannerData(value);
    }
    notifyListeners();
  }

  setHomeBannerData(BannersModel value) {
    this.homeBannerData.add(value);
    notifyListeners();
  }

  setOtherBannersData(String value) {
    otherBannerData.clear();
    this.otherBannerData.addAll(
        bannerData.where((element) => element.location == value).toList());
    notifyListeners();
  }

  /* saveBannerData(AdvertismentModel value) {
    this.bannerData.add(value);
    notifyListeners();
  }*/

  saveFcmToken(String value) {
    this.fcmToken = value;
    notifyListeners();
  }

  // saveRefillHistory(RefillHistory value){
  //   refillHistoryData.add(value);
  //   notifyListeners();
  //
  // }

  savePackageOrdersModel(PackageOrdersModel value) {
    packageOrderModelData.add(value);
    notifyListeners();
  }

  saveEmiratesExpiry(int? timestamp) {
    var eidExpiryDate = DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000);
    expiryDate = DateFormat('dd/MM/yyyy').format(eidExpiryDate);
  }

  saveEmiratesId(List<String> emiratesId) {
    emiratesIdList.addAll(emiratesId);
    notifyListeners();
  }

  saveEmiratesIdTextMask1(String value) {
    emiratesIdTextMask1 = value;
    notifyListeners();
  }

  saveEmiratesIdTextMask2(String value) {
    emiratesIdTextMask2 = value;
    notifyListeners();
  }

  saveEmiratesIdTextMask3(String value) {
    emiratesIdTextMask3 = value;
    notifyListeners();
  }

  saveEmiratesIdTextMask4(String value) {
    emiratesIdTextMask4 = value;
    notifyListeners();
  }

  saveExpiryDateController(String value) {
    expiryDateController = value;
    notifyListeners();
  }

  saveChangeInEid(bool value) {
    this.changeInEid = value;
    notifyListeners();
  }

  saveChangeInExpiry(bool value) {
    this.changeInExpiry = value;
    notifyListeners();
  }

  savePackageDetails(PackageDetails value) {
    this.packageDetails = value;
    notifyListeners();
  }

  clearEmiratesEditData() {
    saveEmiratesIdTextMask1('');
    saveEmiratesIdTextMask2('');
    saveEmiratesIdTextMask3('');
    saveEmiratesIdTextMask4('');
    saveExpiryDateController('');
  }
}
