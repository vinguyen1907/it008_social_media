import 'package:flutter/material.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:it008_social_media/models/podcast_album.dart';
import 'package:it008_social_media/models/podcast_model.dart';
import 'package:it008_social_media/models/user_model.dart';
import 'package:it008_social_media/services/user_service.dart';
import 'package:it008_social_media/services/utils.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:provider/provider.dart';

class PodcastService {
  static Future<List<Podcast>> getMyPodcast(
      BuildContext context, String userId) async {
    List<Podcast> podcasts = [];

    try {
      final snapshot =
          await podcastsRef.doc(userId).collection('podcasts').get();

      podcasts =
          snapshot.docs.map((doc) => Podcast.fromJson(doc.data())).toList();
    } catch (error) {
      showSnackBar(context, error.toString());
    }

    return podcasts;
  }

  Future<List<PodcastAlbum>> getFollowingPodcastAlbum(
      BuildContext context) async {
    final Users user =
        Provider.of<UserProvider>(context, listen: false).getUser!;
    final List followingPeople = await UserService.getFollowingPeople(user.id!);
    if (followingPeople.isEmpty) {
      return [];
    }

    List<PodcastAlbum> podcastAlbums = [];
    try {
      final allAlbum =
          await podcastsRef.where('userId', whereIn: followingPeople).get();
      podcastAlbums = allAlbum.docs.map((doc) {
        return PodcastAlbum.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (error) {
      showSnackBar(context, error.toString());
    }

    return podcastAlbums;
  }

  Future<List<Podcast>> getNewestPodcasts() async {
    final allPodcastUser = await podcastsRef.get();
    final List<Podcast> podcasts = [];

    for (var doc in allPodcastUser.docs) {
      final ref = await podcastsRef
          .doc(doc.id)
          .collection('podcasts')
          .orderBy('uploadTime', descending: true)
          .limit(1)
          .get();
      podcasts.add(Podcast.fromJson(ref.docs.first.data()));
    }

    return podcasts;
  }
}
