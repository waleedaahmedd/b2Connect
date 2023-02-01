import 'package:b2connect_flutter/model/models/offer_item_list_model.dart';

import '../../../model/models/points_model.dart';

abstract class Repository {
  Future<dynamic> sendOTP(String number);

  Future<dynamic> verifyOTP(
      context, String number, String code, String? ipAddress, String deviceMac);

  Future<dynamic> login(String number, String? ipAddress, String deviceMac);

  Future<dynamic> sendResetPassword(String phoneNumber);

  Future<dynamic> sendEmiratesData(/*String name, String sex, int dateOfBirth,
      String nationality,*/ String emiratesId, int expiryDate);

  Future<dynamic> advertisement();

  Future<dynamic> userInfo();

  Future<PointsModel> pointsApi();

  Future<dynamic> getOffers(
      int? page,
      int? perPage,
      int? categoryId,
      String? sortBy,
      String? filterBy,
      String? filterByStock,
      String? name,
      int? minPrice,
      int? maxPrice);

  Future<dynamic> getJobs(
      int? page,
      int? perPage,
      String? title,
      String? category,
      String? location,
      int? salaryMin,
      int? salaryMax,
      int? dateMin,
      int? dateMax, String? sortOrder);

  Future<dynamic> getJobsCategories(
     );

  Future<dynamic> wifi();

  Future<dynamic> payWifiCorporate();

  Future<dynamic> notifications(
    String pages,
    String perPage,
  );

  Future<dynamic> packageOrders();
  Future<dynamic> packageOrdersDetail(int id);

  Future<dynamic> historyRefill();

  Future<dynamic> offerOrders();

  Future getProductsDetails(String id);

  Future productCategories();
  Future topUpCategories();


  Future addWishList(String id);

  Future deleteFromWishList(String id);

  Future showWishList();

  Future getFortuneItem();

  Future checkWishList(String id);
  Future payBySuccess(String internalOrderId);

  Future payByOffersOrder(List<OfferItems> offerItems, String deviceId, String comment, String salesAgentCode, bool isInstallment, int tenure , bool isAddon);
  Future payByServiceOrder(List<OfferItems> offerItems, String deviceId, String comment, String salesAgentCode, bool isInstallment, String topUpMobileNumber);

  Future cashOffersOrder(List<OfferItems> offerItems, bool isInstallment, String comment, String salesAgentCode, int tenure, bool isAddon);

  Future payByPackageOrder(
    int packageId,
    String deviceId,
  );

  Future getOrderDetail(
      int orderId,
      );

  Future updateUserInfo(
    String contactPhone,
    String location,
    String property,
    String room,
    int spinDate, String spinResult, String firstName, String lastName
  );

  Future fcmToken(String token);

  Future getBlogs(int page,String category);
  Future getAnnouncements();

  Future getAnnouncementsDetail(int);

  Future deleteAccount({required int reasonId});




  Future wifiPlan();

}
