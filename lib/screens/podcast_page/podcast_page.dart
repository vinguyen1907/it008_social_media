import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/enum/podcast_background_colors.dart';
import 'package:it008_social_media/models/podcast_album.dart';
import 'package:it008_social_media/models/podcast_model.dart';
import 'package:it008_social_media/screens/play_podcast_screen/play_podcast_screen.dart';
import 'package:it008_social_media/screens/podcast_page/widgets/add_new_podcast_widget.dart';
import 'package:it008_social_media/screens/podcast_page/widgets/podcast_album_card_widget.dart';
import 'package:it008_social_media/screens/podcast_page/widgets/podcast_item_widget.dart';
import 'package:it008_social_media/screens/show_all_podcast/show_all_podcast.dart';
import 'package:it008_social_media/services/router.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';

class PodcastPage extends StatelessWidget {
  const PodcastPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Podcast',
            style:
                AppStyles.postUserName.copyWith(fontSize: 18, height: 27 / 18),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding:
              const EdgeInsets.only(left: Dimensions.defaultHorizontalMargin),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AddNewPodcastWidget(),
                const SizedBox(height: 20),
                const Text('Newest Podcasts', style: AppStyles.headerTitle),
                const SizedBox(height: 10),
                FutureBuilder<List<Podcast>>(
                    future: getNewestPodcasts(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: size.width / 4 + 36,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return PodcastItemWidget(
                                    podcast: snapshot.data![index],
                                    maxLines: 2,
                                    imageSize:
                                        Size(size.width / 4, size.width / 4),
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, PlayPodcastScreen.id,
                                          arguments: PlayPodcastArguments(
                                              podcast: snapshot.data![index],
                                              authorName:
                                                  'The Present Writer'));
                                    });
                              }),
                        );
                      } else {
                        return Container();
                      }
                    }),
                const SizedBox(height: 20),
                const Text('Following Podcasts', style: AppStyles.headerTitle),
                const SizedBox(height: 10),
                FutureBuilder<List<PodcastAlbum>>(
                    future: getFollowingList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<PodcastAlbum> albumList = snapshot.data!;
                        return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemCount: albumList.length,
                            itemBuilder: (context, index) {
                              return PodcastAlbumCardWidget(
                                  album: albumList[index],
                                  imageSize: Size(
                                      size.width / 2 - 30, size.width / 2 - 30),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ShowAllPodcastScreen.id,
                                        arguments: albumList[index].userId);
                                  });
                            });
                      } else {
                        return Container();
                      }
                    })
              ],
            ),
          ),
        ));
  }

  Future<List<Podcast>> getNewestPodcasts() async {
    final allPodcastUser = await podcastsRef.get();
    final List<Podcast> podcasts = [];

    for (var doc in allPodcastUser.docs) {
      final ref = await podcastsRef
          .doc(doc.id)
          .collection('podcasts')
          .orderBy('uploadTime')
          .limit(1)
          .get();
      podcasts.add(Podcast.fromJson(ref.docs.first.data()));
    }

    return podcasts;
  }

  Future<List<PodcastAlbum>> getFollowingList() async {
    final allAlbum = await podcastsRef.get();
    if (allAlbum.docs.isEmpty) {
      return [];
    }
    return allAlbum.docs.map((doc) {
      return PodcastAlbum.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
