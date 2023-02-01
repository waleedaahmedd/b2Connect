

class Fortune {
  String? name;
  num? weight;

  Fortune({this.name, this.weight});

  Fortune.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['weight'] = this.weight;
    return data;
  }
}