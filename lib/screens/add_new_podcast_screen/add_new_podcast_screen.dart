import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/enum/podcast_background_colors.dart';
import 'package:it008_social_media/models/podcast_model.dart';
import 'package:it008_social_media/screens/add_post/add_post_button.dart';
import 'package:it008_social_media/screens/edit_profile/widget/text_form_field.dart';
import 'package:it008_social_media/services/utils.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:it008_social_media/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

import '../../constants/app_colors.dart';

class AddNewPodcastScreen extends StatefulWidget {
  const AddNewPodcastScreen({super.key});

  static const id = 'add_new_podcast_screen';

  @override
  State<AddNewPodcastScreen> createState() => _AddNewPodcastScreenState();
}

class _AddNewPodcastScreenState extends State<AddNewPodcastScreen> {
  int selectedColorIndex = 0;
  final TextEditingController _titleTextController = TextEditingController();
  String? pickedImagePath;
  File? pickedAudioFile;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Add new podcast',
              style: AppStyles.postUserName
                  .copyWith(fontSize: 18, height: 27 / 18),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.primaryTextColor,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
          body: LoadingManager(
            isLoading: isLoading,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.defaultHorizontalMargin),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () async {
                            await selectImage();
                          },
                          child: _buildImage(size)),
                      const Text('Choose background',
                          style: AppStyles.addPodcastSectionTitle),
                      // color buttons to choose background color
                      SizedBox(
                        height: 28,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...List.generate(podcastBackgroundColors.length,
                                (index) {
                              return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColorIndex = index;
                                    });
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: podcastBackgroundColors[index],
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: index == selectedColorIndex
                                            ? Border.all(
                                                color: Colors.black, width: 1.5)
                                            : Border.all(
                                                color: Colors.transparent),
                                      ),
                                      height: 28,
                                      width: 28,
                                      child: index == 0
                                          ? SvgPicture.asset(
                                              AppAssets.icEmptyBackgroundButton,
                                            )
                                          : Container()));
                            }),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Add title',
                          style: AppStyles.addPodcastSectionTitle),
                      TextInputWidget(
                        maxLine: 3,
                        fillColor: AppColors.tetFieldColor,
                        textEditingController: _titleTextController,
                      ),
                      const SizedBox(height: 10),
                      const Text('Add audio',
                          style: AppStyles.addPodcastSectionTitle),
                      ElevatedButton(
                          onPressed: () {
                            _handlePickAudio();
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              maximumSize: const Size(50, 50),
                              minimumSize: const Size(50, 50),
                              backgroundColor: pickedAudioFile != null
                                  ? Colors.greenAccent
                                  : AppColors.buttonGreyColor),
                          child: SvgPicture.asset(AppAssets.icAudio)),
                      const SizedBox(height: 10),
                      AddPostButton(onTap: () {
                        _handleAddPodcast(userProvider);
                      })
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  _handlePickAudio() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      setState(() {
        pickedAudioFile = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  selectImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        pickedImagePath = pickedImage.path;
      });
    }
  }

  _buildImage(Size size) {
    if (pickedImagePath != null) {
      if (selectedColorIndex == 0) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(File(pickedImagePath!),
              width: size.width - 40,
              height: size.width - 40,
              fit: BoxFit.cover),
        );
      } else {
        return Container(
          height: size.width - 40,
          width: size.width - 40,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    podcastBackgroundImage[selectedColorIndex],
                  ).image)),
          alignment: Alignment.center,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(File(pickedImagePath!),
                width: size.width * 0.45,
                height: size.width * 0.45,
                fit: BoxFit.cover),
          ),
        );
      }
    } else {
      return Image.asset(podcastBackgroundImage[selectedColorIndex]);
    }
  }

  _handleAddPodcast(UserProvider userProvider) async {
    // if don't have image and caption
    if (!(_titleTextController.text.isNotEmpty &&
        pickedImagePath != null &&
        pickedAudioFile != null)) {
      showSnackBar(context, 'You must add an image and caption.');
      return;
    }

    setState(() {
      isLoading = true;
    });
    // 1. create doc to get doc id
    final podcastDoc =
        podcastsRef.doc(userProvider.getUser!.id!).collection("podcasts").doc();

    // 2.1.  upload image to firebase storage
    String? imageUrl;
    if (pickedImagePath != null) {
      final imageRef = storageRef.child('podcasts/image/${podcastDoc.id}');
      File image = File(pickedImagePath!);
      try {
        await imageRef.putFile(image);
      } on FirebaseException catch (e) {
        print(e);
      }
      imageUrl = await imageRef.getDownloadURL();
    }

    // 2.2.  upload audio to firebase storage
    String? audioUrl;
    if (pickedAudioFile != null) {
      final audioRef = storageRef.child('podcasts/audio/${podcastDoc.id}');
      // File image = File(pickedImagePath!);
      try {
        await audioRef.putFile(pickedAudioFile!);
      } on FirebaseException catch (e) {
        print(e);
      }
      audioUrl = await audioRef.getDownloadURL();
    }

    // 3. upload podcast to firestore
    Podcast newPodcast = Podcast(
        id: podcastDoc.id,
        title: _titleTextController.text,
        imageUrl: imageUrl ?? '',
        audioUrl: audioUrl!,
        backgroundType: PodcastBackgroundColorsValue.values
            .elementAt(selectedColorIndex)
            .toString(),
        uploadTime: Timestamp.now(),
        userName: userProvider.getUser!.fullName!);
    podcastDoc.set(newPodcast.toJson());
    podcastsRef.doc(userProvider.getUser!.id).set({
      'userId': userProvider.getUser!.id!,
      'userName': userProvider.getUser!.fullName!,
      'userAvatarUrl': userProvider.getUser!.avatarImageUrl!,
    }, SetOptions(merge: true));

    // 4. notify upload successfully
    if (!mounted) return;
    showSnackBar(context, 'Successfully');

    // 5. reset add podcast screen
    setState(() {
      pickedImagePath = null;
      _titleTextController.clear();
      pickedAudioFile = null;
    });

    setState(() {
      isLoading = false;
    });

    // Add notification to followers
    // 1. get list followers
    // List<String> followersId = [];
    // followRef.where('followingId', isEqualTo: user!.uid).get().then((snapshot) {
    //   snapshot.docs.forEach((doc) {
    //     followersId.add(doc['followerId']);
    //   });

    // 2. create notification
    // for (String id in followersId) {
    //   final doc = notificationsRef.doc(id).collection('notifications').doc();
    //   NotificationModel notification = NotificationModel(
    //       id: doc.id,
    //       fromUserId: userProvider.getUser!.id!,
    //       fromUserName: userProvider.getUser!.fullName!,
    //       fromUserAvatarUrl: userProvider.getUser!.avatarImageUrl!,
    //       toUserId: id,
    //       postId: newPost.id,
    //       notificationType: NotificationType.addPost.toString(),
    //       createdTime: Timestamp.now());
    //   doc.set(notification.toJson());
    // }
    // });

    // Dismiss keyboard
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
