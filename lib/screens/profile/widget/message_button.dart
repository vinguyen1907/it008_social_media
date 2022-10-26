import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_colors.dart';

class MessageButton extends StatelessWidget {
  const MessageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primaryTextColor,
        ),
        
      ),
      padding: EdgeInsets.only(top: 6,bottom: 5,left: 14,right: 15),
      child: Icon(Icons.message,size: 16,),
    );
  }
}
