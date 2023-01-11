import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:it008_social_media/models/story_model.dart';
import 'package:it008_social_media/models/user_model.dart';
import 'package:it008_social_media/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';

class StoryService {
  static Future<void> uploadStory(BuildContext context, String imagePath,
      String? fullName, String? avatarImageUrl, bool isFullScreen) async {
    File imageFile = File(imagePath);
    final Users user =
        Provider.of<UserProvider>(context, listen: false).getUser!;

    // create a field in ancestor document to avoid being not exist document
    storiesRef.doc(user.id!).set({'id': user.id!});

    final docStory = storiesRef.doc(user.id!).collection('stories').doc();

    // 1. push image to firebase storage
    final imageRef = storageRef.child('story_image/${docStory.id}');

    try {
      await imageRef.putFile(imageFile);
    } on FirebaseException catch (e) {
      print("ERROR: ${e.toString()}");
    }
    // 2. get image url
    final String imageUrl = await imageRef.getDownloadURL();

    // 3.create story
    final followersId = await UserService.getFollowers(user.id!);
    final Story story = Story(
        id: docStory.id,
        userId: user.id!,
        userName: fullName ?? "No name",
        userAvatarUrl: avatarImageUrl ?? "",
        imageUrl: imageUrl,
        isFullScreen: isFullScreen,
        createdTime: Timestamp.now(),
        whoCanSee: followersId);

    // 4. push story to firebase firestore
    await docStory.set(story.toJson());
  }

  static Future<List<List<Story>>> getStoriesFromOtherPeople(
      BuildContext context) async {
    List<List<Story>> stories = [];
    final Users user =
        Provider.of<UserProvider>(context, listen: false).getUser!;

    List followingPeople = await UserService.getFollowingPeople(user.id!);
    if (followingPeople.isEmpty) {
      return [];
    }

    // get stories from following people
    final snapshot = await storiesRef.get();

    for (var doc in snapshot.docs) {
      final storiesSnapshot = await storiesRef
          .doc(doc.id)
          .collection('stories')
          .where('userId', whereIn: followingPeople)
          // .where('whoCanSee', arrayContains: user.id!)
          .where('createdTime',
              isGreaterThan: Timestamp.fromDate(
                  DateTime.now().subtract(const Duration(days: 1))))
          .orderBy('createdTime', descending: true)
          .limit(5)
          .get();

      final newStory = storiesSnapshot.docs
          .map((doc) => Story.fromJson(doc.data()))
          .toList();
      if (newStory.isNotEmpty) {
        stories.add(newStory);
      }
    }
    return stories;
  }
}
