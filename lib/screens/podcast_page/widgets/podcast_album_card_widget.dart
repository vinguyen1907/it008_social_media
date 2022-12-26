import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/podcast_album.dart';

class PodcastAlbumCardWidget extends StatelessWidget {
  const PodcastAlbumCardWidget(
      {super.key,
      required this.album,
      required this.imageSize,
      required this.onTap});

  final PodcastAlbum album;
  final Size imageSize;
  final Function onTap;

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
                  imageUrl: album.userAvatarUrl,
                  errorWidget: (context, url, error) => Container(
                      color: Colors.grey[200], child: const Icon(Icons.error)),
                  height: imageSize.width,
                  width: imageSize.width,
                  fit: BoxFit.cover),
            ),
            SizedBox(
              width: imageSize.width,
              child: Text(album.userName,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.podcastItemLabel),
            ),
          ],
        ),
      ),
    );
  }
}
