import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/story_model.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:it008_social_media/widgets/loading_widget.dart';

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
    print(widget.imagePath);

    return LoadingManager(
      isLoading: isLoading,
      child: Scaffold(
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
                      setState(() {
                        isLoading = true;
                      });
                      // 1. push image to firebase storage
                      File imageFile = File(widget.imagePath);

                      final docStory = storiesRef.doc();

                      final imageRef =
                          storageRef.child('story_image/${docStory.id}');

                      try {
                        await imageRef.putFile(imageFile);
                      } on FirebaseException catch (e) {
                        print("ERROR: ${e.toString()}");
                      }
                      // 2. get image url
                      final String imageUrl = await imageRef.getDownloadURL();

                      // 3. push story to firebase firestore
                      final followersId = await getFlowersId(user!.uid);
                      final Story story = Story(
                          id: docStory.id,
                          userId: user!.uid,
                          imageUrl: imageUrl,
                          isFullScreen: isFullScreen,
                          createdTime: Timestamp.now(),
                          whoCanSee: followersId);
                      await storiesRef.doc(docStory.id).set(story.toJson());
                      setState(() {
                        isLoading = false;
                      });

                      // 4. pop screen
                      if (!mounted) return;
                      Navigator.pop(context);
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

  Future<List<String>> getFlowersId(String uid) async {
    List<String> ids = [];
    final snapshot = await followRef.get();
    snapshot.docs.forEach((doc) {
      if (doc['followingId'] == uid) {
        ids.add(doc['followerId']);
      }
    });
    return ids;
  }
}
