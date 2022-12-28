// import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/screens/add_post/add_post_button.dart';
import 'package:it008_social_media/screens/edit_profile/widget/text_form_field.dart';
import 'package:it008_social_media/screens/home_screen/widgets/homescreen_search_bar.dart';
import 'package:it008_social_media/screens/home_screen/widgets/stories.dart';
import 'package:it008_social_media/screens/notification_screen/notification_screen.dart';
import 'package:it008_social_media/services/post_service.dart';
import 'package:it008_social_media/screens/home_screen/bar_item_page.dart';
import 'package:it008_social_media/screens/search_screen/search_screen.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:it008_social_media/widgets/loading_widget.dart';
import 'package:it008_social_media/widgets/post_widget.dart';
import 'package:it008_social_media/widgets/search_bar_widget.dart';
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
  List<Post> posts = [];
  late bool isEndOfPostsList;
  late PageController pageController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isEndOfPostsList = false;
    if (posts.isEmpty) {
      getPostsList(user!.uid);
    }
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        await getMorePosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size size = MediaQuery.of(context).size;
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
        body: LoadingManager(
      isLoading: isLoading,
      child: SafeArea(
          child: RefreshIndicator(
        onRefresh: () {
          return getPostsList(user!.uid);
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(children: [
            const HomeScreenSearchBar(),
            const SizedBox(height: 20),
            // stories
            Container(
                height: size.height / 8 + 12.5 + 20,
                width: size.width,
                margin: const EdgeInsets.only(
                    left: Dimensions.defaultHorizontalMargin),
                child: const Stories()),

            const SizedBox(height: 10),

            // list of posts
            posts.isNotEmpty
                ? _buildPostList(size)
                : Column(
                    children: [
                      SizedBox(height: size.height * 0.1),
                      SvgPicture.asset(
                        AppAssets.emptyPost,
                        height: size.height / 4,
                        width: size.width * 0.5,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text('Follow people to see their posts')
                    ],
                  ),
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
                onPressed: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BarItemPage(),
                    ),
                  );
                }),
                icon: Icon(Icons.image_search),
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
    final TextEditingController captionController =
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
                        textEditingController: captionController,
                      ),
                      const SizedBox(
                        height: 47,
                      ),
                      AddPostButton(
                        onTap: () {
                          if (posts[index].caption != captionController.text) {
                            setState(() {
                              posts[index].caption = captionController.text;
                            });
                            postsRef.doc(posts[index].id).update({
                              'caption': captionController.text,
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

  Future<void> getPostsList(String userId) async {
    isEndOfPostsList = false;
    List<Post> newPosts = await PostService.getPostsFromFB(user!.uid);
    setState(() {
      posts = newPosts;
    });
  }

  Future<void> getMorePosts() async {
    final int oldLength = posts.length;

    List<Post> newPosts =
        await PostService.getMorePostsFromFB(user!.uid, posts.last.uploadTime);
    setState(() {
      posts.addAll(newPosts);
    });

    if (oldLength != posts.length - 5) {
      setState(() {
        isEndOfPostsList = true;
      });
    }
  }
}
