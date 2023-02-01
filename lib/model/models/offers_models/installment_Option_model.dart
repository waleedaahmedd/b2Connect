//TODO: new installment 6x plan
class InstallmentPrices {
  int? tenure;
  double? monthlyPrice;
  double? monthlyPriceAddon;

  InstallmentPrices({this.tenure, this.monthlyPrice, this.monthlyPriceAddon});

  InstallmentPrices.fromJson(Map<String, dynamic> json) {
    tenure = json['tenure'];
    monthlyPrice = json['monthlyPrice'];
    monthlyPriceAddon = json['monthlyPriceAddon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tenure'] = this.tenure;
    data['monthlyPrice'] = this.monthlyPrice;
    data['monthlyPriceAddon'] = this.monthlyPriceAddon;
    return data;
  }
}