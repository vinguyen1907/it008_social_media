import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';

class PostService {
  static Future<List<Post>> getPostsFromFB() async {
    QuerySnapshot snapshot =
        await postsRef.orderBy('uploadTime', descending: true).limit(5).get();
    List docs = snapshot.docs;
    return docs
        .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  static Future<List<Post>> getMorePostsFromFB(Timestamp lastUploadTime) async {
    QuerySnapshot snapshot = await postsRef
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
