import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/podcast_model.dart';
import 'package:it008_social_media/screens/play_podcast_screen/play_podcast_screen.dart';
import 'package:it008_social_media/screens/podcast_page/widgets/podcast_item_widget.dart';
import 'package:it008_social_media/services/router.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';

class ShowAllPodcastScreen extends StatelessWidget {
  const ShowAllPodcastScreen({super.key, required this.authorId});

  static const id = 'show_all_podcast_screen';
  final String authorId;

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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primaryTextColor,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(left: Dimensions.defaultHorizontalMargin),
            child: FutureBuilder<List<Podcast>>(
              future: getPodcast(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<Podcast> podcasts = snapshot.data!;
                  return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        childAspectRatio: 0.89,
                      ),
                      itemCount: podcasts.length,
                      itemBuilder: (context, index) {
                        return PodcastItemWidget(
                          maxLines: 2,
                          podcast: podcasts[index],
                          imageSize:
                              Size(size.width / 2 - 30, size.width / 2 - 30),
                          onTap: () {
                            Navigator.pushNamed(context, PlayPodcastScreen.id,
                                arguments: PlayPodcastArguments(
                                    podcast: snapshot.data![index],
                                    authorName: 'The Present Writer'));
                          },
                          orderOfEpisode: index + 1,
                        );
                      });
                } else {
                  return Container();
                }
              },
            ),
          ),
        ));
  }

  Future<List<Podcast>> getPodcast() async {
    final snapshot =
        await podcastsRef.doc(authorId).collection('podcasts').get();
    return snapshot.docs.map((doc) => Podcast.fromJson(doc.data())).toList();
  }
}
