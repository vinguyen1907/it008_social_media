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
    required this.onTap,
  }) : super(key: key);

  final Size size;
  final String imageUrl;
  final bool hasBorder;
  final String?
      userId; // if userID != null => story, == null => add story button
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    const Size smallImageSize = Size(25, 25);

    return GestureDetector(
      onTap: () => onTap(),
      child: SizedBox(
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
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          width: size.width / 5.35,
                          height: size.height / 8 + smallImageSize.height / 2,
                          placeholder: (context, url) =>
                              Container(color: Colors.grey[200]),
                          errorWidget: (context, url, error) => Container(
                              color: Colors.grey[200],
                              child: const Center(
                                  child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ))),
                        ),
                        // imageUrl != null
                        //     ?
                        //     Image.network(imageUrl!, loadingBuilder:
                        //             (BuildContext context, Widget child,
                        //                 ImageChunkEvent? loadingProgress) {
                        //         if (loadingProgress == null) {
                        //           return child;
                        //         }
                        //         return Expanded(
                        //           child: Column(children: [
                        //             SizedBox(
                        //               height: 20,
                        //               width: 20,
                        //               child: CircularProgressIndicator(
                        //                 color: AppColors.primaryMainColor,
                        //                 strokeWidth: 3,
                        //                 value: loadingProgress
                        //                             .expectedTotalBytes !=
                        //                         null
                        //                     ? loadingProgress
                        //                             .cumulativeBytesLoaded /
                        //                         loadingProgress
                        //                             .expectedTotalBytes!
                        //                     : null,
                        //               ),
                        //             ),
                        //           ]),
                        //         );
                        //       },
                        //         width: size.width / 5.35,
                        //         height: size.height / 8 +
                        //             smallImageSize.height / 2,
                        //         fit: BoxFit.cover)
                        //     : SvgPicture.asset(AppAssets.imageFailed)
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
                            ? FutureBuilder<DocumentSnapshot>(
                                future: usersRef.doc(userId).get(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    User user = User.fromJson(snapshot.data!
                                        .data() as Map<String, dynamic>);
                                    return ClipOval(
                                      child: user.avatarImageUrl != ''
                                          ? Image.network(
                                              user.avatarImageUrl,
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
                                    );
                                  } else {
                                    return Image.asset(
                                      AppAssets.defaultImage,
                                      height: 25,
                                      width: 25,
                                      fit: BoxFit.cover,
                                    );
                                  }
                                })
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

            // username who upload this story
            Flexible(
                child: userId != null
                    ? FutureBuilder<DocumentSnapshot>(
                        future: usersRef.doc(userId).get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Something went wrong");
                          }

                          if (snapshot.hasData && !snapshot.data!.exists) {
                            return const Text("Document does not exist");
                          }

                          if (snapshot.hasData &&
                              snapshot.connectionState ==
                                  ConnectionState.done) {
                            User user = User.fromJson(
                                snapshot.data!.data() as Map<String, dynamic>);
                            return Text(user.fullName,
                                style: AppStyles.storyLabel,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1);
                          }

                          return Container();
                        })
                    : const Text('Add story',
                        style: AppStyles.storyLabel,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1))
          ],
        ),
      ),
    );
  }
}
