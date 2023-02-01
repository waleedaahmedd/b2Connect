class PayBySuccessModel {
  String? status;
  String? salesOrderNo;
  String? serviceUUID;

  PayBySuccessModel({this.status, this.salesOrderNo,this.serviceUUID});

  PayBySuccessModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    salesOrderNo = json['salesOrderNo'];
    serviceUUID = json['serviceUUID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['salesOrderNo'] = this.salesOrderNo;
    data['serviceUUID'] = this.serviceUUID;
    return data;
  }
}