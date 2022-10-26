import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/screens/edit_profile/widget/text_form_field.dart';
import 'package:it008_social_media/screens/edit_profile/widget/update_button.dart';
import 'package:it008_social_media/services/utils.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styles.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
            "Profile",
            style:
                AppStyles.postUserName.copyWith(fontSize: 18, height: 27 / 18),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //crossAxisAlignment: CrossAxisAlignment.,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                _image != null
                                    ? ClipOval(
                                        child: Image.memory(
                                          _image!,
                                          width: 67,
                                          height: 67,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : ClipOval(
                                        child: Image.network(
                                          'https://i.stack.imgur.com/l60Hf.png',
                                          width: 67,
                                          height: 67,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                Positioned(
                                  left: 32,
                                  bottom: -14,
                                  child: IconButton(
                                    onPressed: selectImage,
                                    icon: SvgPicture.asset(
                                      height: 14,
                                      width: 16,
                                      AppAssets.icCamera,
                                      color: AppColors.primaryTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Oyin Dolapo",
                                style: AppStyles.postUserName
                                    .copyWith(fontSize: 18),
                              ),
                              Text(
                                "Abeokuta, Ogun",
                                style: AppStyles.postUserName
                                    .copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Username",
                  style: AppStyles.postUserName
                      .copyWith(fontSize: 14, height: 21 / 14),
                ),
                SizedBox(
                  height: 5,
                ),
                TextInputWidget(
                  maxLine: 1,
                  fillColor: AppColors.tetFieldColor,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Region",
                  style: AppStyles.postUserName
                      .copyWith(fontSize: 14, height: 21 / 14),
                ),
                SizedBox(
                  height: 5,
                ),
                TextInputWidget(
                  maxLine: 1,
                  fillColor: AppColors.tetFieldColor,
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Phone Number',
                            style: AppStyles.postUserName
                                .copyWith(fontSize: 14, height: 21 / 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextInputWidget(
                            maxLine: 1,
                            fillColor: AppColors.tetFieldColor,
                          ),
                        ],
                      ), //Container
                    ),
                    SizedBox(
                      width: 22,
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gender',
                            style: AppStyles.postUserName
                                .copyWith(fontSize: 14, height: 21 / 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextInputWidget(
                            maxLine: 1,
                            fillColor: AppColors.tetFieldColor,
                          ),
                        ],
                      ), //Container
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "About",
                  style: AppStyles.postUserName
                      .copyWith(fontSize: 14, height: 21 / 14),
                ),
                SizedBox(
                  height: 5,
                ),
                TextInputWidget(
                  maxLine: 3,
                  fillColor: AppColors.tetFieldColor,
                ),
                SizedBox(
                  height: 49,
                ),
                UpdateButton(
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
