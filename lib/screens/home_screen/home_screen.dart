import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/models/story_model.dart';
import 'package:it008_social_media/screens/home_screen/search_bar_widget.dart';
import 'package:it008_social_media/screens/home_screen/story_item_widget.dart';

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
                  onPressed: () {},
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
                            onTap: () {}));
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
                          onTap: () {}),
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
                child: PostWidget(size: size),
              );
            }))
        // post
      ]),
    )));
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width - 2 * Dimensions.defaultHorizontalMargin,
        margin: const EdgeInsets.symmetric(
            horizontal: Dimensions.defaultHorizontalMargin),
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.defaultHorizontalMargin,
            vertical: Dimensions.smallVerticalMargin),
        decoration: BoxDecoration(
          color: AppColors.mediumGreyColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(children: [
              const CircleAvatar(
                  radius: 23,
                  backgroundImage: NetworkImage(
                      'https://thumbs.dreamstime.com/b/indian-man-photographer-digital-camera-photography-profession-people-concept-happy-over-grey-background-160101839.jpg')),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Chris',
                    style: AppStyles.postUserName,
                  ),
                  Text(
                    '1hrs ago',
                    style: AppStyles.postUploadTime,
                  ),
                ],
              )
            ]),
            const SizedBox(height: 10),
            const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra",
                style: AppStyles.postDescription),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 0.5,
                  color: Colors.black,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                    'https://blog.adobe.com/en/publish/2021/06/07/media_195b35fcc892daf3ce573058a9626ac720f61f0cd.png?width=750&format=png&optimize=medium'),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(AppAssets.icHeart,
                    width: 15, fit: BoxFit.cover),
                const Text(" ${247}", style: AppStyles.postReaction),
                const SizedBox(width: 10),
                SvgPicture.asset(AppAssets.icComment,
                    width: 15, fit: BoxFit.cover),
                const Text(" ${47}", style: AppStyles.postReaction)
              ],
            )
          ],
        ));
  }
}
