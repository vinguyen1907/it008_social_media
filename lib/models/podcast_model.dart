import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Podcast {
  String id;
  String title;
  String imageUrl;
  String audioUrl;
  String backgroundType;
  String userId;
  String userName;
  String userAvatarImageUrl;
  Timestamp uploadTime;
  Podcast({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.audioUrl,
    required this.backgroundType,
    required this.userId,
    required this.userName,
    required this.userAvatarImageUrl,
    required this.uploadTime,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
      'backgroundType': backgroundType,
      'userId': userId,
      'userName': userName,
      'userAvatarImageUrl': userAvatarImageUrl,
      'uploadTime': uploadTime,
    };
  }

  factory Podcast.fromJson(Map<String, dynamic> map) {
    return Podcast(
      id: map['id'] as String,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      audioUrl: map['audioUrl'] as String,
      backgroundType: map['backgroundType'] as String,
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      userAvatarImageUrl: map['userAvatarImageUrl'] as String,
      uploadTime: map['uploadTime'] as Timestamp,
    );
  }
}
