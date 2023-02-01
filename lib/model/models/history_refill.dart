import 'package:json_annotation/json_annotation.dart';

part 'history_refill.g.dart';

@JsonSerializable()
class PackageOrdersModel {
  PackageOrdersModel({
     this.orderId,
     this.packageId,
    this.packageName,
     this.total,
     this.packageValidSeconds,
     this.time,
     this.currency,
  });

  int? orderId;
  int? packageId;
  String? packageName;
  double? total;
  int? packageValidSeconds;
  int? time;
  String? currency;

  factory PackageOrdersModel.fromJson(Map<String, dynamic> json) => _$RefillHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$RefillHistoryToJson(this);

}
// class RefillHistory {
//   RefillHistory({
//     this.packageName,
//     this.price,
//     this.currency,
//     this.refillDate,
//     this.validForDays,
//   });
//
//   String? packageName;
//   String? price;
//   String? currency;
//   int? refillDate;
//   String? validForDays;
//
//   factory RefillHistory.fromJson(Map<String, dynamic> json) => _$RefillHistoryFromJson(json);
//
//   Map<String, dynamic> toJson() => _$RefillHistoryToJson(this);
//
// }


