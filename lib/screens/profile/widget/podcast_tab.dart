import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:it008_social_media/models/podcast_model.dart';
import 'package:it008_social_media/screens/play_podcast_screen/play_podcast_screen.dart';
import 'package:it008_social_media/services/podcast_service.dart';
import 'package:it008_social_media/services/router.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';

class PodcastTab extends StatelessWidget {
  const PodcastTab({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 7),
      child: FutureBuilder(
        future: PodcastService.getMyPodcast(userId),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final List<Podcast> podcasts = snapshot.data as List<Podcast>;

            if (podcasts.isEmpty) {
              return Center(
                child: Text('This user has no podcast'),
              );
            }

            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              shrinkWrap: true,
              itemCount: podcasts.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PlayPodcastScreen.id,
                        arguments: PlayPodcastArguments(
                            authorName: userId, podcast: podcasts[index]));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: podcasts[index].imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) {
                        return Container(color: Colors.grey[200]);
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
