import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/screens/edit_profile/edit_prodfile_page.dart';
import 'package:it008_social_media/screens/profile/widget/podcast_tab.dart';
import 'package:it008_social_media/screens/profile/widget/post_widget.dart';
import 'package:it008_social_media/screens/profile/widget/edit_profile_button.dart';
import 'package:it008_social_media/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/app_assets.dart';
import '../../services/utils.dart';
import '../sign_in_screen/sign_in.dart';
import 'widget/follow_infomation_widget.dart';

class MyProfilePage extends StatefulWidget {
  final String uid;

  const MyProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

enum Tab { post, podcast }

class _MyProfilePageState extends State<MyProfilePage> {
  var userData = {};
  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;

  Tab selectedTab = Tab.post;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where(
            'userId',
            isEqualTo: widget.uid,
          )
          .get();

      postLen = postSnap.docs.length ?? 1;
      userData = userSnap.data()!;
      followers = userSnap.data()?['followers'].length ?? 0;
      following = userSnap.data()?['following'].length ?? 0;
      isFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid.toString());
      setState(() {});
    } catch (e) {
      // showSnackBar(
      //   context,
      //   e.toString(),
      // );
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          // leading: IconButton(
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          //   icon: Icon(
          //     Icons.arrow_back_ios_new,
          //     color: AppColors.primaryTextColor,
          //   ),
          // ),
          centerTitle: true,
          title: Text(
            "My Profile",
            style:
                AppStyles.postUserName.copyWith(fontSize: 18, height: 27 / 18),
          ),
        ),
        body: SingleChildScrollView(
          child: LoadingManager(
            isLoading: isLoading,
            child: Column(
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
                                userData["avatarImageUrl"] != null &&
                                        userData["avatarImageUrl"] != ""
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
                                style: AppStyles.postUserName
                                    .copyWith(fontSize: 18),
                              ),
                              Text(
                                userData['address'] ?? "No address yet",
                                style: AppStyles.postUserName
                                    .copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () async {
                            await FirebaseAuth.instance
                                .signOut()
                                .whenComplete(() {
                              Provider.of<UserProvider>(context, listen: false)
                                  .clearUser();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignIn(),
                                ),
                              );
                            });
                          },
                          icon: Icon(Icons.logout)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 29, right: 79, top: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        userData['about'] ?? "",
                        style: AppStyles.postUploadTime
                            .copyWith(fontSize: 12, height: 18 / 12),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                EditProfileButton(onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                        name: userData['fullName'] ?? "",
                        address: userData['address'] ?? "no address yet",
                      ),
                    ),
                  );
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FollowInformationWidget(
                      label: 'Posts',
                      num: postLen,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 26),
                      height: 43,
                      child: const VerticalDivider(
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
                      child: const VerticalDivider(
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
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 29),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = Tab.post;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'Posts',
                              style: AppStyles.postUserName.copyWith(
                                  fontSize: 16,
                                  height: 21 / 14,
                                  color: selectedTab == Tab.post
                                      ? AppColors.primaryMainColor
                                      : AppColors.primaryTextColor),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 2,
                              width: size.width * 0.5 - 30,
                              color: selectedTab == Tab.post
                                  ? AppColors.primaryMainColor
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTab = Tab.podcast;
                          });
                        },
                        child: Column(
                          children: [
                            Text(
                              'Podcasts',
                              style: AppStyles.postUserName.copyWith(
                                  fontSize: 16,
                                  height: 21 / 14,
                                  color: selectedTab == Tab.podcast
                                      ? AppColors.primaryMainColor
                                      : AppColors.primaryTextColor),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 2,
                              width: size.width * 0.5 - 30,
                              color: selectedTab == Tab.podcast
                                  ? AppColors.primaryMainColor
                                  : Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                selectedTab == Tab.post
                    ? PostWidget(
                        uid: widget.uid,
                      )
                    : PodcastTab(userId: widget.uid),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
