import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/comment_model.dart';
import 'package:it008_social_media/utils/global_methods.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: Row(
        children: [
          Column(
            children: [
              ClipOval(
                child: comment.userAvatarUrl != ""
                    ? CachedNetworkImage(
                        imageUrl: comment.userAvatarUrl,
                        errorWidget: (context, url, error) {
                          return Container(
                              color: Colors.grey[200],
                              child: const Icon(Icons.error));
                        },
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover)
                    : Image.asset(
                        AppAssets.defaultImage,
                        height: 40,
                        width: 40,
                      ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(comment.userName),
                Text(comment.content, style: AppStyles.postDescription)
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(GlobalMethods.getPeriodTimeToNow(comment.createdTime.toDate()),
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}
