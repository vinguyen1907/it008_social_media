// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class FollowModel {
  String id;
  String followerId;
  String followingId;
  Timestamp? createdTime;

  FollowModel({
    required this.id,
    required this.followerId,
    required this.followingId,
    required this.createdTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'followerId': followerId,
      'followingId': followingId,
      'createdTime': createdTime,
    };
  }

  factory FollowModel.fromJson(Map<String, dynamic> map) {
    return FollowModel(
      id: map['id'] as String,
      followerId: map['followerId'] as String,
      followingId: map['followingId'] as String,
      createdTime: map['createdTime'] as Timestamp,
    );
  }
}
