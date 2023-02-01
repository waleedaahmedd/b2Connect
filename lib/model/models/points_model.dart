import 'package:intl/intl.dart';

class PointsModel {
  num? balance;
  num? balanceInAED;
  List<Transactions>? transactions;

  PointsModel({this.balance, this.balanceInAED, this.transactions});

  PointsModel.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    balanceInAED = json['balanceInAED'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['balance'] = this.balance;
    data['balanceInAED'] = this.balanceInAED;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  num? points;
  num? pointsInCurrency;
  num? currencyId;
  double? currencyRate;
  num? pointsBalance;
  String? type;
  String? subType;
  String? hash;
  String? previousHash;
  String? created;
  num? referenceId;
  String? transactionInfo;
  String? transactionImage;

  Transactions(
      {this.points,
        this.pointsInCurrency,
        this.currencyId,
        this.currencyRate,
        this.pointsBalance,
        this.type,
        this.subType,
        this.hash,
        this.previousHash,
        this.created,
        this.referenceId,
        this.transactionInfo,
        this.transactionImage});

  Transactions.fromJson(Map<String, dynamic> json) {
    points = json['points'];
    pointsInCurrency = json['pointsInCurrency'];
    currencyId = json['currencyId'];
    currencyRate = json['currencyRate'];
    pointsBalance = json['pointsBalance'];
    type = json['type'];
    subType = json['subType'];
    hash = json['hash'];
    previousHash = json['previousHash'];
    created = DateFormat('dd MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(json['created']));
    referenceId = json['referenceId'];
    transactionInfo = json['transactionInfo'];
    transactionImage = json['transactionImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['points'] = this.points;
    data['pointsInCurrency'] = this.pointsInCurrency;
    data['currencyId'] = this.currencyId;
    data['currencyRate'] = this.currencyRate;
    data['pointsBalance'] = this.pointsBalance;
    data['type'] = this.type;
    data['subType'] = this.subType;
    data['hash'] = this.hash;
    data['previousHash'] = this.previousHash;
    data['created'] = this.created;
    data['referenceId'] = this.referenceId;
    data['transactionInfo'] = this.transactionInfo;
    data['transactionImage'] = this.transactionImage;
    return data;
  }
}