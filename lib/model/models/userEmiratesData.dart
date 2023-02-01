import 'package:json_annotation/json_annotation.dart';

part 'userEmiratesData.g.dart';

@JsonSerializable()
class UserEmiratesData {
  String? emiratesId;
  String? emiratesName;
  String? emiratesBirthday;
  String? emiratesNationality;
  String? emiratesGender;
  String? emiratesExpiry;

  UserEmiratesData({this.emiratesId, this.emiratesBirthday, this.emiratesExpiry,this.emiratesGender,this.emiratesName,this.emiratesNationality});

  factory UserEmiratesData.fromJson(Map<String, dynamic> json) => _$UserEmiratesDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserEmiratesDataToJson(this);
}
