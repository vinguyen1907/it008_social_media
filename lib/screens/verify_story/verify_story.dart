import 'dart:io';

import 'package:flutter/material.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/services/story_service.dart';
import 'package:it008_social_media/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class VerifyStoryScreen extends StatefulWidget {
  const VerifyStoryScreen({super.key, required this.imagePath});

  final String imagePath;
  static const String id = 'verify_story_screen';

  @override
  State<VerifyStoryScreen> createState() => _VerifyStoryScreenState();
}

class _VerifyStoryScreenState extends State<VerifyStoryScreen> {
  bool isFullScreen = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return LoadingManager(
      isLoading: isLoading,
      child: Scaffold(
        backgroundColor: AppColors.darkBackgroundColor,
        body: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                  width: size.width,
                  height: size.height * 0.82,
                  decoration: BoxDecoration(
                      color: Colors.white, gradient: AppStyles.storyGradient),
                  child: FittedBox(
                    child: Image.file(
                      File(widget.imagePath),
                      height:
                          isFullScreen ? size.height * 0.82 : size.height * 0.6,
                      width: size.width,
                      fit: isFullScreen ? BoxFit.cover : BoxFit.contain,
                    ),
                  )),
            ),
            Row(
              children: [
                Switch(
                    activeColor: AppColors.primaryMainColor,
                    activeTrackColor:
                        AppColors.primaryMainColor.withOpacity(0.5),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.white.withOpacity(0.5),
                    value: isFullScreen,
                    onChanged: (value) {
                      setState(() {
                        isFullScreen = value;
                      });
                    }),
                const Text('Full screen',
                    style:
                        TextStyle(fontFamily: "Poppins", color: Colors.white)),
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
                          size.width / 2 -
                              2 * Dimensions.defaultHorizontalMargin,
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
                          size.width / 2 -
                              2 * Dimensions.defaultHorizontalMargin,
                          46),
                      foregroundColor: const Color(0xFFEEEEEE),
                      backgroundColor: AppColors.primaryMainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      await handleUploadStory(userProvider);
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
      ),
    );
  }

  Future<void> handleUploadStory(UserProvider userProvider) async {
    setState(() {
      isLoading = true;
    });

    await StoryService.uploadStory(
        context,
        widget.imagePath,
        userProvider.getUser!.fullName,
        userProvider.getUser!.avatarImageUrl,
        isFullScreen);

    setState(() {
      isLoading = false;
    });

    // pop screen
    if (!mounted) return;
    Navigator.pop(context);
  }
}
