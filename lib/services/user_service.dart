import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';

class UserService {
  static Future<List<String>> getFollowers(String userId) async {
    DocumentSnapshot userDoc = await usersRef.doc(userId).get();
    List<String> followers = (userDoc['followers'] as List)
        .map((element) => element.toString())
        .toList();
    return followers;
  }

  static Future<List<String>> getFollowingPeople(String userId) async {
    DocumentSnapshot userDoc = await usersRef.doc(userId).get();
    List<String> following = (userDoc['following'] as List)
        .map((element) => element.toString())
        .toList();
    return following;
  }
}
