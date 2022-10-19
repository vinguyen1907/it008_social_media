import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/story_model.dart';

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
    return Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(Dimensions.defaultMargin),
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: (isFullScreen == true) ? BoxFit.cover : BoxFit.contain,
          image: NetworkImage(
            backgroundImageUrl,
          ),
        )),
        child: Column(
          children: [
            // time bar
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const LinearProgressIndicator(
                  minHeight: 5, value: 0.5, color: AppColors.primaryMainColor),
            ),
            const SizedBox(height: 30),
            // tile
            Row(children: [
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
                    style: isFullScreen
                        ? AppStyles.postUserName.copyWith(
                            color: Colors.white,
                            shadows: <Shadow>[
                              const Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 3.0,
                                color: Colors.black87,
                              ),
                            ],
                          )
                        : AppStyles.postUserName,
                  ),
                  Text(
                    '1hrs ago',
                    style: isFullScreen
                        ? AppStyles.postUploadTime.copyWith(
                            color: Colors.white,
                            shadows: <Shadow>[
                              const Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 3.0,
                                color: Colors.black87,
                              ),
                            ],
                          )
                        : AppStyles.postUploadTime,
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
                      color: isFullScreen
                          ? Colors.white
                          : AppColors.primaryMainColor))
            ]),
          ],
        ));
  }
}
