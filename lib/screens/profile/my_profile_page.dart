import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/screens/profile/widget/my_discription_label.dart';
import 'package:it008_social_media/screens/profile/widget/post_widget.dart';
import 'package:it008_social_media/screens/profile/widget/edit_profile_button.dart';
import 'package:it008_social_media/screens/profile/widget/follow_widget.dart';
import 'package:it008_social_media/screens/profile/widget/posts_label.dart';
import 'package:it008_social_media/screens/profile/widget/user_infomation_widget.dart';

import '../../constants/app_assets.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
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
              "My Profile",
              style: AppStyles.postUserName
                  .copyWith(fontSize: 18, height: 27 / 18),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                UserInformationWidget(),
                MyDescriptionLabel(),
                EditProfileButton(onTap: () {}),
                FollowWidget(),
                PostLabel(),
                PostWidget(),
              ],
            ),
          )),
    );
  }
}
