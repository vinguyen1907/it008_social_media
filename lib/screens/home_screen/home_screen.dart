// import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/models/follow_model.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/models/story_model.dart';
import 'package:it008_social_media/models/user_model.dart';
import 'package:it008_social_media/screens/home_screen/select_image_bottom_sheet.dart';
import 'package:it008_social_media/screens/search_screen/search_screen.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:it008_social_media/widgets/post_widget.dart';
import 'package:it008_social_media/screens/home_screen/search_bar_widget.dart';
import 'package:it008_social_media/screens/home_screen/story_item_widget.dart';
import 'package:it008_social_media/screens/notification_screen/notification_screen.dart';
import 'package:it008_social_media/screens/show_story_screen.dart/show_story_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;
  // int postQuantity = 5;
  // final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(() async {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     setState(() {
    //       postQuantity += 5;
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: RefreshIndicator(
      onRefresh: () {
        return postsRef
            .orderBy('uploadTime', descending: true)
            // .limit(postQuantity)
            .get();
      },
      child: SingleChildScrollView(
        // controller: _scrollController,
        child: Column(children: [
          Container(
            width: size.width - Dimensions.defaultHorizontalMargin,
            height: 35,
            margin: const EdgeInsets.only(
                top: 20, left: Dimensions.defaultHorizontalMargin),
            child: Row(
              children: [
                SearchBar(
                  controller: _searchController,
                  readOnly: true,
                  onTap: () {
                    Navigator.of(context).pushNamed(SearchScreen.id);
                  },
                ),
                IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      Navigator.pushNamed(context, NotificationScreen.id);
                    },
                    icon: SvgPicture.asset(AppAssets.icNotification,
                        width: 18, fit: BoxFit.cover)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
              height: size.height / 8 + 12.5 + 20,
              width: size.width,
              margin: const EdgeInsets.only(
                  left: Dimensions.defaultHorizontalMargin),
              child: ListView(scrollDirection: Axis.horizontal, children: [
                // add story button
                Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: FutureBuilder(
                        future: getCurrentUser(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            final Users user = snapshot.data as Users;
                            return StoryItem(
                                size: size,
                                imageUrl: user.avatarImageUrl ?? "",
                                hasBorder: true,
                                onTap: () {
                                  showModalBottomSheet<dynamic>(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) {
                                        return ChooseImageModalBottomSheet(
                                            size: size);
                                      });
                                });
                          } else if (snapshot.hasError) {
                            return const Text("Error");
                          } else {
                            return Container();
                            // CircularProgressIndicator();
                          }
                        }))),

                // stories from current user
                StreamBuilder<List<Story>>(
                    stream: getStoryListStreamFromFirebase(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final stories = snapshot.data;

                        return ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: stories!.where((story) {
                            return story.userId == user!.uid &&
                                DateTime.now()
                                    .subtract(const Duration(days: 1))
                                    .isBefore(story.createdTime.toDate());
                          }).map((story) {
                            return FutureBuilder<Users?>(
                                future: getUserFromFirebaseByID(story.userId),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          right: Dimensions
                                              .defaultHorizontalMargin),
                                      child: StoryItem(
                                          size: size,
                                          imageUrl: story.imageUrl,
                                          hasBorder: false,
                                          userId: story.userId,
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, ShowStoryScreen.id,
                                                arguments: story);
                                          }),
                                    );
                                  } else if (snapshot.hasError) {
                                    return const Text("Error");
                                  } else {
                                    return Container();
                                    // const CircularProgressIndicator();
                                  }
                                });
                          }).toList(),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error.toString()}");
                      } else {
                        return Container();
                        // const CircularProgressIndicator();
                      }
                    }),

                // stories from following people(order by timestamp)
                FutureBuilder<List<Story?>>(
                    future: storiesRef
                        .orderBy('createdTime')
                        .snapshots()
                        .map((snapshot) {
                      return snapshot.docs.map((doc) {
                        List<String> followingList =
                            List<String>.from(doc['whoCanSee']);
                        if (followingList.contains(user!.uid)) {
                          return Story.fromJson(
                              doc.data() as Map<String, dynamic>);
                        }
                      }).toList();
                    }).first,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: snapshot.data!.map((story) {
                            if (story != null) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    right: Dimensions.defaultHorizontalMargin),
                                child: StoryItem(
                                    size: size,
                                    imageUrl: story.imageUrl,
                                    hasBorder: false,
                                    userId: story.userId,
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, ShowStoryScreen.id,
                                          arguments: story);
                                    }),
                              );
                            } else {
                              return Container();
                            }
                          }).toList(),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error.toString()}");
                      } else {
                        return Container();
                        // const CircularProgressIndicator();
                      }
                    }),
              ])),

          const SizedBox(height: 10),

          // list of posts
          FutureBuilder<QuerySnapshot>(
              future: postsRef
                  .orderBy('uploadTime', descending: true)
                  // .limit(postQuantity)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List docs = snapshot.data!.docs;

                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        Post post = Post.fromJson(
                            docs[index].data() as Map<String, dynamic>);

                        return Padding(
                            padding: const EdgeInsets.only(
                                top: Dimensions.smallVerticalMargin),
                            child: PostWidget(
                              post: post,
                            ));
                      });
                } else {
                  return Container();
                }
              })
        ]),
      ),
    )));
  }

  Future<Users?> getCurrentUser() async {
    final docUser = usersRef.doc(user!.uid);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return Users.fromJson(snapshot.data()! as Map<String, dynamic>);
    }
  }

  Future<Users?> getUserFromFirebaseByID(String userId) async {
    final docUser = usersRef.doc(userId);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return Users.fromJson(snapshot.data() as Map<String, dynamic>);
    }
  }

  Stream<List<Story>> getStoryListStreamFromFirebase() {
    return storiesRef
        .orderBy('createdTime', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Story.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<List<Story>> getStoryListFromFirebase() async {
    final snapshot = await storiesRef.get();
    return snapshot.docs.map((doc) {
      return Story.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<bool> isFollowing(
      {required String followerId, required followingId}) async {
    bool result = false;
    final snapshot = await followRef.get();

    snapshot.docs.forEach((doc) {
      final FollowModel follow =
          FollowModel.fromJson(doc.data() as Map<String, dynamic>);
      // print(
      //     "FB: follower: \"${follow.followerId}\" - following: \"${follow.followingId}\"");
      // print("follower: \"$followerId\" - following: \"$followingId\"");

      if (follow.followerId.trim() == followerId &&
          follow.followingId.trim() == followingId) {
        // print("true ne");
        result = true;
      } else {
        // print("false ne");
        result = false;
      }
    });
    return result;
  }
}
