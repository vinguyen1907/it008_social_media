// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id;
  String userId;
  String userName;
  String userAvatarUrl;
  Timestamp uploadTime;
  String imageUrl;
  String caption;
  List<String> likedUserIdList;

  Post(
      {required this.id,
      required this.userId,
      required this.userName,
      required this.userAvatarUrl,
      required this.uploadTime,
      required this.imageUrl,
      required this.caption,
      required this.likedUserIdList});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'userName': userName,
      'userAvatarUrl': userAvatarUrl,
      'uploadTime': uploadTime,
      'imageUrl': imageUrl,
      'caption': caption,
      'likedUserIdList': likedUserIdList,
    };
  }

  factory Post.fromJson(Map<String, dynamic> map) {
    return Post(
      id: map['id'] as String,
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      userAvatarUrl: map['userAvatarUrl'] as String,
      uploadTime: map['uploadTime'] as Timestamp,
      imageUrl: map['imageUrl'] as String,
      caption: map['caption'] as String,
      likedUserIdList:
          List<String>.from((map['likedUserIdList'] as List<String>)),
    );
  }
}
