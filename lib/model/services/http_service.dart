import 'dart:convert';
import 'dart:io';
import 'package:b2connect_flutter/environment_variable/environment.dart';
import 'package:b2connect_flutter/model/models/offer_item_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../../model/services/storage_service.dart';
import '../../model/utils/service_locator.dart';
import '../../view_model/providers/Repository/repository_pattern.dart';
import '../models/points_model.dart';

class HttpService extends Repository {
  final BaseUrl = Environment.apiUrl;

  // final BaseUrl = "https://api.b2connect.me/app";
  StorageService storageService = locator<StorageService>();

  Dio dio = new Dio();

  @override
  Future<dynamic> sendOTP(String phoneNumber) async {
    var jsonDecode;
    try {
      var response = await http
          .post(Uri.parse('$BaseUrl/sign-up/$phoneNumber/send-code'), headers: {
        "Content-Type": "application/json",
        "appVersion": "${await storageService.getData('appVersion')}",
        "appPlatform": "${Platform.operatingSystem}",
      });
      if (response.statusCode == 200)
        jsonDecode = "OK";
      else
        jsonDecode = "ERROR";

      return jsonDecode;
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<dynamic> verifyOTP(context, String number, String code,
      String? ipAddress, String deviceMac) async {
    return await http.post(Uri.parse('$BaseUrl/sign-up/$number/verify'),
        headers: {
          "Content-Type": "application/json",
          "appVersion": "${await storageService.getData('appVersion')}",
          "appPlatform": "${Platform.operatingSystem}",
        },
        body: jsonEncode(<String, String>{
          "code": "$code", //otp
          "incomingZoneLabel": '',
          "ipAddress": "$ipAddress", //190.23.10.23
          "deviceMac": "$deviceMac" //F0:25:B7:97:F7:1F
        }));
  }

  @override
  Future<dynamic> payWifiCorporate() async {
    final response = await http
        .post(Uri.parse('$BaseUrl/pay-by/activate-corporate'), headers: {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    });
    return response;
  }

  @override
  Future<dynamic> deleteAccount({required int reasonId}) async {
    return await http
        .post(Uri.parse('$BaseUrl/sign-up/delete-account?reasonId=$reasonId'), headers: {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    });
  }

  @override
  Future<dynamic> login(
      String number, String? ipAddress, String deviceMac) async {
    return await http.post(
        Uri.parse('$BaseUrl/sign-up/$number/simplified-login'),
        headers: {
          "Content-Type": "application/json",
          "appVersion": "${await storageService.getData('appVersion')}",
          "appPlatform": "${Platform.operatingSystem}",
        },
        body: jsonEncode(<String, String>{
          "incomingZoneLabel": '',
          "ipAddress": "$ipAddress", //190.23.10.23
          "deviceMac": "$deviceMac" //F0:25:B7:97:F7:1F
        }));
  }

  @override
  Future<dynamic> sendResetPassword(String phoneNumber) async {
    return await http
        .post(Uri.parse('$BaseUrl/password/$phoneNumber/reset'), headers: {
      "Content-Type": "application/json",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    });
  }

  @override
  Future<dynamic> advertisement() async {
    return await Dio().get('$BaseUrl/contents/banners');
  }

  @override
  Future<dynamic> userInfo() async {
    print('saved token--${await storageService.getData('token')}');
    return await http.get(Uri.parse('$BaseUrl/user-info'), headers: {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    });
  }

  @override
  Future<dynamic> sendEmiratesData(
      /*String name, String sex, int dateOfBirth,
      String nationality, */
      String emiratesId,
      int expiryDate) async {
    var response = await http.post(
      Uri.parse('$BaseUrl/emirates-id'),
      headers: {
        "Content-Type": "application/json",
        "token": "${await storageService.getData('token')}",
        "appVersion": "${await storageService.getData('appVersion')}",
        "appPlatform": "${Platform.operatingSystem}",
      },
      body: jsonEncode(<String, dynamic>{
        /*  'name': "$name",
        'sex': "$sex",
        'dateOfBirth': dateOfBirth,
        'nationality': "$nationality",*/
        'emiratesId': "$emiratesId",
        'expiryDate': expiryDate
      }),
    );
    print("${await storageService.getData('token')}");

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  @override
  Future<dynamic> wifi() async {
    final response = await http.get(Uri.parse('$BaseUrl/packages/available'), headers: {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    });
    return response;
    //JZD3pxSU3xsCwy4xk1J4oTPzQf0VIcQdZ//UvQiNmhwINN0r2nZtRoO226f6D7e4
    // ${await storageService.getData('token')}
  }

  @override
  Future<PointsModel> pointsApi() async {
    final response = await http.get(Uri.parse('https://doc.b2connect.me/points.json'));
    var pointsJson = await json.decode(response.body);
    PointsModel pointModelResponse = PointsModel.fromJson(pointsJson);
    print(pointModelResponse);
    return pointModelResponse;
    //JZD3pxSU3xsCwy4xk1J4oTPzQf0VIcQdZ//UvQiNmhwINN0r2nZtRoO226f6D7e4
    // ${await storageService.getData('token')}
  }

/*  @override
  Future<dynamic> wifiPackagesID(String id) async {
    return await http.get(Uri.parse('$BaseUrl/packages/$id'), headers: {
      "token":
      "JZD3pxSU3xsCwy4xk1J4oTPzQf0VIcQdZ//UvQiNmhwINN0r2nZtRoO226f6D7e4",
    });
    //JZD3pxSU3xsCwy4xk1J4oTPzQf0VIcQdZ//UvQiNmhwINN0r2nZtRoO226f6D7e4
    // ${await storageService.getData('token')}
  }*/

  @override
  Future<dynamic> notifications(
    String pages,
    String perPage,
  ) async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };

    return await dio
        .get('$BaseUrl/notifications?page=$pages&per_page=$perPage');

    //JZD3pxSU3xsCwy4xk1J4oTPzQf0VIcQdZ//UvQiNmhwINN0r2nZtRoO226f6D7e4
    // ${await storageService.getData('token')}
  }

  @override
  Future<dynamic> packageOrders() async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };

    return await dio.get('$BaseUrl/package-orders');
  }

  @override
  Future<dynamic> packageOrdersDetail(int id) async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };

    return await dio.get('$BaseUrl/package-orders/$id');
  }

  @override
  Future<dynamic> historyRefill() async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };

    return await dio.get('$BaseUrl/refill-history');
  }

  @override
  Future<dynamic> offerOrders() async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };

    return await dio.get('$BaseUrl/offer-orders');

    //aIQIBDoSQtvviq2D0D6dbJNkwRLROkd1I9CU/tm6kTHQzCUbxeQT57KyLhUsJbgT
    // ${await storageService.getData('token')}
  }

  @override
  Future getOffers(
      int? page,
      int? perPage,
      int? categoryId,
      String? sortBy,
      String? filterBy,
      String? filterByStock,
      String? name,
      int? minPrice,
      int? maxPrice) async {
    final String pageData = page == null ? 'page=' : 'page=$page';
    final String perPageData =
        perPage == null ? 'per-page=' : 'per-page=$perPage';
    final String categoryIdData =
        categoryId == null ? 'category-id=' : 'category-id=$categoryId';
    final String sortByData = sortBy == null ? 'sort-by=' : 'sort-by=$sortBy';
    final String filterByData =
        filterBy == null ? 'filter-by=' : 'filter-by=$filterBy';
    final String filterByStockData = filterByStock == null
        ? 'filter-by-stock='
        : 'filter-by-stock= $filterByStock';
    final String nameData = name == null ? 'name=' : 'name=$name';
    final String minPriceData =
        minPrice == null ? 'min-price=' : 'min-price=$minPrice';
    final String maxPriceData =
        maxPrice == null ? 'max-price=' : 'max-price= $maxPrice';

    final data = await http.get(
      Uri.parse(
          '$BaseUrl/offers?$pageData&$perPageData&$categoryIdData&$sortByData&$filterByData&$filterByStockData&$nameData&$minPriceData&$maxPriceData'),
    );
    print(data.body);

    return data;
  }

  @override
  Future getProductsDetails(String id) async {
    return await http.get(
      Uri.parse('$BaseUrl/offers/$id'),
    );
  }

  @override
  Future productCategories() async {
    return await dio.get('$BaseUrl/offers/categories');
  }

  @override
  Future addWishList(String id) async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };
    return await dio.post('$BaseUrl/wish-list/offers/$id');
  }

  @override
  Future deleteFromWishList(String id) async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };
    return await dio.delete('$BaseUrl/wish-list/offers/$id');
  }

  @override
  Future showWishList() async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };
    return await dio.get('$BaseUrl/wish-list/offers');
  }

  @override
  Future checkWishList(String id) async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };
    return await dio.get('$BaseUrl/wish-list/offers/$id/check');
  }

  @override
  Future wifiPlan() async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };
    return await dio.get('$BaseUrl/packages/current');
  }

  @override
  Future<dynamic> payBySuccess(internalOrderId) async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };
    var response = await dio.post(
        '$BaseUrl/pay-by/offers/service-order/$internalOrderId/validate-payment');
    return response;
  }

  @override
  Future fcmToken(String token) async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };
    return await dio.post('$BaseUrl/fcm-token/update',
        data: jsonEncode({"fcmToken": "$token"}));
  }

  @override
  Future<dynamic> updateUserInfo(
      String contactPhone,
      String location,
      String property,
      String room,
      int spinDate,
      String spinResult,
      String firstName,
      String lastName) async {
    var response = await http.patch(
      Uri.parse('$BaseUrl/user-info'),
      headers: {
        "Content-Type": "application/json",
        "token": "${await storageService.getData('token')}",
        "appVersion": "${await storageService.getData('appVersion')}",
        "appPlatform": "${Platform.operatingSystem}",
      },
      body: jsonEncode(<String, dynamic>{
        'contactPhone': "$contactPhone",
        'location': "$location",
        'property': property,
        'room': "$room",
        '_spinDate': spinDate,
        '_spinResult': "$spinResult",
        'firstName': "$firstName",
        'lastName': "$lastName"
      }),
    );
    print("${await storageService.getData('token')}");
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  @override
  Future<dynamic> payByOffersOrder(
      List<OfferItems> offerItems,
      String deviceId,
      String comment,
      String salesAgentCode,
      bool isInstallment,
      int tenure,
      bool isAddon) async {
    var response = await http.post(
      Uri.parse('$BaseUrl/pay-by/offers/order'),
      headers: {
        "Content-Type": "application/json",
        "token": "${await storageService.getData('token')}",
        "appVersion": "${await storageService.getData('appVersion')}",
        "appPlatform": "${Platform.operatingSystem}",
      },
      body: jsonEncode(<String, dynamic>{
        'offerItems': offerItems.toList(),
        'deviceId': "$deviceId",
        'comment': "$comment",
        'tenure': "$tenure",
        'isAddon': "$isAddon",
        'salesAgentCode': "$salesAgentCode",
        'isInstallment': "$isInstallment",
      }),
    );
    print("${await storageService.getData('token')}");

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  @override
  Future<dynamic> payByServiceOrder(
      List<OfferItems> offerItems,
      String deviceId,
      String comment,
      String salesAgentCode,
      bool isInstallment,
      String serviceNumber) async {
    var response = await http.post(
      Uri.parse('$BaseUrl/pay-by/offers/service-order'),
      headers: {
        "Content-Type": "application/json",
        "token": "${await storageService.getData('token')}",
        "appVersion": "${await storageService.getData('appVersion')}",
        "appPlatform": "${Platform.operatingSystem}",
      },
      body: jsonEncode(<String, dynamic>{
        'offerItems': offerItems.toList(),
        'deviceId': "$deviceId",
        'comment': "$comment",
        'salesAgentCode': "$salesAgentCode",
        'isInstallment': isInstallment,
        'serviceNumber': "0$serviceNumber",
      }),
    );
    print("${await storageService.getData('token')}");

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  @override
  Future<dynamic> cashOffersOrder(
      List<OfferItems> offerItems,
      bool isInstallment,
      String comment,
      String salesAgentCode,
      int tenure,
      bool isAddon) async {
    var response = await http.post(
      Uri.parse('$BaseUrl/cash/offers/order'),
      headers: {
        "Content-Type": "application/json",
        "token": "${await storageService.getData('token')}",
        "appVersion": "${await storageService.getData('appVersion')}",
        "appPlatform": "${Platform.operatingSystem}",
      },
      body: jsonEncode(<String, dynamic>{
        'offerItems': offerItems.toList(),
        'isInstallment': "$isInstallment",
        'comment': "$comment",
        'salesAgentCode': "$salesAgentCode",
        'tenure': "$tenure",
        'isAddon': "$isAddon",
      }),
    );
    print("${await storageService.getData('token')}");

    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  @override
  Future<dynamic> getFortuneItem() async {
    var response = await dio.get(
        'https://b2-documents.s3.me-south-1.amazonaws.com/fortune/fortune.json');
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };
    return response;
  }

  @override
  Future payByPackageOrder(int packageId, String deviceId) async {
    var response = await http.post(
      Uri.parse('$BaseUrl/pay-by/packages/order'),
      headers: {
        "Content-Type": "application/json",
        "token": "${await storageService.getData('token')}",
        "appVersion": "${await storageService.getData('appVersion')}",
        "appPlatform": "${Platform.operatingSystem}",
      },
      body: jsonEncode(
          <String, dynamic>{'packageId': packageId, 'deviceId': "$deviceId"}),
    );
    print("${await storageService.getData('token')}");
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  @override
  Future getBlogs(int page, String category) async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };
    var response = await dio.get('$BaseUrl/contents?category=$category');
    return response;
    throw UnimplementedError();
  }

  @override
  Future getAnnouncements() async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };
    var response = await dio.get('$BaseUrl/announcement/');
    return response;
    throw UnimplementedError();
  }


  @override
  Future getAnnouncementsDetail(id) async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };
    var response = await dio.get('$BaseUrl/announcement/$id');
    return response;
    throw UnimplementedError();
  }

  @override
  Future getOrderDetail(int orderId) async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };
    var response = await dio.get('$BaseUrl/offer-orders/$orderId');
    return response;
  }

  @override
  Future topUpCategories() async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };
    return await dio.get('$BaseUrl/offers/topup-categories');
  }

  @override
  Future getJobs(
      int? page,
      int? perPage,
      String? title,
      String? category,
      String? location,
      int? salaryMin,
      int? salaryMax,
      int? dateMin,
      int? dateMax,
      String? sortOrder) async {
    final String pageData = page == null ? 'page=' : 'page=$page';
    final String perPageData =
        perPage == null ? 'per_page=' : 'per_page=$perPage';
    final String titleData = title == null ? 'title=' : 'title=$title';
    final String sortOrderData =
        title == null ? 'sort-order=' : 'sort-order=$sortOrder';
    final String categoryData =
        category == null ? 'category=' : 'category=$category';
    final String locationData =
        location == null ? 'location=' : 'location=$location';
    final String salaryMinData =
        salaryMin == null ? 'salary_min=' : 'salary_min=$salaryMin';
    final String salaryMaxData =
        salaryMax == null ? 'salary_max=' : 'salary_max=$salaryMax';
    final String dateMinData =
        dateMin == null ? 'date_min=' : 'date_min=$dateMin';
    final String dateMaxData =
        dateMax == null ? 'date_max=' : 'date_max=$dateMax';
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };

    final data = await dio.get(
        ('$BaseUrl/contents/jobs?$pageData&$perPageData&$titleData&$categoryData&$locationData&$salaryMinData&$salaryMaxData&$dateMinData&$dateMaxData&$sortOrderData'));
    print(data);

    return data;
  }

  @override
  Future getJobsCategories() async {
    dio.options.headers = {
      "token": "${await storageService.getData('token')}",
      "appVersion": "${await storageService.getData('appVersion')}",
      "appPlatform": "${Platform.operatingSystem}",
    };
    final data = await dio.get('$BaseUrl/contents/jobs-category');
    return data;
  }
}
