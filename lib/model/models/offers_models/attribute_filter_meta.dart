
import 'options_model.dart';

class AttributeFilterMeta {
  int? attributeId;
  String? attributeName;
  List<Options>? options;

  AttributeFilterMeta({this.attributeId, this.attributeName, this.options});

  AttributeFilterMeta.fromJson(Map<String, dynamic> json) {
    attributeId = json['attributeId'];
    attributeName = json['attributeName'];
    if (json['options'] != null) {
      options = new List<Options>.empty(growable: true);
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attributeId'] = this.attributeId;
    data['attributeName'] = this.attributeName;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}