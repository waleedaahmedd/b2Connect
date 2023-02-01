part of 'history_refill.dart';


PackageOrdersModel _$RefillHistoryFromJson(Map<String, dynamic> json) {
  return PackageOrdersModel(
    orderId: json["orderId"],
    packageId: json["packageId"],
    packageName: json["packageName"],
    total: json["total"],
    packageValidSeconds: json["packageValidSeconds"],
    time: json["time"],
    currency: json["currency"],
  );
}
Map<String, dynamic> _$RefillHistoryToJson(PackageOrdersModel instance) => <String, dynamic>{
  "orderId": instance.orderId,
  "packageId": instance.packageId,
  "packageName": instance.packageName,
  "total": instance.total,
  "packageValidSeconds": instance.packageValidSeconds,
  "time": instance.time,
  "currency": instance.currency,
};

// RefillHistory _$RefillHistoryFromJson(Map<String, dynamic> json) {
//   return RefillHistory(
//     packageName: json["packageName"],
//     price: json["price"],
//     currency: json["currency"],
//     refillDate: json["refillDate"],
//     validForDays: json["validForDays"],
//   );
// }
// Map<String, dynamic> _$RefillHistoryToJson(RefillHistory instance) => <String, dynamic>{
//   "packageName": instance.packageName,
//   "price": instance.price,
//   "currency": instance.currency,
//   "refillDate": instance.refillDate,
//   "validForDays": instance.validForDays,
// };

