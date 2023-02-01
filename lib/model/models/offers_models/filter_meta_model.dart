import 'attribute_filter_meta.dart';

class FilterMeta {
  List<AttributeFilterMeta>? attributeFilterMeta;
  int? minPrice;
  int? maxPrice;

  FilterMeta({this.attributeFilterMeta, this.minPrice, this.maxPrice});

  FilterMeta.fromJson(Map<String, dynamic> json) {
    if (json['attributeFilterMeta'] != null) {
      attributeFilterMeta = new List<AttributeFilterMeta>.empty(growable: true);
      json['attributeFilterMeta'].forEach((v) {
        attributeFilterMeta!.add(new AttributeFilterMeta.fromJson(v));
      });
    }
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.attributeFilterMeta != null) {
      data['attributeFilterMeta'] =
          this.attributeFilterMeta!.map((v) => v.toJson()).toList();
    }
    data['minPrice'] = this.minPrice;
    data['maxPrice'] = this.maxPrice;
    return data;
  }
}