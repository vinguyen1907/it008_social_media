// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? id;
  String? email;
  String? avatarImageUrl;
  String? fullName;
  String? userName;
  String? about;
  String? gender;
  String? dateOfBirth;

  Users({
    required this.id,
    required this.gender,
    required this.email,
    required this.avatarImageUrl,
    required this.userName,
    required this.fullName,
    required this.about,
    required this.dateOfBirth,
  });

  static Users fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Users(
      id: snapshot['id']??"",
      gender: snapshot['gender']??"",
      email: snapshot['email']??null,
      avatarImageUrl: snapshot['avatarImageUrl']??"https://images.ctfassets.net/lh3zuq09vnm2/yBDals8aU8RWtb0xLnPkI/19b391bda8f43e16e64d40b55561e5cd/How_tracking_user_behavior_on_your_website_can_improve_customer_experience.png",
      userName: snapshot['userName']??"",
      fullName: snapshot['fullName']??"",
      about: snapshot['about']??"",
      dateOfBirth: snapshot['dateOfBirth']??"",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "avatarImageUrl": avatarImageUrl,
        "fullName": fullName,
        "userName": userName,
        "about": about,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
      };
}
