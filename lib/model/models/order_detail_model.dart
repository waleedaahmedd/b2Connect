class OrderDetailModel {
  num? orderId;
  num? salesOrderId;
  String? salesOrderNo;
  num? invoiceId;
  num? invoiceNo;
  String? source;
  num? total;
  num? subtotal;
  num? installment;
  List<InstallmentInfo>? installmentInfo;
  List<Fees>? fees;
  String? paymentMethod;
  String? userComment;
  String? status;
  num? time;
  String? userEmail;
  String? userPhone;
  String? userZoneState;
  String? userZone;
  String? userAddress;
  String? salesAgentCode;
  String? currency;
  List<Items>? items;
  String? cardNumber;
  String? cardPin;
  num? tenure;
  String? appPlatform;
  String? appVersion;

  OrderDetailModel(
      {this.orderId,
        this.salesOrderId,
        this.salesOrderNo,
        this.invoiceId,
        this.invoiceNo,
        this.source,
        this.total,
        this.subtotal,
        this.installment,
        this.installmentInfo,
        this.fees,
        this.paymentMethod,
        this.userComment,
        this.status,
        this.time,
        this.userEmail,
        this.userPhone,
        this.userZoneState,
        this.userZone,
        this.userAddress,
        this.salesAgentCode,
        this.currency,
        this.items,
        this.cardNumber,
        this.cardPin,
        this.tenure,
        this.appPlatform,
        this.appVersion});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    salesOrderId = json['salesOrderId'];
    salesOrderNo = json['salesOrderNo'];
    invoiceId = json['invoiceId'];
    invoiceNo = json['invoiceNo'];
    source = json['source'];
    total = json['total'];
    subtotal = json['subtotal'];
    installment = json['installment'];
    if (json['installmentInfo'] != null) {
      installmentInfo = <InstallmentInfo>[];
      json['installmentInfo'].forEach((v) {
        installmentInfo!.add(new InstallmentInfo.fromJson(v));
      });
    }
    if (json['fees'] != null) {
      fees = <Fees>[];
      json['fees'].forEach((v) {
        fees!.add(new Fees.fromJson(v));
      });
    }
    paymentMethod = json['paymentMethod'];
    userComment = json['userComment'];
    status = json['status'];
    time = json['time'];
    userEmail = json['userEmail'];
    userPhone = json['userPhone'];
    userZoneState = json['userZoneState'];
    userZone = json['userZone'];
    userAddress = json['userAddress'];
    salesAgentCode = json['salesAgentCode'];
    currency = json['currency'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    cardNumber = json['cardNumber'];
    cardPin = json['cardPin'];
    tenure = json['tenure'];
    appPlatform = json['appPlatform'];
    appVersion = json['appVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['salesOrderId'] = this.salesOrderId;
    data['salesOrderNo'] = this.salesOrderNo;
    data['invoiceId'] = this.invoiceId;
    data['invoiceNo'] = this.invoiceNo;
    data['source'] = this.source;
    data['total'] = this.total;
    data['subtotal'] = this.subtotal;
    data['installment'] = this.installment;
    if (this.installmentInfo != null) {
      data['installmentInfo'] =
          this.installmentInfo!.map((v) => v.toJson()).toList();
    }
    if (this.fees != null) {
      data['fees'] = this.fees!.map((v) => v.toJson()).toList();
    }
    data['paymentMethod'] = this.paymentMethod;
    data['userComment'] = this.userComment;
    data['status'] = this.status;
    data['time'] = this.time;
    data['userEmail'] = this.userEmail;
    data['userPhone'] = this.userPhone;
    data['userZoneState'] = this.userZoneState;
    data['userZone'] = this.userZone;
    data['userAddress'] = this.userAddress;
    data['salesAgentCode'] = this.salesAgentCode;
    data['currency'] = this.currency;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['cardNumber'] = this.cardNumber;
    data['cardPin'] = this.cardPin;
    data['tenure'] = this.tenure;
    data['appPlatform'] = this.appPlatform;
    data['appVersion'] = this.appVersion;
    return data;
  }
}

class InstallmentInfo {
  num? stepNumber;
  num? price;
  int? dueDate;
  String? status;

  InstallmentInfo({this.stepNumber, this.price, this.dueDate, this.status});

  InstallmentInfo.fromJson(Map<String, dynamic> json) {
    stepNumber = json['stepNumber'];
    price = json['price'];
    dueDate = json['dueDate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stepNumber'] = this.stepNumber;
    data['price'] = this.price;
    data['dueDate'] = this.dueDate;
    data['status'] = this.status;
    return data;
  }
}

class Fees {
  String? type;
  num? value;

  Fees({this.type, this.value});

  Fees.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}

class Items {
  num? offerId;
  String? sku;
  num? amount;
  num? price;
  String? name;
  List<String>? images;
  String? currency;
  String? serviceName;
  String? serviceUUID;
  String? account;
  String? serviceStatus;

  Items(
      {this.offerId,
        this.sku,
        this.amount,
        this.price,
        this.name,
        this.images,
        this.currency,
        this.serviceName,
        this.serviceUUID,
        this.account,
        this.serviceStatus});

  Items.fromJson(Map<String, dynamic> json) {
    offerId = json['offerId'];
    sku = json['sku'];
    amount = json['amount'];
    price = json['price'];
    name = json['name'];
    images = json['images'].cast<String>();
    currency = json['currency'];
    serviceName = json['serviceName'];
    serviceUUID = json['serviceUUID'];
    account = json['account'];
    serviceStatus = json['serviceStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offerId'] = this.offerId;
    data['sku'] = this.sku;
    data['amount'] = this.amount;
    data['price'] = this.price;
    data['name'] = this.name;
    data['images'] = this.images;
    data['currency'] = this.currency;
    data['serviceName'] = this.serviceName;
    data['serviceUUID'] = this.serviceUUID;
    data['account'] = this.account;
    data['serviceStatus'] = this.serviceStatus;
    return data;
  }
}