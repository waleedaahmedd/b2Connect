class PackageDetails {
  int? orderId;
  int? packageId;
  String? packageName;
  num? total;
  int? packageValidSeconds;
  int? time;
  String? currency;

  PackageDetails(
      {this.orderId,
        this.packageId,
        this.packageName,
        this.total,
        this.packageValidSeconds,
        this.time,
        this.currency});

  PackageDetails.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    packageId = json['packageId'];
    packageName = json['packageName'];
    total = json['total'];
    packageValidSeconds = json['packageValidSeconds'];
    time = json['time'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['packageId'] = this.packageId;
    data['packageName'] = this.packageName;
    data['total'] = this.total;
    data['packageValidSeconds'] = this.packageValidSeconds;
    data['time'] = this.time;
    data['currency'] = this.currency;
    return data;
  }
}