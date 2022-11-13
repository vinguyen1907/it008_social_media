import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/screens/profile/widget/follow_button.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 24,right: 35),
      child: Container(
        width: 142,
        child: Text(
          'I’m a postive person. I love to travel and eat Always available for chat',
          style: AppStyles.postUploadTime
              .copyWith(fontSize: 12, height: 18 / 12),
          textAlign: TextAlign.start,
          maxLines: 4,
        ),
      ),
    );
  }
}
