import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_styles.dart';

class MyDescriptionLabel extends StatelessWidget {
  const MyDescriptionLabel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 29, right: 79,top: 12),
      child: Text(
        'I’m a postive person. I love to travel and eat Always available for chat',
        style: AppStyles.postUploadTime
            .copyWith(fontSize: 12, height: 18 / 12),
        textAlign: TextAlign.start,
        maxLines: 2,
      ),
    );
  }
}
