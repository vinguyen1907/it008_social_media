import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/enum/notification_type.dart';
import 'package:it008_social_media/models/notification_model.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/screens/comment_screen/comment_screen.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:it008_social_media/utils/global_methods.dart';
import 'package:it008_social_media/widgets/status_tile_widget.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({
    Key? key,
    required this.isActive,
    required this.post,
  }) : super(key: key);

  final bool isActive;
  final Post post;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLiked = false;
  late int likeQuantity;
  // late Post post;

  @override
  void initState() {
    super.initState();
    // post = widget.post;
    isLiked = widget.post.likedUserIdList.contains(user!.uid);
    likeQuantity = widget.post.likedUserIdList.length;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final UserProvider userProvider = Provider.of<UserProvider>(context);

    return GestureDetector(
      onTap: () {
        if (widget.isActive) {
          Navigator.of(context)
              .pushNamed(CommentScreen.id, arguments: widget.post);
        }
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StatusTile(
                title: widget.post.userName,
                subtitle: GlobalMethods.getPeriodTimeToNow(
                    widget.post.uploadTime.toDate()),
                backgroundImageUrl: widget.post.userAvatarUrl,
              ),
              const SizedBox(height: 10),
              widget.post.caption != ""
                  ? Text(widget.post.caption,
                      style: AppStyles.postDescription,
                      textAlign: TextAlign.left)
                  : Container(),
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
                    child: CachedNetworkImage(
                      imageUrl: widget.post.imageUrl,
                      placeholder: (context, url) {
                        return Container(height: 200, color: Colors.grey[200]);
                      },
                      errorWidget: (context, url, error) => Container(),
                    )),
              ),
              const SizedBox(height: 10),
              widget.isActive
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => _handleLike(userProvider),
                          child: SvgPicture.asset(
                              isLiked
                                  ? AppAssets.icLikedHeart
                                  : AppAssets.icHeart,
                              width: 18,
                              height: 18,
                              fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 10),
                        Text("$likeQuantity", style: AppStyles.postReaction),
                        const SizedBox(width: 10),
                        SvgPicture.asset(AppAssets.icComment,
                            width: 18, height: 18, fit: BoxFit.cover),
                        const SizedBox(width: 10),
                        Text("${widget.post.comments.length}",
                            style: AppStyles.postReaction)
                      ],
                    )
                  : Container()
            ],
          )),
    );
  }

  void _handleLike(UserProvider userProvider) {
    // update post in firestore
    List<String> newLikedList =
        List<String>.from(widget.post.likedUserIdList); // copy list
    if (!isLiked) {
      newLikedList.add(user!.uid);
    } else {
      newLikedList.remove(user!.uid);
    }
    // newLikedList.add(user!.uid);
    postsRef.doc(widget.post.id).update({'likedUserIdList': newLikedList});

    // add notification
    if (!isLiked) {
      final notiDoc =
          notificationsRef.doc(user!.uid).collection("notifications").doc();
      final NotificationModel noti = NotificationModel(
          id: notiDoc.id,
          fromUserId: userProvider.getUser!.id!,
          fromUserName: userProvider.getUser!.fullName!,
          fromUserAvatarUrl: userProvider.getUser!.avatarImageUrl!,
          toUserId: widget.post.userId,
          postId: widget.post.id,
          notificationType: NotificationType.like.toString(),
          createdTime: Timestamp.now());
      notiDoc.set(noti.toJson());
    }

    // update UI
    setState(() {
      isLiked = !isLiked;
      likeQuantity = newLikedList.length;
      // widget.post.likedUserIdList = newLikedList;
    });
  }
}
