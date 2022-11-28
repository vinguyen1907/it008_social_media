// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  String id;
  String userId;
  String imageUrl;
  // bool isViewed;
  bool isFullScreen;
  Timestamp createdTime;
  List<String> whoCanSee;

  Story({
    required this.id,
    required this.userId,
    required this.imageUrl,
    // required this.isViewed,
    required this.createdTime,
    this.isFullScreen = true,
    required this.whoCanSee,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'imageUrl': imageUrl,
      // 'isViewed': isViewed,
      'isFullScreen': isFullScreen,
      'createdTime': createdTime,
      'whoCanSee': whoCanSee,
    };
  }

  factory Story.fromJson(Map<String, dynamic> map) {
    return Story(
      id: map['id'] as String,
      userId: map['userId'] as String,
      imageUrl: map['imageUrl'] as String,
      // isViewed: map['isViewed'] as bool,
      isFullScreen: map['isFullScreen'] as bool,
      createdTime: map['createdTime'] as Timestamp,
      whoCanSee: List<String>.from(map['whoCanSee']),
    );
  }
}
