import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/user_model.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({
    Key? key,
    required this.size,
    required this.imageUrl,
    this.hasBorder = false,
    this.userId,
    this.userName,
    this.userAvatarUrl,
  }) : super(key: key);

  final Size size;
  final String imageUrl;
  final bool hasBorder;
  final String?
      userId; // if userID != null => story, == null => add story button
  final String? userName;
  final String? userAvatarUrl;

  @override
  Widget build(BuildContext context) {
    const Size smallImageSize = Size(25, 25);

    return SizedBox(
      width: size.width / 5.35,
      child: Column(
        // story's image and owner's name
        children: [
          // story's image
          SizedBox(
            height: size.height / 8 + smallImageSize.height / 2,
            child: Stack(
              children: [
                Container(
                    height: size.height / 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1,
                        color: hasBorder ? Colors.black : Colors.grey[200]!,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: imageUrl != ''
                          ? CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              width: size.width / 5.35,
                              height:
                                  size.height / 8 + smallImageSize.height / 2,
                              placeholder: (context, url) =>
                                  Container(color: Colors.grey[200]),
                              errorWidget: (context, url, error) => Container(
                                  color: Colors.grey[200],
                                  child: Image.asset(
                                    AppAssets.defaultImage,
                                    fit: BoxFit.cover,
                                  )),
                            )
                          : Image.asset(
                              AppAssets.defaultImage,
                              fit: BoxFit.cover,
                              width: size.width / 5.35,
                              height:
                                  size.height / 8 + smallImageSize.height / 2,
                            ),
                    )),

                // avatar of user who uploaded this story
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      alignment: Alignment.center,
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          color: AppColors.lightGreyColor,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          )),
                      child: userId != null
                          ? ClipOval(
                              child: userAvatarUrl != ''
                                  ? CachedNetworkImage(
                                      imageUrl: userAvatarUrl ?? '',
                                      placeholder: ((context, url) =>
                                          Container(color: Colors.grey[200])),
                                      height: 25,
                                      width: 25,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      AppAssets.defaultImage,
                                      height: 25,
                                      width: 25,
                                      fit: BoxFit.cover,
                                    ),
                            )
                          : SvgPicture.asset(AppAssets.icPlus,
                              height: 12,
                              width: 12,
                              fit: BoxFit.contain,
                              color: Colors.black),
                    ),
                  ),
                )
              ],
            ),
          ),

          // user's fullName who uploaded this story
          Flexible(
              child: userId != null
                  ? Text(userName ?? "No name",
                      style: AppStyles.storyLabel,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1)
                  : const Text('Add story',
                      style: AppStyles.storyLabel,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1))
        ],
      ),
    );
  }
}
