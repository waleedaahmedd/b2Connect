// List<NotificationModel> notificationModelFromJson(String str) => List<NotificationModel>.from(json.decode(str).map((x) => NotificationModel.fromJson(x)));
//
// String notificationModelToJson(List<NotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

import 'package:json_annotation/json_annotation.dart';
part 'notification_model.g.dart';

// ignore: deprecated_member_use
@JsonSerializable(nullable: false)
class NotificationModel {
  NotificationModel({
    required this.id,
    required this.title,
    required this.level,
    required this.levelName,
    required this.push,
    required this.group,
    required this.groupId,
    required this.topic,
    required this.message,
    required this.timestamp,
    required this.notificationEventId,
  });

  int? id;
  String? title;
  int? level;
  String? levelName;
  bool? push;
  dynamic group;
  dynamic groupId;
  String? topic;
  String? message;
  int? timestamp;
  int? notificationEventId;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
