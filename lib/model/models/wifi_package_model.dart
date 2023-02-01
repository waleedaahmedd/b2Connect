import 'package:json_annotation/json_annotation.dart';

part 'wifi_package_model.g.dart';

// ignore: deprecated_member_use
@JsonSerializable(nullable: false)
class WifiModel {
  WifiModel({
    required this.id,
    required this.name,
    required this.label,
    required this.currency,
    required this.price,
    required this.devices,
    required this.validity,
    required this.bandwidth,
    required this.description,
    required this.isCorporate,
    required this.isPaymentEnabled,
    required this.isBase,


  });

  int id;
  String name;
  String label;
  String currency;
  int price;
  int devices;
  int validity;
  int bandwidth;
  String description;
  bool isCorporate;
  bool isPaymentEnabled;
  bool isBase;


  factory WifiModel.fromJson(Map<String, dynamic> json) =>
      _$WifiModelFromJson(json);
  Map<String, dynamic> toJson() => _$WifiModelToJson(this);
}








// List<WifiModel> wifioModelFromJson(String str) => List<WifiModel>.from(json.decode(str).map((x) => WifiModel.fromJson(x)));
//
// String wifioModelToJson(List<WifiModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
// class WifiModel {
//   WifiModel({
//     required this.id,
//     required this.name,
//     required this.label,
//     required this.currency,
//     required this.price,
//     required this.devices,
//     required this.validity,
//     required this.bandwidth,
//     required this.description,
//   });
//
//   int id;
//   String name;
//   String label;
//   String currency;
//   int price;
//   int devices;
//   int validity;
//   int bandwidth;
//   String description;
//
// factory WifiModel.fromJson(Map<String, dynamic> json) => WifiModel(
//   id: json["id"],
//   name: json["name"],
//   label: json["label"],
//   currency: json["currency"],
//   price: json["price"],
//   devices: json["devices"],
//   validity: json["validity"],
//   bandwidth: json["bandwidth"],
//   description: json["description"],
// );
//
// Map<String, dynamic> toJson() => {
//   "id": id,
//   "name": name,
//   "label": label,
//   "currency": currency,
//   "price": price,
//   "devices": devices,
//   "validity": validity,
//   "bandwidth": bandwidth,
//   "description": description,
// };
// }