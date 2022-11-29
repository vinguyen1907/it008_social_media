// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String id;
  String content;
  String userId;
  String userName;
  String userAvatarUrl;
  Timestamp createdTime;

  Comment(
      {required this.id,
      required this.content,
      required this.userId,
      required this.userName,
      required this.userAvatarUrl,
      required this.createdTime});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'userId': userId,
      'userName': userName,
      'userAvatarUrl': userAvatarUrl,
      'createdTime': createdTime,
    };
  }

  factory Comment.fromJson(Map<String, dynamic> map) {
    return Comment(
      id: map['id'] as String,
      content: map['content'] as String,
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      userAvatarUrl: map['userAvatarUrl'] as String,
      createdTime: map['createdTime'] as Timestamp,
    );
  }
}
