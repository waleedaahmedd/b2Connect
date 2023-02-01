// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userinfo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      uid: json['uid'] as String?,
      incomingZoneLabel: json['incomingZoneLabel'] as String?,
      creationDate: json['creationDate'] as String?,
      creationDateUt: json['creationDateUt'] as int?,
      creationMode: json['creationMode'] as String?,
      userLanguage: json['userLanguage'] as String?,
      location: json['location'] as String?,
      property: json['property'] as String?,
      room: json['room'] as String?,
      origin: json['origin'] as String?,
      startDate: json['startDate'] as String?,
      startDateUt: json['startDateUt'] as int?,
      userEmail: json['userEmail'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      profileId: json['profileId'] as String?,
      profileLabel: json['profileLabel'] as String?,
      profileName: json['profileName'] as String?,
      emiratesId: json['emiratesId'] as String?,
      emiratesName: json['emiratesName'] as String?,
      emiratesBirthday: json['emiratesBirthday'] as int?,
      emiratesNationality: json['emiratesNationality'] as String?,
      emiratesGender: json['emiratesGender'] as String?,
      emiratesExpiry: json['emiratesExpiry'] as int?,
      b2CustomerId: json['b2CustomerId'] as String?,
      userRole: json['userRole'] as String?,
      qrCodeLink: json['qrCodeLink'] as String?,
      avatarKey: json['avatarKey'],
      spinEligable: json['_spinEligable'] as bool?,
      spinResult: json['_spinResult'],
      spinTimestamp: json['_spinTimestamp'] as int?,
      profileValidToUT: json['profileValidToUT'],
      isNotifyIfPlanExpires: json['isNotifyIfPlanExpires'] as bool?,
      isCorporate: json['isCorporate'] as bool?,
      availableActivations: json['availableActivations'] as int?,
      siteName: json['siteName'] as String?,
      siteLogo: json['siteLogo'] as String?,
      zone: json['zone'] as String?,
    );

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'incomingZoneLabel': instance.incomingZoneLabel,
      'creationDate': instance.creationDate,
      'creationDateUt': instance.creationDateUt,
      'creationMode': instance.creationMode,
      'userLanguage': instance.userLanguage,
      'location': instance.location,
      'property': instance.property,
      'room': instance.room,
      'origin': instance.origin,
      'startDate': instance.startDate,
      'startDateUt': instance.startDateUt,
      'userEmail': instance.userEmail,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'profileId': instance.profileId,
      'profileLabel': instance.profileLabel,
      'profileName': instance.profileName,
      'emiratesId': instance.emiratesId,
      'emiratesName': instance.emiratesName,
      'emiratesBirthday': instance.emiratesBirthday,
      'emiratesNationality': instance.emiratesNationality,
      'emiratesGender': instance.emiratesGender,
      'emiratesExpiry': instance.emiratesExpiry,
      'b2CustomerId': instance.b2CustomerId,
      'userRole': instance.userRole,
      'qrCodeLink': instance.qrCodeLink,
      'avatarKey': instance.avatarKey,
      '_spinEligable': instance.spinEligable,
      '_spinResult': instance.spinResult,
      '_spinTimestamp': instance.spinTimestamp,
      'profileValidToUT': instance.profileValidToUT,
      'isNotifyIfPlanExpires': instance.isNotifyIfPlanExpires,
      'availableActivations': instance.availableActivations,
      'isCorporate': instance.isCorporate,
      'siteName': instance.siteName,
      'siteLogo': instance.siteLogo,
      'zone': instance.zone,
    };