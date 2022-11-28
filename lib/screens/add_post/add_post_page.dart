import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/screens/add_post/add_post_button.dart';
import 'package:it008_social_media/screens/edit_profile/widget/text_form_field.dart';
import 'package:it008_social_media/services/utils.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:it008_social_media/widgets/loading_widget.dart';

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
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: LoadingManager(
        isLoading: isLoading,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.primaryTextColor,
              ),
            ),
            centerTitle: true,
            title: Text(
              "Post",
              style: AppStyles.postUserName
                  .copyWith(fontSize: 18, height: 27 / 18),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 34, bottom: 5),
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
                          icon: SvgPicture.asset(
                            height: 25,
                            width: 25,
                            AppAssets.icAddPost,
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
                      setState(() {
                        isLoading = true;
                      });
                      // 1. create doc to get doc id
                      final postDoc = postsRef.doc();

                      // 2. upload image to firebase storage
                      String? imageUrl;
                      if (pickedImagePath != null) {
                        final imageRef =
                            storageRef.child('post_image/${postDoc.id}');
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
                          userId: user!.uid,
                          uploadTime: Timestamp.now(),
                          imageUrl: imageUrl ?? '',
                          caption: _captionTextController.text,
                          likedUserIdList: []);
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
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
