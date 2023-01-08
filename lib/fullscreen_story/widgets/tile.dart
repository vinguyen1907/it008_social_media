import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/utils/global_methods.dart';

class StoryTile extends StatelessWidget {
  StoryTile(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.time});

  final String imageUrl;
  String name;
  String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.defaultHorizontalMargin),
      child: Row(children: [
        ClipOval(
            child: imageUrl != ""
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    height: 46,
                    width: 46,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    AppAssets.defaultImage,
                    height: 46,
                    width: 46,
                    fit: BoxFit.cover,
                  )),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: AppStyles.postUserName.copyWith(
                color: Colors.white,
                shadows: <Shadow>[
                  const Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 3.0,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
            Text(
              time,
              style: AppStyles.postUploadTime.copyWith(
                color: Colors.white,
                shadows: <Shadow>[
                  const Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 3.0,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
          ],
        ),
        const Spacer(),
        // close button
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: const EdgeInsets.all(0),
            icon: SvgPicture.asset(AppAssets.icClose, color: Colors.white))
      ]),
    );
  }
}
