import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/podcast_model.dart';

class PodcastItemWidget extends StatelessWidget {
  const PodcastItemWidget(
      {Key? key,
      required this.podcast,
      required this.imageSize,
      this.textAlign = TextAlign.start,
      this.maxLines = 1,
      required this.onTap,
      this.isAlbum = false,
      this.orderOfEpisode})
      : super(key: key);

  final bool isAlbum;
  final Podcast podcast;
  final Size imageSize;
  final TextAlign textAlign;
  final int maxLines;
  final Function onTap;
  final int? orderOfEpisode;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      width: imageSize.width,
      child: GestureDetector(
        onTap: () => onTap(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                  imageUrl:
                      // isAlbum ? podcast.userAvatarImageUrl :
                      podcast.imageUrl,
                  errorWidget: (context, url, error) => Container(
                      color: Colors.grey[200], child: const Icon(Icons.error)),
                  height: imageSize.width,
                  width: imageSize.width,
                  fit: BoxFit.cover),
            ),
            SizedBox(
              width: imageSize.width,
              child: Text(
                  // isAlbum ? podcast.userName :
                  'Episode${orderOfEpisode != null ? ' $orderOfEpisode' : ''}: ${podcast.title}',
                  textAlign: textAlign,
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.podcastItemLabel),
            ),
          ],
        ),
      ),
    );
  }
}
