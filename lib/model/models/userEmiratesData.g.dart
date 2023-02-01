// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userEmiratesData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEmiratesData _$UserEmiratesDataFromJson(Map<String, dynamic> json) =>
    UserEmiratesData(
      emiratesId: json['emiratesId'] as String?,
      emiratesBirthday: json['emiratesBirthday'] as String?,
      emiratesExpiry: json['emiratesExpiry'] as String?,
      emiratesGender: json['emiratesGender'] as String?,
      emiratesName: json['emiratesName'] as String?,
      emiratesNationality: json['emiratesNationality'] as String?,
    );

Map<String, dynamic> _$UserEmiratesDataToJson(UserEmiratesData instance) =>
    <String, dynamic>{
      'emiratesId': instance.emiratesId,
      'emiratesName': instance.emiratesName,
      'emiratesBirthday': instance.emiratesBirthday,
      'emiratesNationality': instance.emiratesNationality,
      'emiratesGender': instance.emiratesGender,
      'emiratesExpiry': instance.emiratesExpiry,
    };
