import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String id;
  String email;
  String userName;
  String fullName;
  String avatarImageUrl;
  String about;
  String gender;
  String dateOfBirth;
  User({
    required this.id,
    required this.gender,
    required this.email,
    required this.avatarImageUrl,
    required this.userName,
    required this.fullName,
    required this.about,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'userName': userName,
      'fullName': fullName,
      'avatarImageUrl': avatarImageUrl,
      'about': about,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      email: map['email'] as String,
      userName: map['userName'] as String,
      fullName: map['fullName'] as String,
      avatarImageUrl: map['avatarImageUrl'] as String,
      about: map['about'] as String,
      gender: map['gender'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
    );
  }
}
