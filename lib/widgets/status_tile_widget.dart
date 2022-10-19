import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';

class StatusTile extends StatelessWidget {
  const StatusTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.backgroundImageUrl})
      : super(key: key);

  final String title;
  final String subtitle;
  final String backgroundImageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(children: [
        CircleAvatar(
            radius: 23, backgroundImage: NetworkImage(backgroundImageUrl)),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppStyles.postUserName,
            ),
            Text(
              subtitle,
              style: AppStyles.postUploadTime,
            ),
          ],
        )
      ]),
    );
  }
}
