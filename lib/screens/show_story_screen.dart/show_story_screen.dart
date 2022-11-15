import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/story_model.dart';
import 'package:it008_social_media/widgets/input_and_send.dart';

class ShowStoryScreen extends StatelessWidget {
  const ShowStoryScreen({Key? key}) : super(key: key);

  static const String id = 'show_story_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: PageView.builder(
          itemCount: Story.listStories.length,
          itemBuilder: (context, index) {
            return StoryWidget(
              backgroundImageUrl: Story.listStories[index].imageUrl,
              isFullScreen: Story.listStories[index].isFullScreen,
            );
          }),
    ));
  }
}

class StoryWidget extends StatelessWidget {
  const StoryWidget(
      {Key? key, required this.backgroundImageUrl, this.isFullScreen = false})
      : super(key: key);

  final String backgroundImageUrl;
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Column(
              children: [
                // background
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: AppStyles.storyGradient,
                    ),
                  ),
                ),

                // bottom bar
                Container(
                  width: size.width,
                  height: size.height * 0.05,
                  margin: const EdgeInsets.only(
                    top: Dimensions.smallVerticalMargin,
                    bottom: Dimensions.smallVerticalMargin,
                  ),
                  padding:
                      const EdgeInsets.only(right: Dimensions.defaultMargin),
                  child: Row(children: [
                    IconButton(
                      iconSize: 25,
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        AppAssets.icHeart,
                        color: Colors.white,
                        height: 25,
                      ),
                    ),
                    InputAndSendWidget(
                        size: size,
                        hintText: "Send message",
                        borderColor: Colors.white,
                        hintColor: Colors.white,
                        textColor: Colors.white,
                        onPressed: () {})
                  ]),
                )
              ],
            ),

            // header
            Column(
              children: [
                // timer bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.defaultHorizontalMargin,
                      vertical: Dimensions.smallVerticalMargin),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const LinearProgressIndicator(
                        minHeight: 5,
                        value: 0.5,
                        color: AppColors.primaryMainColor),
                  ),
                ),
                // tile
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.defaultHorizontalMargin),
                  child: Row(children: [
                    const CircleAvatar(
                        radius: 23,
                        backgroundImage: NetworkImage(
                            'https://thumbs.dreamstime.com/b/indian-man-photographer-digital-camera-photography-profession-people-concept-happy-over-grey-background-160101839.jpg')),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chris',
                          style: AppStyles.postUserName.copyWith(
                            color: Colors.white,
                            shadows: <Shadow>[
                              const Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 3.0,
                                color: Colors.black87,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '1hrs ago',
                          style: AppStyles.postUploadTime.copyWith(
                            color: Colors.white,
                            shadows: <Shadow>[
                              const Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 3.0,
                                color: Colors.black87,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // close button
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: const EdgeInsets.all(0),
                        icon: SvgPicture.asset(AppAssets.icClose,
                            color: Colors.white))
                  ]),
                ),
              ],
            ),

            // image
            Center(
              child: Image.network(
                backgroundImageUrl,
                fit: isFullScreen ? BoxFit.cover : BoxFit.contain,
                height: size.height * 0.6,
                width: size.width,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
