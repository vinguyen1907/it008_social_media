import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_styles.dart';

class FollowInformationWidget extends StatelessWidget {
  final int? num;
  final String? label;
  const FollowInformationWidget({Key? key, this.num, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('${num??0}',style: AppStyles.storyLabel.copyWith(fontSize: 14,height: 21/16),),
        Text(label??'',style: AppStyles.postUserName.copyWith(fontSize: 14,height: 21/14),),
      ],
    );
  }
}
