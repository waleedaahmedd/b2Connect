class Options {
  String? value;
  int? offerCount;

  Options({this.value, this.offerCount});

  Options.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    offerCount = json['offerCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['offerCount'] = this.offerCount;
    return data;
  }
}