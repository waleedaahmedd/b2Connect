class ServiceOrder {
  bool? success;
  String? message;
  String? tokenUrl;
  String? appId;
  String? partnerId;
  String? signature;
  String? salesOrderNo;
  int? internalOrderId;
  String? paymentOrderId;

  ServiceOrder(
      {this.success,
        this.message,
        this.tokenUrl,
        this.appId,
        this.partnerId,
        this.signature,
        this.salesOrderNo,
        this.internalOrderId,
        this.paymentOrderId});

  ServiceOrder.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    tokenUrl = json['tokenUrl'];
    appId = json['appId'];
    partnerId = json['partnerId'];
    signature = json['signature'];
    salesOrderNo = json['salesOrderNo'];
    internalOrderId = json['internalOrderId'];
    paymentOrderId = json['paymentOrderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['tokenUrl'] = this.tokenUrl;
    data['appId'] = this.appId;
    data['partnerId'] = this.partnerId;
    data['signature'] = this.signature;
    data['salesOrderNo'] = this.salesOrderNo;
    data['internalOrderId'] = this.internalOrderId;
    data['paymentOrderId'] = this.paymentOrderId;
    return data;
  }
}