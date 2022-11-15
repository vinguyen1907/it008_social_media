import 'dart:io';

import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/story_model.dart';

class VerifyStoryScreen extends StatefulWidget {
  const VerifyStoryScreen({super.key, required this.imagePath});

  final String imagePath;
  static const String id = 'verify_story_screen';

  @override
  State<VerifyStoryScreen> createState() => _VerifyStoryScreenState();
}

class _VerifyStoryScreenState extends State<VerifyStoryScreen> {
  bool isFullScreen = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.darkBackgroundColor,
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              width: size.width,
              height: size.height * 0.82,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  gradient: AppStyles.storyGradient),
              child: FittedBox(
                child: Image.file(
                  File(widget.imagePath),
                  height: size.height * 0.6,
                  width: size.width,
                  fit: isFullScreen ? BoxFit.cover : BoxFit.contain,
                ),
              )),
          Row(
            children: [
              Switch(
                  activeColor: AppColors.primaryMainColor,
                  activeTrackColor: AppColors.primaryMainColor.withOpacity(0.5),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.white.withOpacity(0.5),
                  value: isFullScreen,
                  onChanged: (value) {
                    setState(() {
                      isFullScreen = value;
                    });
                  }),
              const Text('Full screen',
                  style: TextStyle(fontFamily: "Poppins", color: Colors.white)),
            ],
          ),
          SizedBox(
            // height: size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                        size.width / 2 - 2 * Dimensions.defaultHorizontalMargin,
                        46),
                    backgroundColor: const Color(0xFFEEEEEE),
                    foregroundColor: AppColors.primaryMainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                        size.width / 2 - 2 * Dimensions.defaultHorizontalMargin,
                        46),
                    foregroundColor: const Color(0xFFEEEEEE),
                    backgroundColor: AppColors.primaryMainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // final Story newStory = Story(
                    //   id: '1',
                    //   userId: '1',
                    //   imageUrl:
                    //       "https://scontent.fsgn13-3.fna.fbcdn.net/v/t39.30808-6/306644150_1705133096537723_2683053513119986155_n.jpg?stp=cp6_dst-jpg_p960x960&_nc_cat=102&ccb=1-7&_nc_sid=e3f864&_nc_ohc=nWNAtUXtZnEAX8-KgNX&_nc_ht=scontent.fsgn13-3.fna&oh=00_AfBfb7da7Ppb4xb88C-J2FUYW17ldsBOb9pyUWa_KUElrw&oe=63782207",
                    //   isViewed: false,
                    //   createdTime: DateTime.now(),
                    // );
                    // Story.listStories.insert(0, newStory);
                    // Navigator.pop(context);
                  },
                  child: const Text(
                    'Post',
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
