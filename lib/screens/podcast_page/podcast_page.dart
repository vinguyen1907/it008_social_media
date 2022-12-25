import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/enum/podcast_background_colors.dart';
import 'package:it008_social_media/models/podcast_model.dart';
import 'package:it008_social_media/screens/play_podcast_screen/play_podcast_screen.dart';
import 'package:it008_social_media/screens/podcast_page/widgets/add_new_podcast_widget.dart';
import 'package:it008_social_media/screens/podcast_page/widgets/podcast_item_widget.dart';

class PodcastPage extends StatelessWidget {
  const PodcastPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Podcast podcast = Podcast(
        id: '1',
        title: "Episode 1: How to make our life happier?",
        imageUrl:
            "https://thumbs.dreamstime.com/b/beautiful-landscape-dry-tree-branch-sun-flowers-field-against-colorful-evening-dusky-sky-use-as-natural-background-backdrop-48319427.jpg",
        audioUrl: '',
        backgroundType: PodcastBackgroundColorsValue.green.toString(),
        userId: '',
        userName: 'The Present Writer',
        userAvatarImageUrl: '',
        uploadTime: Timestamp.now());

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
                SizedBox(
                  height: size.width / 4 + 36,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return PodcastItemWidget(
                            podcast: podcast,
                            maxLines: 2,
                            imageSize: Size(size.width / 4, size.width / 4),
                            onTap: () {
                              Navigator.pushNamed(context, PlayPodcastScreen.id,
                                  arguments: podcast);
                            });
                      }),
                ),
                const SizedBox(height: 20),
                const Text('Following Podcasts', style: AppStyles.headerTitle),
                const SizedBox(height: 10),
                GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return PodcastItemWidget(
                          podcast: podcast,
                          textAlign: TextAlign.center,
                          imageSize:
                              Size(size.width / 2 - 30, size.width / 2 - 30),
                          onTap: () {});
                    })
              ],
            ),
          ),
        ));
  }
}
