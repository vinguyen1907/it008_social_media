import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/screens/profile/widget/description_text.dart';
import 'package:it008_social_media/screens/profile/widget/description_widget.dart';
import 'package:it008_social_media/screens/profile/widget/follow_button.dart';
import 'package:it008_social_media/screens/profile/widget/follow_widget.dart';
import 'package:it008_social_media/screens/profile/widget/follower_widget.dart';
import 'package:it008_social_media/screens/profile/widget/message_button.dart';
import 'package:it008_social_media/screens/profile/widget/post_widget.dart';
import 'package:it008_social_media/screens/profile/widget/posts_label.dart';
import 'package:it008_social_media/screens/profile/widget/user_infomation_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              UserInformationWidget(
                icon: Icon(Icons.more_vert),
              ),
              DescriptionWidget(),
              FollowWidget(),
              FollowerWidget(),
              PostLabel(),
              PostWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
