import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/screens/profile/widget/message_button.dart';
import 'package:it008_social_media/screens/profile/widget/post_widget.dart';
import 'package:it008_social_media/services/could_store_method.dart';
import 'package:provider/provider.dart';
import '../../change_notifies/user_provider.dart';
import '../../services/utils.dart';
import 'widget/follow_button.dart';
import 'widget/follow_infomation_widget.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      FirebaseFirestore.instance.collection('users').doc(widget.uid).get().then((value) {
        userData = value.data()!;
        followers = value.data()?['followers'].length ?? 0;
        following = value.data()?['following'].length ?? 0;
        isFollowing = value.data()?['followers'].contains(FirebaseAuth.instance.currentUser?.uid.toString());
        setState(() {});
      });

      // get post lENGTH
      FirebaseFirestore.instance
          .collection('posts')
          .where(
            'userId',
            isEqualTo: widget.uid,
          )
          .get()
          .then((value) {
        postLen = value.docs.length ?? 1;
      });
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primaryTextColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Profile",
            style: AppStyles.postUserName.copyWith(fontSize: 18, height: 27 / 18),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 28, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: ClipOval(
                            child: Image.network(
                              userData["avatarImageUrl"] != null && userData["avatarImageUrl"] != ""
                                  ? userData["avatarImageUrl"]
                                  : "https://bloganchoi.com/wp-content/uploads/2022/02/avatar-trang-y-nghia.jpeg",
                              width: 67,
                              height: 67,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData['fullName'] ?? "",
                              style: AppStyles.postUserName.copyWith(fontSize: 18),
                            ),
                            Text(
                              userData['address'] ?? "No address yet",
                              style: AppStyles.postUserName.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 24, right: 35),
                      child: Container(
                        width: 142,
                        child: Text(
                          userData['about'] ?? "",
                          style: AppStyles.postUploadTime.copyWith(fontSize: 12, height: 18 / 12),
                          textAlign: TextAlign.start,
                          maxLines: 4,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        MessageButton(
                          onPress: (() {}),
                        ),
                        isFollowing
                            ? FollowButton(
                          title: "UnFollow",
                          onPress: () async {
                            CloudStoreDataManagement()
                                .followUser(
                              userProvider.getUser?.id ?? "",
                              userData['id'],
                            )
                                .then((value) {
                              setState(() {
                                isFollowing = false;
                                followers--;
                              });
                            });
                          },
                        )
                            : FollowButton(
                          title: "Follow",
                          onPress: () async {
                            CloudStoreDataManagement()
                                .followUser(
                              userProvider.getUser?.id ?? "",
                              userData['id'],
                            )
                                .then((value) {
                              setState(() {
                                isFollowing = true;
                                followers++;
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14, bottom: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FollowInformationWidget(
                      label: 'Posts',
                      num: postLen,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      height: 43,
                      child: VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),
                    FollowInformationWidget(
                      label: 'Following',
                      num: following,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      height: 43,
                      child: VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),
                    FollowInformationWidget(
                      label: 'Followers',
                      num: followers,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            spreadRadius: 0,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                            color: AppColors.whiteColor.withOpacity(0.25))
                      ]),
                      width: size.width,
                      child: Divider(
                        thickness: 1,
                      )),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 29),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Posts',
                      style: AppStyles.postUserName
                          .copyWith(fontSize: 14, height: 21 / 14),
                    ),
                  ],
                ),
              ),
              PostWidget(
                uid: widget.uid,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
