import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  String id;
  String fromUserId;
  String fromUserName;
  String toUserId;
  String? postId;
  String notificationType;
  Timestamp createdTime;

  Notification({
    required this.id,
    required this.fromUserId,
    required this.fromUserName,
    required this.toUserId,
    this.postId,
    required this.notificationType,
    required this.createdTime,
  });
}
