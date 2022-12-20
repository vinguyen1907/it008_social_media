import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/enum/podcast_background_colors.dart';
import 'package:it008_social_media/screens/add_post/add_post_button.dart';
import 'package:it008_social_media/screens/edit_profile/widget/text_form_field.dart';

import '../constants/app_colors.dart';

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

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

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
          body: SafeArea(
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
                                      borderRadius: BorderRadius.circular(100),
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            maximumSize: const Size(50, 50),
                            minimumSize: const Size(50, 50),
                            backgroundColor: AppColors.buttonGreyColor),
                        child: SvgPicture.asset(AppAssets.icAudio)),
                    const SizedBox(height: 10),
                    AddPostButton(onTap: () {})
                  ],
                ),
              ),
            ),
          )),
    );
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
}
