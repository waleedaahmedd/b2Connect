// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      level: json['level'] as int?,
      levelName: json['levelName'] as String?,
      push: json['push'] as bool?,
      group: json['group'],
      groupId: json['groupId'],
      topic: json['topic'] as String?,
      message: json['message'] as String?,
      timestamp: json['timestamp'] as int?,
      notificationEventId: json['notificationEventId'] as int?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'level': instance.level,
      'levelName': instance.levelName,
      'push': instance.push,
      'group': instance.group,
      'groupId': instance.groupId,
      'topic': instance.topic,
      'message': instance.message,
      'timestamp': instance.timestamp,
      'notificationEventId': instance.notificationEventId,
    };
