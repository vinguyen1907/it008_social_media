import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:it008_social_media/models/story_model.dart';
import 'package:it008_social_media/screens/home_screen/widgets/select_image_bottom_sheet.dart';
import 'package:it008_social_media/screens/home_screen/widgets/story_item_widget.dart';
import 'package:it008_social_media/services/story_service.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:it008_social_media/widgets/fullscreen_story.dart';
import 'package:provider/provider.dart';

class Stories extends StatefulWidget {
  const Stories({super.key});

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  List<List<Story>> stories = [];
  List<Story> myStories = [];

  late PageController pageController;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return ListView(scrollDirection: Axis.horizontal, children: [
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
              .where('createdTime',
                  isGreaterThan: Timestamp.fromDate(
                      DateTime.now().subtract(const Duration(days: 1))))
              .orderBy('createdTime', descending: true)
              .snapshots(),
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong',
                  style: TextStyle(color: Colors.red));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SpinKitCircle(
                color: Colors.blue,
                size: 50.0,
              );
            }
            myStories = snapshot.data!.docs
                .map(
                    (doc) => Story.fromJson(doc.data() as Map<String, dynamic>))
                .toList();
            // stories[0] = myStories;
            if (myStories.isNotEmpty) {
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
                          userAvatarUrl: myStories.first.userAvatarUrl,
                        ),
                      ),
                  openBuilder: (context, action) {
                    pageController = PageController(
                        // initialPage: index
                        );
                    return FullScreenStory(
                      stories: stories[0].isNotEmpty
                          ? [myStories, ...stories]
                          : [myStories],
                      initialPage: 0,
                    );
                  });
            } else {
              return Container();
            }
          })),

      // stories
      FutureBuilder<void>(
          future: getStories(),
          builder: (context, snapshot) {
            if (stories.isNotEmpty && stories[0].isNotEmpty) {
              return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    return OpenContainer(
                        closedColor: Colors.transparent,
                        closedElevation: 0,
                        closedBuilder: (context, voidCallback) => Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: StoryItem(
                                size: size,
                                imageUrl: stories[index].first.imageUrl,
                                userId: stories[index].first.userId,
                                userName: stories[index].first.userName,
                                userAvatarUrl:
                                    stories[index].first.userAvatarUrl,
                              ),
                            ),
                        openBuilder: (context, action) {
                          pageController = PageController(initialPage: index);
                          return FullScreenStory(
                            stories: stories[0].isNotEmpty
                                ? [myStories, ...stories]
                                : [myStories],
                            initialPage: index + 1,
                          );
                        });
                  });
            } else {
              return Container();
            }
          }),
    ]);
  }

  Future<void> getStories() async {
    stories = await StoryService.getStoriesFromOtherPeople();
  }
}
