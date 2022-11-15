import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_styles.dart';

class PostLabel extends StatelessWidget {
  const PostLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 29),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Posts',style: AppStyles.postUserName.copyWith(fontSize: 14,height: 21/14),),
        ],
      ),
    );
  }
}
