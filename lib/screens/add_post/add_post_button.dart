import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';

class AddPostButton extends StatelessWidget {
  final VoidCallback onTap;
  const AddPostButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryMainColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.smallVerticalMargin),
        width: size.width,
        child: Center(
          child: Text('Upload',
              style: AppStyles.postUserName.copyWith(
                fontSize: 18,
                height: 27 / 18,
                color: AppColors.whiteColor,
              )),
        ),
      ),
    );
  }
}
