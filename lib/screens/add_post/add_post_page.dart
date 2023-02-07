import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/enum/notification_type.dart';
import 'package:it008_social_media/models/notification_model.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/models/user_model.dart';
import 'package:it008_social_media/screens/add_post/add_post_button.dart';
import 'package:it008_social_media/screens/edit_profile/widget/text_form_field.dart';
import 'package:it008_social_media/services/utils.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:it008_social_media/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  // Uint8List? _image;
  String? pickedImagePath;
  bool isLoading = false;
  final TextEditingController _captionTextController = TextEditingController();

  selectImage() async {
    // Uint8List im = await pickImage(ImageSource.gallery);
    // // set state because we need to display the image we selected on the circle avatar
    // setState(() {
    //   _image = im;
    // });
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        pickedImagePath = pickedImage.path;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _captionTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: LoadingManager(
        isLoading: isLoading,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                "Post",
                style: AppStyles.postUserName
                    .copyWith(fontSize: 18, height: 27 / 18),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.defaultHorizontalMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(
                        'Select Image',
                        style: AppStyles.postUploadTime
                            .copyWith(fontSize: 14, height: 21 / 14),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          width: size.width,
                          // height: 133,
                          padding: EdgeInsets.symmetric(
                              vertical: pickedImagePath == null ? 60 : 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.tetFieldColor,
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: pickedImagePath != null
                                  ? Image.file(File(pickedImagePath!),
                                      fit: BoxFit.fitWidth)
                                  : Container()
                              // picked != null
                              //     ? Image.memory(
                              //         _image!,
                              //         width: 67,
                              //         height: 67,
                              //         fit: BoxFit.cover,
                              //       )
                              //     : Container(),
                              ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: selectImage,
                            icon: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: SvgPicture.asset(
                                height: 25,
                                width: 25,
                                AppAssets.icAddPost,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 17, bottom: 5),
                      child: Text(
                        'Add caption',
                        style: AppStyles.postUploadTime
                            .copyWith(fontSize: 14, height: 21 / 14),
                      ),
                    ),
                    TextInputWidget(
                      maxLine: 3,
                      fillColor: AppColors.tetFieldColor,
                      textEditingController: _captionTextController,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 17, bottom: 5),
                    //   child: Text(
                    //     'Add hashtags',
                    //     style: AppStyles.postUploadTime
                    //         .copyWith(fontSize: 14, height: 21 / 14),
                    //   ),
                    // ),
                    // const TextInputWidget(
                    //   maxLine: 1,
                    //   fillColor: AppColors.tetFieldColor,
                    // ),
                    const SizedBox(
                      height: 47,
                    ),
                    AddPostButton(
                      onTap: () async {
                        await _handleAddPost(userProvider);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _handleAddPost(UserProvider userProvider) async {
    final Users user =
        Provider.of<UserProvider>(context, listen: false).getUser!;

    // if don't have image or don't have caption
    if (_captionTextController.text.isEmpty || pickedImagePath == null) {
      showSnackBar(context, 'You must add an image or caption.');
      return;
    }

    setState(() {
      isLoading = true;
    });
    // 1. create doc to get doc id
    final postDoc = postsRef.doc();

    // 2. upload image to firebase storage
    String? imageUrl;
    if (pickedImagePath != null) {
      final imageRef = storageRef.child('post_image/${postDoc.id}');
      File image = File(pickedImagePath!);
      try {
        await imageRef.putFile(image);
      } on FirebaseException catch (e) {
        print(e);
      }
      imageUrl = await imageRef.getDownloadURL();
    }

    // 3. upload post to firestore
    Post newPost = Post(
        id: postDoc.id,
        userId: user.id!,
        userName: userProvider.getUser!.fullName ?? "No user name",
        userAvatarUrl: userProvider.getUser!.avatarImageUrl ?? "",
        uploadTime: Timestamp.now(),
        imageUrl: imageUrl ?? '',
        caption: _captionTextController.text,
        likedUserIdList: [],
        comments: []);
    postsRef.doc(postDoc.id).set(newPost.toJson());

    // 4. notify upload successfully
    if (!mounted) return;
    showSnackBar(context, 'Successfully');

    // 5. reset add post screen
    setState(() {
      pickedImagePath = null;
      _captionTextController.clear();
    });

    setState(() {
      isLoading = false;
    });

    // Add notification to followers
    // 1. get list followers
    List<String> followersId = [];
    followRef.where('followingId', isEqualTo: user.id!).get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        followersId.add(doc['followerId']);
      });

      // 2. create notification
      for (String id in followersId) {
        final doc = notificationsRef.doc(id).collection('notifications').doc();
        NotificationModel notification = NotificationModel(
            id: doc.id,
            fromUserId: userProvider.getUser!.id!,
            fromUserName: userProvider.getUser!.fullName!,
            fromUserAvatarUrl: userProvider.getUser!.avatarImageUrl!,
            toUserId: id,
            postId: newPost.id,
            notificationType: NotificationType.addPost.toString(),
            createdTime: Timestamp.now(),
            isSeen: false);
        doc.set(notification.toJson());
      }
    });

    // Dismiss keyboard
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
