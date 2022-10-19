import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/models/story_model.dart';
import 'package:it008_social_media/screens/add_story_screen/add_story_screen.dart';
import 'package:it008_social_media/widgets/post_widget.dart';
import 'package:it008_social_media/screens/home_screen/search_bar_widget.dart';
import 'package:it008_social_media/screens/home_screen/story_item_widget.dart';
import 'package:it008_social_media/screens/notification_screen/notification_screen.dart';
import 'package:it008_social_media/screens/show_story_screen.dart/show_story_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(children: [
        Container(
          width: size.width - Dimensions.defaultHorizontalMargin,
          margin: const EdgeInsets.only(
              top: 20, left: Dimensions.defaultHorizontalMargin),
          child: Row(
            children: [
              const Expanded(
                child: SizedBox(
                  height: 34,
                  child: SearchBar(),
                ),
              ),
              IconButton(
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
                                "https://s3.cloud.cmctelecom.vn/tinhte2/2020/09/5136156_IMG_20200902_023158.jpg",
                            hasBorder: true,
                            label: "Add Story",
                            onTap: () {
                              Navigator.pushNamed(context, AddStoryScreen.id);
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
                child: PostWidget(
                    postImageUrl: Post.listPosts[index].imageUrl,
                    avatarImageUrl:
                        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
              );
            }))
        // post
      ]),
    )));
  }
}
