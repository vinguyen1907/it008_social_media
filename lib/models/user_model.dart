// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String id;
  String email;
  String avatarImageUrl;
  String fullName;
  String userName;
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
