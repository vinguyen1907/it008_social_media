import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_colors.dart';

class MessageButton extends StatelessWidget {
    final VoidCallback? onPress;
  const MessageButton({Key? key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress?.call(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primaryTextColor,
          ),
        ),
        padding: EdgeInsets.only(top: 6,bottom: 5,left: 14,right: 15),
        child: Icon(Icons.message,size: 16,),
      ),
    );
  }
}
