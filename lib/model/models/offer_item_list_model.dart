class OfferItems {
  int? offerId;
  int? amount;

  OfferItems({this.offerId, this.amount});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offerId'] = this.offerId;
    data['amount'] = this.amount;
    return data;
  }
}
