import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/screens/add_post/add_post_button.dart';
import 'package:it008_social_media/screens/edit_profile/widget/text_form_field.dart';
import 'package:it008_social_media/services/utils.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  Uint8List? _image;

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primaryTextColor,
            ),
          ),
          centerTitle: true,
          title: Text(
            "Post",
            style:
                AppStyles.postUserName.copyWith(fontSize: 18, height: 27 / 18),
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
                    'Select Image(s)',
                    style: AppStyles.postUploadTime
                        .copyWith(fontSize: 14, height: 21 / 14),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: size.width,
                      height: 133,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.tetFieldColor,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: _image != null?Image.memory(
                          _image!,
                          width: 67,
                          height: 67,
                          fit: BoxFit.cover,
                        ):Container(),
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
                    'Select Image(s)',
                    style: AppStyles.postUploadTime
                        .copyWith(fontSize: 14, height: 21 / 14),
                  ),
                ),
                TextInputWidget(
                  maxLine: 3,
                  fillColor: AppColors.tetFieldColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 17, bottom: 5),
                  child: Text(
                    'Add hastags',
                    style: AppStyles.postUploadTime
                        .copyWith(fontSize: 14, height: 21 / 14),
                  ),
                ),
                TextInputWidget(
                  maxLine: 1,
                  fillColor: AppColors.tetFieldColor,
                ),
                SizedBox(height: 47,),
                AddPostButton(
                  onTap: (){},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
