// import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/models/user_model.dart';
import 'package:it008_social_media/screens/add_post/add_post_button.dart';
import 'package:it008_social_media/screens/edit_profile/widget/text_form_field.dart';
import 'package:it008_social_media/screens/home_screen/widgets/homescreen_search_bar.dart';
import 'package:it008_social_media/screens/home_screen/widgets/post_option_bottom_sheet.dart';
import 'package:it008_social_media/screens/home_screen/widgets/stories.dart';
import 'package:it008_social_media/services/post_service.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:it008_social_media/widgets/loading_widget.dart';
import 'package:it008_social_media/widgets/post_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  bool isKeepAlive = true;
  @override
  bool get wantKeepAlive => isKeepAlive;

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
    getPostsList();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        await getMorePosts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size size = MediaQuery.of(context).size;
    Users user = Provider.of<UserProvider>(context).getUser!;

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

            // posts
            posts.isNotEmpty
                ? _buildPostList(size, user)
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
                      const Text('Follow people to see their posts'),
                      IconButton(
                          onPressed: () => getPostsList(),
                          icon: const Icon(Icons.refresh))
                    ],
                  ),
          ]),
        ),
      )),
    ));
  }

  ListView _buildPostList(Size size, Users user) {
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
                  posts[index].userId == user.id
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
                                      return PostOptionsBottomSheet(
                                          onDeletePost: () =>
                                              _handleDeletePost(context, index),
                                          onEditPost: () =>
                                              _handleEditPost(context, index));
                                    });
                              }))
                      : Container()
                ],
              ));
        });
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
                          updatePostCaption(index, captionController.text);
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

  void updatePostCaption(int index, String newCaption) {
    if (posts[index].caption != newCaption) {
      setState(() {
        posts[index].caption = newCaption;
      });
      postsRef.doc(posts[index].id).update({
        'caption': newCaption,
      });
    }
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

  Future<void> getPostsList() async {
    isEndOfPostsList = false;
    List<Post> newPosts = await PostService.getPostsFromFB(context);
    setState(() {
      posts = newPosts;
    });
  }

  Future<void> getMorePosts() async {
    final int oldLength = posts.length;
    final Users user =
        Provider.of<UserProvider>(context, listen: false).getUser!;

    List<Post> newPosts =
        await PostService.getMorePostsFromFB(user.id!, posts.last.uploadTime);
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
