import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_colors.dart';

class IconMessageButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPress;
  const IconMessageButton({Key? key, required this.onPress, required this.iconPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>onPress.call(),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryMainColor,
          borderRadius: BorderRadius.circular(7)
        ),
        padding: EdgeInsets.all(7),
        child: Image.asset(iconPath),
      ),
    );
  }
}
