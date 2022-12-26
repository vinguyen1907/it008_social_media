import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';

class FollowButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPress;
  const FollowButton({Key? key, this.onPress, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 9, right: 20),
      child: GestureDetector(
        onTap: () => onPress?.call(),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryMainColor,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 26, vertical: 6),
          child: Center(
            child: Text(
              title,
              style: AppStyles.postUploadTime.copyWith(
                height: 18 / 12,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
