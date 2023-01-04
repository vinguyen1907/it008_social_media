import 'dart:convert';

import 'package:it008_social_media/models/podcast_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PodcastAlbum {
  String userId;
  String userName;
  String userAvatarUrl;
  List<Podcast> podcastList;
  PodcastAlbum(
      {required this.userId,
      required this.userName,
      required this.userAvatarUrl,
      required this.podcastList});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'userAvatarUrl': userAvatarUrl,
    };
  }

  factory PodcastAlbum.fromJson(Map<String, dynamic> map) {
    return PodcastAlbum(
        userId: map['userId'] as String,
        userName: map['userName'] as String,
        userAvatarUrl: map['userAvatarUrl'] as String,
        podcastList: []);
  }
}
