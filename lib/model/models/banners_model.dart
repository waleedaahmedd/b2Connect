class BannersModel {
  String? location;
  String? imageLink;
  String? navigation;
  int? position;
  bool? enabled;

  BannersModel(
      {this.location,
        this.imageLink,
        this.navigation,
        this.position,
        this.enabled});

  BannersModel.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    imageLink = json['imageLink'];
    navigation = json['navigation'];
    position = json['position'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['imageLink'] = this.imageLink;
    data['navigation'] = this.navigation;
    data['position'] = this.position;
    data['enabled'] = this.enabled;
    return data;
  }
}