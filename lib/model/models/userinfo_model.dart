import 'package:json_annotation/json_annotation.dart';

part 'userinfo_model.g.dart';

// ignore: deprecated_member_use
@JsonSerializable(nullable: false)
class UserInfoModel {
  UserInfoModel({
    required this.uid,
    required this.incomingZoneLabel,
    required this.creationDate,
    required this.creationDateUt,
    required this.creationMode,
    required this.userLanguage,
    required this.location,
    required this.property,
    required this.room,
    required this.origin,
    required this.startDate,
    required this.startDateUt,
    required this.userEmail,
    required this.firstName,
    required this.lastName,
    required this.profileId,
    required this.profileLabel,
    required this.profileName,
    required this.emiratesId,
    required this.emiratesName,
    required this.emiratesBirthday,
    required this.emiratesNationality,
    required this.emiratesGender,
    required this.emiratesExpiry,
    required this.b2CustomerId,
    required this.userRole,
    required this.qrCodeLink,
    required this.avatarKey,
    required this.spinEligable,
    required this.spinResult,
    required this.spinTimestamp,
    required this.profileValidToUT,
    required this.isNotifyIfPlanExpires,
    required this.isCorporate,
    required this.availableActivations,
    required this.siteLogo,
    required this.siteName,
    required this.zone,
  });

  String? uid;
  String? incomingZoneLabel;
  String? creationDate;
  int? creationDateUt;
  String? creationMode;
  String? userLanguage;
  String? location;
  String? property;
  String? room;
  String? origin;
  String? startDate;
  int? startDateUt;
  String? userEmail;
  String? firstName;
  String? lastName;
  String? profileId;
  String? profileLabel;
  String? profileName;
  String? emiratesId;
  String? emiratesName;
  int? emiratesBirthday;
  String? emiratesNationality;
  String? emiratesGender;
  int? emiratesExpiry;
  String? b2CustomerId;
  String? userRole;
  String? qrCodeLink;
  dynamic avatarKey;
  bool? spinEligable;
  dynamic spinResult;
  int? spinTimestamp;
  dynamic profileValidToUT;
  bool? isNotifyIfPlanExpires;
  bool? isCorporate;
  int? availableActivations;
  String? siteName;
  String? siteLogo;
  String? zone;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}

// UserInfoModel tokenFromJson(String str) => UserInfoModel.fromJson(json.decode(str));
//
// String tokenToJson(UserInfoModel data) => json.encode(data.toJson());
//
// class UserInfoModel {
//   UserInfoModel({
//     required this.uid,
//     required this.incomingZoneLabel,
//     required this.creationDate,
//     required this.creationDateUt,
//     required this.creationMode,
//     required this.userLanguage,
//     required this.location,
//     required this.property,
//     required this.room,
//     required this.origin,
//     required this.startDate,
//     required this.startDateUt,
//     required this.userEmail,
//     required this.firstName,
//     required this.lastName,
//     required this.profileId,
//     required this.profileLabel,
//     required this.profileName,
//     required this.emiratesId,
//     required this.emiratesName,
//     required this.emiratesBirthday,
//     required this.emiratesNationality,
//     required this.emiratesGender,
//     required this.emiratesExpiry,
//     required this.b2CustomerId,
//     required this.userRole,
//     required this.qrCodeLink,
//     required this.avatarKey,
//     required this.spinEligable,
//     required this.spinResult,
//     required this.spinTimestamp,
//     required this.profileValidToUt,
//     required this.isNotifyIfPlanExpires,
//   });
//
//   String? uid;
//   String? incomingZoneLabel;
//   String? creationDate;
//   int? creationDateUt;
//   String? creationMode;
//   String? userLanguage;
//   String? location;
//   String? property;
//   String? room;
//   String? origin;
//   String? startDate;
//   int? startDateUt;
//   String? userEmail;
//   String? firstName;
//   String? lastName;
//   String? profileId;
//   String? profileLabel;
//   String? profileName;
//   String? emiratesId;
//   String? emiratesName;
//   int? emiratesBirthday;
//   String? emiratesNationality;
//   String? emiratesGender;
//   int? emiratesExpiry;
//   String? b2CustomerId;
//   String? userRole;
//   String? qrCodeLink;
//   dynamic avatarKey;
//   bool? spinEligable;
//   dynamic spinResult;
//   int? spinTimestamp;
//   dynamic profileValidToUt;
//   bool? isNotifyIfPlanExpires;
//
//   factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
//     uid: json["uid"],
//     incomingZoneLabel: json["incomingZoneLabel"],
//     creationDate: json["creationDate"],
//     creationDateUt: json["creationDateUT"],
//     creationMode: json["creationMode"],
//     userLanguage: json["userLanguage"],
//     location: json["location"],
//     property: json["property"],
//     room: json["room"],
//     origin: json["origin"],
//     startDate: json["startDate"],
//     startDateUt: json["startDateUT"],
//     userEmail: json["userEmail"],
//     firstName: json["firstName"],
//     lastName: json["lastName"],
//     profileId: json["profileId"],
//     profileLabel: json["profileLabel"],
//     profileName: json["profileName"],
//     emiratesId: json["emiratesId"],
//     emiratesName: json["emiratesName"],
//     emiratesBirthday: json["emiratesBirthday"],
//     emiratesNationality: json["emiratesNationality"],
//     emiratesGender: json["emiratesGender"],
//     emiratesExpiry: json["emiratesExpiry"],
//     b2CustomerId: json["b2CustomerId"],
//     userRole: json["userRole"],
//     qrCodeLink: json["qrCodeLink"],
//     avatarKey: json["avatarKey"],
//     spinEligable: json["_spinEligable"],
//     spinResult: json["_spinResult"],
//     spinTimestamp: json["_spinTimestamp"],
//     profileValidToUt: json["profileValidToUT"],
//     isNotifyIfPlanExpires: json["isNotifyIfPlanExpires"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "uid": uid,
//     "incomingZoneLabel": incomingZoneLabel,
//     "creationDate": creationDate,
//     "creationDateUT": creationDateUt,
//     "creationMode": creationMode,
//     "userLanguage": userLanguage,
//     "location": location,
//     "property": property,
//     "room": room,
//     "origin": origin,
//     "startDate": startDate,
//     "startDateUT": startDateUt,
//     "userEmail": userEmail,
//     "firstName": firstName,
//     "lastName": lastName,
//     "profileId": profileId,
//     "profileLabel": profileLabel,
//     "profileName": profileName,
//     "emiratesId": emiratesId,
//     "emiratesName": emiratesName,
//     "emiratesBirthday": emiratesBirthday,
//     "emiratesNationality": emiratesNationality,
//     "emiratesGender": emiratesGender,
//     "emiratesExpiry": emiratesExpiry,
//     "b2CustomerId": b2CustomerId,
//     "userRole": userRole,
//     "qrCodeLink": qrCodeLink,
//     "avatarKey": avatarKey,
//     "_spinEligable": spinEligable,
//     "_spinResult": spinResult,
//     "_spinTimestamp": spinTimestamp,
//     "profileValidToUT": profileValidToUt,
//     "isNotifyIfPlanExpires": isNotifyIfPlanExpires,
//   };
// }
