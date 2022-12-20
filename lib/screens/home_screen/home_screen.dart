// import 'package:camera/camera.dart';
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/follow_model.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/models/story_model.dart';
import 'package:it008_social_media/models/user_model.dart';
import 'package:it008_social_media/screens/add_post/add_post_button.dart';
import 'package:it008_social_media/screens/edit_profile/widget/text_form_field.dart';
import 'package:it008_social_media/screens/home_screen/select_image_bottom_sheet.dart';
import 'package:it008_social_media/screens/search_screen/search_screen.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:it008_social_media/widgets/loading_widget.dart';
import 'package:it008_social_media/widgets/post_widget.dart';
import 'package:it008_social_media/screens/home_screen/search_bar_widget.dart';
import 'package:it008_social_media/screens/home_screen/story_item_widget.dart';
import 'package:it008_social_media/screens/notification_screen/notification_screen.dart';
import 'package:it008_social_media/widgets/fullscreen_story.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;

  bool isLoading = false;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  List<Post> posts = [];
  late bool isEndOfPostsList;
  List<List<Story>> stories = [];
  List<Story> myStories = [];
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    isEndOfPostsList = false;
    if (posts.isEmpty) {
      getPostsList();
    }
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        await getMorePosts();
      }
    });
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
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
        body: LoadingManager(
      isLoading: isLoading,
      child: SafeArea(
          child: RefreshIndicator(
        onRefresh: () {
          return getPostsList();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(children: [
            _buildSearch(size, context),
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
                      child: GestureDetector(
                        onTap: () async {
                          await showModalBottomSheet<dynamic>(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return ChooseImageModalBottomSheet(size: size);
                              });
                        },
                        child: StoryItem(
                          size: size,
                          imageUrl: userProvider.getUser!.avatarImageUrl ?? '',
                          hasBorder: true,
                        ),
                      )),

                  // my stories
                  StreamBuilder<QuerySnapshot>(
                      stream: storiesRef
                          .doc(user!.uid)
                          .collection('stories')
                          .orderBy('createdTime', descending: true)
                          .snapshots(),
                      builder: ((context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong',
                              style: TextStyle(color: Colors.red));
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SpinKitCircle(
                            color: Colors.blue,
                            size: 50.0,
                          );
                        }
                        myStories = snapshot.data!.docs
                            .map((doc) => Story.fromJson(
                                doc.data() as Map<String, dynamic>))
                            .toList();
                        stories[0] = myStories;
                        return OpenContainer(
                            closedColor: Colors.transparent,
                            closedElevation: 0,
                            closedBuilder: (context, voidCallback) => Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: StoryItem(
                                    size: size,
                                    imageUrl: myStories.first.imageUrl,
                                    userId: myStories.first.userId,
                                    userName: myStories.first.userName,
                                    userAvatarUrl:
                                        myStories.first.userAvatarUrl,
                                  ),
                                ),
                            openBuilder: (context, action) {
                              pageController = PageController(
                                  // initialPage: index
                                  );
                              return FullScreenStory(
                                stories: stories,
                                initialPage: 0,
                              );
                            });
                      })),

                  // stories
                  FutureBuilder<void>(
                      future: getStories(),
                      builder: (context, snapshot) {
                        if (stories.isNotEmpty) {
                          return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: stories.length,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Container();
                                } // already showed my stories above
                                return OpenContainer(
                                    closedColor: Colors.transparent,
                                    closedElevation: 0,
                                    closedBuilder: (context, voidCallback) =>
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: StoryItem(
                                            size: size,
                                            imageUrl:
                                                stories[index].first.imageUrl,
                                            userId: stories[index].first.userId,
                                            userName:
                                                stories[index].first.userName,
                                            userAvatarUrl: stories[index]
                                                .first
                                                .userAvatarUrl,
                                          ),
                                        ),
                                    openBuilder: (context, action) {
                                      pageController =
                                          PageController(initialPage: index);
                                      return FullScreenStory(
                                        stories: stories,
                                        initialPage: index,
                                      );
                                    });
                              });
                        } else {
                          return Container();
                        }
                      }),
                ])),

            const SizedBox(height: 10),

            // list of posts
            posts.isNotEmpty
                ? _buildPostList(size)
                : SvgPicture.asset(AppAssets.emptyPost,
                    height: size.height / 4),
          ]),
        ),
      )),
    ));
  }

  Widget _buildSearch(Size size, BuildContext context) {
    return Hero(
      tag: 'search_bar',
      child: Material(
        type: MaterialType.transparency,
        child: Container(
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
      ),
    );
  }

  ListView _buildPostList(Size size) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: posts.length + 1,
        itemBuilder: (context, index) {
          if (index == posts.length) {
            return Center(
                child: isEndOfPostsList
                    ? const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Dimensions.smallVerticalMargin),
                        child: Text('End of Posts.'),
                      )
                    : const SizedBox(
                        height: 40,
                        width: 20,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )));
          }
          return Padding(
              padding:
                  const EdgeInsets.only(top: Dimensions.smallVerticalMargin),
              child: Stack(
                children: [
                  PostWidget(
                    post: posts[index],
                    isActive: true,
                  ),
                  posts[index].userId == user!.uid
                      ? Positioned(
                          top: 0,
                          right: 20,
                          child: IconButton(
                              icon:
                                  SvgPicture.asset(AppAssets.icMore, width: 20),
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return _buildPostOptionBottomSheet(
                                          size, index, context);
                                    });
                              }))
                      : Container()
                ],
              ));
        });
  }

  Container _buildPostOptionBottomSheet(
      Size size, int index, BuildContext context) {
    return Container(
        width: size.width - 2 * Dimensions.defaultHorizontalMargin,
        padding: const EdgeInsets.only(bottom: 10),
        child: Wrap(
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              width: size.width - 2 * Dimensions.defaultHorizontalMargin,
              child: Column(
                children: [
                  SizedBox(
                    width: size.width,
                    child: TextButton(
                        onPressed: () {
                          _handleDeletePost(context, index);
                        },
                        child: Text("Delete Post",
                            style: AppStyles.bottomSheetSelection
                                .copyWith(color: Colors.red))),
                  ),
                  Container(height: 1, color: Colors.black12),
                  SizedBox(
                    width: size.width,
                    child: TextButton(
                        onPressed: () {
                          _handleEditPost(context, index);
                        },
                        child: const Text("Edit Post",
                            style: AppStyles.bottomSheetSelection)),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  minimumSize: Size(
                      size.width - 2 * Dimensions.defaultHorizontalMargin, 50),
                  backgroundColor: AppColors.primaryMainColor,
                  foregroundColor: Colors.white),
              child: Text("Cancel",
                  style: AppStyles.bottomSheetSelection
                      .copyWith(color: Colors.white)),
            ),
          ],
        ));
  }

  _handleEditPost(BuildContext context, int index) {
    final TextEditingController _captionController =
        TextEditingController(text: posts[index].caption);
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              backgroundColor: Colors.white,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.defaultHorizontalMargin,
                      vertical: Dimensions.defaultMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // EDIT IMAGE: Khi nào rảnh thì làm

                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //       top: 10, bottom: 5),
                      //   child: Text(
                      //     'Select Image',
                      //     style: AppStyles.postUploadTime
                      //         .copyWith(
                      //             fontSize: 14,
                      //             height: 21 / 14),
                      //   ),
                      // ),
                      // Stack(
                      //   children: [
                      //     Container(
                      //       width: size.width,
                      //       // height: 133,
                      //       // padding: EdgeInsets.symmetric(
                      //       //     vertical: pickedImagePath == null ? 60 : 0),
                      //       decoration: BoxDecoration(
                      //         borderRadius:
                      //             BorderRadius.circular(10),
                      //         color: AppColors.tetFieldColor,
                      //       ),
                      //       child: ClipRRect(
                      //           borderRadius:
                      //               BorderRadius.circular(10),
                      //           child:
                      //               // pickedImagePath != null
                      //               //     ? Image.file(File(pickedImagePath!),
                      //               //         fit: BoxFit.fitWidth)
                      //               //     :
                      //               Container()
                      //           // picked != null
                      //           //     ? Image.memory(
                      //           //         _image!,
                      //           //         width: 67,
                      //           //         height: 67,
                      //           //         fit: BoxFit.cover,
                      //           //       )
                      //           //     : Container(),
                      //           ),
                      //     ),
                      //     Positioned(
                      //       bottom: 0,
                      //       right: 0,
                      //       child: IconButton(
                      //         // onPressed: selectImage,
                      //         onPressed: () {},
                      //         icon: Container(
                      //           decoration: BoxDecoration(
                      //             color: Colors.white,
                      //             borderRadius:
                      //                 BorderRadius.circular(
                      //                     15),
                      //           ),
                      //           child: SvgPicture.asset(
                      //             height: 25,
                      //             width: 25,
                      //             AppAssets.icAddPost,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: Dimensions.smallVerticalMargin),
                        child: Text(
                          'Edit caption',
                          style: AppStyles.postUploadTime
                              .copyWith(fontSize: 14, height: 21 / 14),
                        ),
                      ),
                      TextInputWidget(
                        maxLine: 3,
                        fillColor: AppColors.tetFieldColor,
                        textEditingController: _captionController,
                      ),
                      const SizedBox(
                        height: 47,
                      ),
                      AddPostButton(
                        onTap: () {
                          if (posts[index].caption != _captionController.text) {
                            setState(() {
                              posts[index].caption = _captionController.text;
                            });
                            postsRef.doc(posts[index].id).update({
                              'caption': _captionController.text,
                            });
                          }
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ));
        });
  }

  _handleDeletePost(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Delete Post',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
              content: const Text('Are you sure you want to delete this post?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  )),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                      )),
                ),
                TextButton(
                  onPressed: () {
                    postsRef.doc(posts[index].id).delete();
                    setState(() {
                      posts.removeAt(index);
                    });
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('Delete',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.red,
                      )),
                ),
              ]);
        });
  }

  Future<void> getStories() async {
    List<List<Story>> temp = [myStories];
    // get stories from following people
    QuerySnapshot<Object?> snapshot =
        await storiesRef.get(); // all documentSnapshot with user name
    final docs = snapshot.docs;
    for (var doc in docs) {
      final storiesSnapshot = await storiesRef
          .doc(doc.id)
          .collection('stories')
          .where('whoCanSee', arrayContains: user!.uid)
          .limit(20)
          // .where('createdTime',
          //     isGreaterThan: Timestamp.fromDate(
          //         DateTime.now().subtract(const Duration(days: 1))))
          .get();
      final newStory = storiesSnapshot.docs
          .map((doc) => Story.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      temp.add(newStory);
    }
    stories = temp;
  }

  Future<void> getPostsList() async {
    isEndOfPostsList = false;
    QuerySnapshot snapshot =
        await postsRef.orderBy('uploadTime', descending: true).limit(5).get();
    List docs = snapshot.docs;
    setState(() {
      posts = docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<void> getMorePosts() async {
    QuerySnapshot snapshot = await postsRef
        .orderBy('uploadTime', descending: true)
        .startAfter([posts.last.uploadTime])
        .limit(5)
        .get();
    List docs = snapshot.docs;
    final int oldLength = posts.length;
    setState(() {
      posts.addAll(docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    });
    if (oldLength != posts.length - 5) {
      setState(() {
        isEndOfPostsList = true;
      });
    }
  }
}
