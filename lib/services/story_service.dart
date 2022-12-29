import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:it008_social_media/models/story_model.dart';
import 'package:it008_social_media/services/user_service.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';

class StoryService {
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
