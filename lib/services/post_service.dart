import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/services/user_service.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:provider/provider.dart';

class PostService {
  static Future<List<Post>> getPostsFromFB(String userId) async {
    // get followers list
    List followingPeople = await UserService.getFollowingPeople(userId);
    followingPeople.add(userId);

    // get posts from followers
    QuerySnapshot snapshot = await postsRef
        .where('userId', whereIn: followingPeople)
        .orderBy('uploadTime', descending: true)
        .limit(5)
        .get();
    List docs = snapshot.docs;
    return docs
        .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  static Future<List<Post>> getMorePostsFromFB(
      String userId, Timestamp lastUploadTime) async {
    // get followers list
    List followingPeople = await UserService.getFollowingPeople(userId);
    followingPeople.add(userId);

    QuerySnapshot snapshot = await postsRef
        .where('userId', whereIn: followingPeople)
        .orderBy('uploadTime', descending: true)
        .startAfter([lastUploadTime])
        .limit(5)
        .get();
    List docs = snapshot.docs;
    return docs
        .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
