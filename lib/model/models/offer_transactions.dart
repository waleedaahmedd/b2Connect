import 'package:json_annotation/json_annotation.dart';

part 'offer_transactions.g.dart';

@JsonSerializable()

class OfferTransactionsModel {
  OfferTransactionsModel({
    required this.total,
    required this.items,
  });

  int? total;
  List<Item>? items;

  factory OfferTransactionsModel.fromJson(Map<String, dynamic> json) => _$OfferOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferOrderModelToJson(this);

}

class Item {
  Item({
    required this.orderId,
    required this.salesOrderId,
    required this.salesOrderNo,
    required this.invoiceId,
    required this.invoiceNo,
    required this.source,
    required this.total,
    required this.status,
    required this.time,
    required this.userZoneState,
    required this.userZone,
    required this.userAddress,
    required this.userPhone,
    required this.salesAgentCode,
    required this.paymentMethod,
    required this.currency,
  });

  int orderId;
  dynamic salesOrderId;
  dynamic salesOrderNo;
  dynamic invoiceId;
  dynamic invoiceNo;
  String source;
  double total;
  String status;
  int time;
  String userZoneState;
  String userZone;
  String userAddress;
  String userPhone;
  String salesAgentCode;
  String paymentMethod;
  String currency;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    orderId: json["orderId"],
    salesOrderId: json["salesOrderId"],
    salesOrderNo: json["salesOrderNo"],
    invoiceId: json["invoiceId"],
    invoiceNo: json["invoiceNo"],
    source: json["source"],
    total: json["total"].toDouble(),
    status: json["status"],
    time: json["time"],
    userZoneState: json["userZoneState"],
    userZone: json["userZone"],
    userAddress: json["userAddress"],
    userPhone: json["userPhone"],
    salesAgentCode: json["salesAgentCode"],
    paymentMethod: json["paymentMethod"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "salesOrderId": salesOrderId,
    "salesOrderNo": salesOrderNo,
    "invoiceId": invoiceId,
    "invoiceNo": invoiceNo,
    "source": source,
    "total": total,
    "status": status,
    "time": time,
    "userZoneState": userZoneState,
    "userZone": userZone,
    "userAddress": userAddress,
    "userPhone": userPhone,
    "salesAgentCode": salesAgentCode,
    "paymentMethod": paymentMethod,
    "currency": currency,
  };
}

