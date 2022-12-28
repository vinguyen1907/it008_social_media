import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:it008_social_media/models/story_model.dart';
import 'package:it008_social_media/services/user_service.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';

class StoryService {
  static Future<List<List<Story>>> getStoriesFromOtherPeople() async {
    List<List<Story>> temp = [];

    List followingPeople = await UserService.getFollowingPeople(user!.uid);

    // get stories from following people
    QuerySnapshot<Object?> snapshot =
        await storiesRef.get(); // all documentSnapshot with user name
    final docs = snapshot.docs;
    for (var doc in docs) {
      final storiesSnapshot = await storiesRef
          .doc(doc.id)
          .collection('stories')
          .where('whoCanSee', arrayContains: user!.uid)
          .where('createdTime',
              isGreaterThan: Timestamp.fromDate(
                  DateTime.now().subtract(const Duration(days: 1))))
          .where('userId', whereIn: followingPeople)
          .limit(20)
          .get();
      final newStory = storiesSnapshot.docs
          .map((doc) => Story.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      temp.add(newStory);
    }
    return temp;
  }
}
