// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String id;
  String fromUserId;
  String fromUserName;
  String fromUserAvatarUrl;
  String toUserId;
  String? postId;
  String notificationType;
  Timestamp createdTime;
  bool isSeen;

  NotificationModel({
    required this.id,
    required this.fromUserId,
    required this.fromUserName,
    required this.fromUserAvatarUrl,
    required this.toUserId,
    this.postId,
    required this.notificationType,
    required this.createdTime,
    required this.isSeen,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'fromUserId': fromUserId,
      'fromUserName': fromUserName,
      'fromUserAvatarUrl': fromUserAvatarUrl,
      'toUserId': toUserId,
      'postId': postId,
      'notificationType': notificationType,
      'createdTime': createdTime,
      "isSeen": isSeen,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as String,
      fromUserId: map['fromUserId'] as String,
      fromUserName: map['fromUserName'] as String,
      fromUserAvatarUrl: map['fromUserAvatarUrl'] as String,
      toUserId: map['toUserId'] as String,
      postId: map['postId'] != null ? map['postId'] as String : null,
      notificationType: map['notificationType'] as String,
      createdTime: map['createdTime'] as Timestamp,
      isSeen: map['isSeen'] ?? false,
    );
  }
}
