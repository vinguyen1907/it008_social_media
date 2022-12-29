import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:it008_social_media/models/story_model.dart';
import 'package:it008_social_media/services/user_service.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';

class StoryService {
  static Future<void> uploadStory(String imagePath, String? fullName,
      String? avatarImageUrl, bool isFullScreen) async {
    File imageFile = File(imagePath);

    // create a field in ancestor document to avoid being not exist document
    storiesRef.doc(user!.uid).set({'id': user!.uid});

    final docStory = storiesRef.doc(user!.uid).collection('stories').doc();

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
    final followersId = await UserService.getFollowers(user!.uid);
    final Story story = Story(
        id: docStory.id,
        userId: user!.uid,
        userName: fullName ?? "No name",
        userAvatarUrl: avatarImageUrl ?? "",
        imageUrl: imageUrl,
        isFullScreen: isFullScreen,
        createdTime: Timestamp.now(),
        whoCanSee: followersId);

    // 4. push story to firebase firestore
    await docStory.set(story.toJson());
  }

  static Future<List<List<Story>>> getStoriesFromOtherPeople() async {
    List<List<Story>> temp = [];

    List followingPeople = await UserService.getFollowingPeople(user!.uid);

    // get stories from following people
    final snapshot = await storiesRef.get();

    for (var doc in snapshot.docs) {
      final storiesSnapshot = await storiesRef
          .doc(doc.id)
          .collection('stories')
          .where('userId', whereIn: followingPeople)
          // .where('whoCanSee', arrayContains: user!.uid)
          .where('createdTime',
              isGreaterThan: Timestamp.fromDate(
                  DateTime.now().subtract(const Duration(days: 1))))
          .orderBy('createdTime', descending: true)
          .limit(5)
          .get();

      final newStory = storiesSnapshot.docs
          .map((doc) => Story.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      if (newStory.isNotEmpty) {
        temp.add(newStory);
      }
    }
    return temp;
  }
}
