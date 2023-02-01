import 'package:json_annotation/json_annotation.dart';

// WifiPackagesIdModel wifiPackagesIdModelFromJson(String str) => WifiPackagesIdModel.fromJson(json.decode(str));
//
// String wifiPackagesIdModelToJson(WifiPackagesIdModel data) => json.encode(data.toJson());
part 'wifi_packages_id_model.g.dart';

// ignore: deprecated_member_use
@JsonSerializable(nullable: false)
class WifiPackagesIdModel {
  WifiPackagesIdModel({
    required this.id,
    required this.name,
    required this.label,
    required this.currency,
    required this.price,
    required this.devices,
    required this.validity,
    required this.bandwidth,
    required this.description,
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

  factory WifiPackagesIdModel.fromJson(Map<String, dynamic> json) =>
      _$WifiPackagesIdModelFromJson(json);
  Map<String, dynamic> toJson() => _$WifiPackagesIdModelToJson(this);
}
