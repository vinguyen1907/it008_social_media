import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';

class EditProfileButton extends StatelessWidget {
  final VoidCallback onTap;

  const EditProfileButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 12,bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryMainColor,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: 12),
          margin: EdgeInsets.symmetric(horizontal: 28),
          width: size.width,
          child: Center(
              child: Text(
            'Edit Profile',
            style: AppStyles.postUserName.copyWith(
              fontSize: 12,
              height: 18/12,
              color: AppColors.whiteColor,
            )
          ),),
        ),
      ),
    );
  }
}
