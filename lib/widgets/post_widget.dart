import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/screens/comment_screen/comment_screen.dart';
import 'package:it008_social_media/widgets/status_tile_widget.dart';

class PostWidget extends StatelessWidget {
  const PostWidget(
      {Key? key, required this.postImageUrl, required this.avatarImageUrl})
      : super(key: key);

  final String avatarImageUrl;
  final String postImageUrl;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CommentScreen.id);
      },
      child: Container(
          width: size.width - 2 * Dimensions.defaultHorizontalMargin,
          margin: const EdgeInsets.symmetric(
              horizontal: Dimensions.defaultHorizontalMargin),
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.defaultHorizontalMargin,
              vertical: Dimensions.smallVerticalMargin),
          decoration: BoxDecoration(
            color: AppColors.mediumGreyColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              StatusTile(
                title: 'Chris',
                subtitle: '1 hour ago',
                backgroundImageUrl: avatarImageUrl,
              ),
              const SizedBox(height: 10),
              const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pharetra",
                  style: AppStyles.postDescription),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 0.5,
                    color: Colors.black,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(postImageUrl),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(AppAssets.icHeart,
                      width: 15, fit: BoxFit.cover),
                  const Text(" ${247}", style: AppStyles.postReaction),
                  const SizedBox(width: 10),
                  SvgPicture.asset(AppAssets.icComment,
                      width: 15, fit: BoxFit.cover),
                  const Text(" ${47}", style: AppStyles.postReaction)
                ],
              )
            ],
          )),
    );
  }
}
