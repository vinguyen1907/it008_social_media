import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_dimensions.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/enum/podcast_background_colors.dart';
import 'package:it008_social_media/models/podcast_model.dart';

class PlayPodcastScreen extends StatelessWidget {
  const PlayPodcastScreen({super.key, required this.podcast});

  final Podcast podcast;
  static const String id = 'play_podcast_screen';

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
        body: Padding(
          padding:
              const EdgeInsets.only(left: Dimensions.defaultHorizontalMargin),
          child: Column(
            children: [
              Container(
                height: size.width - 40,
                width: size.width - 40,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.asset(
                                podcastBackgroundImage[
                                    PodcastBackgroundColorsValue.values
                                        .where((element) =>
                                            element.toString() ==
                                            podcast.backgroundType)
                                        .first
                                        .index]!,
                                height: size.width - 40,
                                width: size.width - 40)
                            .image)),
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(podcast.imageUrl,
                      width: size.width * 0.45,
                      height: size.width * 0.45,
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: size.width - 40,
                child: Text(
                  podcast.title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.postUserName
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                podcast.userName,
                style: AppStyles.podcastAuthorNameText,
              ),
            ],
          ),
        ));
  }
}
