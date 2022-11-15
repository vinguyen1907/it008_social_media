// import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/models/story_model.dart';
import 'package:it008_social_media/screens/add_story_screen/add_story_screen.dart';
import 'package:it008_social_media/screens/comment_screen/comment_screen.dart';
import 'package:it008_social_media/screens/verify_story/verify_story.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(children: [
        Container(
          width: size.width - Dimensions.defaultHorizontalMargin,
          height: 35,
          margin: const EdgeInsets.only(
              top: 20, left: Dimensions.defaultHorizontalMargin),
          child: Row(
            children: [
              const SearchBar(),
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
            margin:
                const EdgeInsets.only(left: Dimensions.defaultHorizontalMargin),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Story.listStories.length + 1, // +1 for add story
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: StoryItem(
                            size: size,
                            imageUrl:
                                "https://scontent.fsgn5-3.fna.fbcdn.net/v/t39.30808-6/305767392_1705138999870466_4301266471825436049_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=TEekvpIie7AAX9GVyUi&_nc_ht=scontent.fsgn5-3.fna&oh=00_AfDNmlzwi27l6jwX1pHVgAqa8XukRMrnoP6DcrGR1wycHA&oe=6375D37D",
                            hasBorder: true,
                            label: "Add Story",
                            onTap: () {
                              // // Obtain a list of the available cameras on the device.
                              // final cameras = await availableCameras();

                              // // Get a specific camera from the list of available cameras.
                              // final firstCamera = cameras.first;

                              // Navigator.pushNamed(context, AddStoryScreen.id,
                              //     arguments: firstCamera);
                              showModalBottomSheet<dynamic>(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return ChooseImageModalBottomSheet(
                                        size: size);
                                  });
                            }));
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: StoryItem(
                          size: size,
                          imageUrl: Story.listStories[index - 1].imageUrl,
                          label: "Chris",
                          smallImage: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              'https://thumbs.dreamstime.com/b/indian-man-photographer-digital-camera-photography-profession-people-concept-happy-over-grey-background-160101839.jpg',
                              height: 25,
                              width: 25,
                              fit: BoxFit.cover,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, ShowStoryScreen.id);
                          }),
                    );
                  }
                })),

        const SizedBox(height: 10),

        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: Post.listPosts.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding:
                    const EdgeInsets.only(top: Dimensions.smallVerticalMargin),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, CommentScreen.id);
                  },
                  child: PostWidget(
                      postImageUrl: Post.listPosts[index].imageUrl,
                      avatarImageUrl:
                          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
                ),
              );
            }))
        // post
      ]),
    )));
  }
}

class ChooseImageModalBottomSheet extends StatefulWidget {
  const ChooseImageModalBottomSheet({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<ChooseImageModalBottomSheet> createState() =>
      _ChooseImageModalBottomSheetState();
}

class _ChooseImageModalBottomSheetState
    extends State<ChooseImageModalBottomSheet> {
  Future<String?> pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) {
        print("No image selected");
        return null;
      }
      return image.path;
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.size.width - 2 * Dimensions.defaultHorizontalMargin,
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
              width: widget.size.width - 2 * Dimensions.defaultHorizontalMargin,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final String? path = await pickImage(ImageSource.camera);

                      if (!mounted) return;

                      if (path != null) {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, VerifyStoryScreen.id,
                            arguments: path);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text("Camera",
                            style: AppStyles.bottomSheetSelection)),
                  ),
                  Container(height: 1, color: Colors.black12),
                  GestureDetector(
                    onTap: () async {
                      final String? path = await pickImage(ImageSource.gallery);

                      if (!mounted) return;

                      if (path != null) {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, VerifyStoryScreen.id,
                            arguments: path);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: const Text("Photo Library",
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
                      widget.size.width -
                          2 * Dimensions.defaultHorizontalMargin,
                      50),
                  backgroundColor: AppColors.primaryMainColor,
                  foregroundColor: Colors.white),
              child: Text("Cancel",
                  style: AppStyles.bottomSheetSelection
                      .copyWith(color: Colors.white)),
            ),
          ],
        ));
  }
}
