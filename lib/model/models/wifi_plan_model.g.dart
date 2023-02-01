// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wifi_plan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WifiPlanModel _$WifiPlanModelFromJson(Map<String, dynamic> json) =>
    WifiPlanModel(
      packageLabel: json["packageLabel"],
      packageName: json["packageName"],
      assignmentTime: List<int>.from(json["assignmentTime"].map((x) => x)),
      expirationTime: List<int>.from(json["expirationTime"].map((x) => x)),
      packageCurrency: json["packageCurrency"],
      packagePrice: json["packagePrice"],
      contactNumber: json["contactNumber"],
      status: json["status"],
      siteName: json["siteName"],
      isCorporate: json["isCorporate"] as bool,
      siteLogo: json["siteLogo"],
    );

Map<String, dynamic> _$WifiPlanModelToJson(WifiPlanModel instance) =>
    <String, dynamic>{
      "packageLabel": instance.packageLabel,
      "packageName": instance.packageName,
      "assignmentTime":
          List<dynamic>.from(instance.assignmentTime!.map((x) => x)),
      "expirationTime":
          List<dynamic>.from(instance.expirationTime!.map((x) => x)),
      "packageCurrency": instance.packageCurrency,
      "packagePrice": instance.packagePrice,
      "contactNumber": instance.contactNumber,
      "status": instance.status,
      "siteName": instance.siteName,
      "isCorporate": instance.isCorporate,
      "siteLogo": instance.siteLogo,
    };
