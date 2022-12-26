import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';
import 'package:it008_social_media/constants/app_styles.dart';
import 'package:it008_social_media/models/enum/podcast_background_colors.dart';
import 'package:it008_social_media/models/podcast_model.dart';

class PlayPodcastScreen extends StatefulWidget {
  const PlayPodcastScreen(
      {super.key, required this.podcast, required this.authorName});

  final String authorName;
  final Podcast podcast;
  static const String id = 'play_podcast_screen';

  @override
  State<PlayPodcastScreen> createState() => _PlayPodcastScreenState();
}

class _PlayPodcastScreenState extends State<PlayPodcastScreen> {
  late AudioPlayer player;
  late Duration duration = const Duration(seconds: 0);
  Duration position = const Duration(seconds: 0);
  late PlayerState playerState = PlayerState.stopped;

  void playAudio() async {
    await player.play(UrlSource(widget.podcast.audioUrl));
  }

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    playAudio();

    player.onDurationChanged.listen((Duration d) {
      if (mounted) {
        setState(() => duration = d);
      }
    });

    player.onPositionChanged.listen((Duration p) {
      if (mounted) {
        setState(() => position = p);
      }
    });

    player.onPlayerStateChanged.listen((PlayerState s) {
      if (mounted) {
        setState(() => playerState = s);
      }
    });
  }

  @override
  void dispose() {
    player.release();
    player.dispose();
    super.dispose();
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                                            widget.podcast.backgroundType)
                                        .first
                                        .index]!,
                                height: size.width - 40,
                                width: size.width - 40)
                            .image)),
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(widget.podcast.imageUrl,
                      width: size.width * 0.45,
                      height: size.width * 0.45,
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                width: size.width - 40,
                child: Text(
                  widget.podcast.title,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.postUserName
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                widget.podcast.userName,
                style: AppStyles.podcastAuthorNameText,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              LinearProgressIndicator(
                value: duration.inSeconds != 0
                    ? position.inSeconds / duration.inSeconds
                    : 0,
              ),
              SizedBox(
                height: size.height * 0.005,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(getTimeInFormat(position)),
                  Text(getTimeInFormat(duration)),
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        backward15Seconds();
                      },
                      icon: SvgPicture.asset(AppAssets.icBackward15Second)),
                  IconButton(
                      onPressed: () {
                        stop();
                      },
                      icon: SvgPicture.asset(playerState == PlayerState.playing
                          ? AppAssets.icPause
                          : AppAssets.icPlay)),
                  IconButton(
                      onPressed: () {
                        forward15Seconds();
                      },
                      icon: SvgPicture.asset(AppAssets.icForward15Second)),
                ],
              )
            ],
          ),
        ));
  }

  void stop() async {
    if (playerState == PlayerState.playing) {
      await player.pause();
    } else {
      await player.resume();
    }
  }

  void forward15Seconds() async {
    if (position > duration - const Duration(seconds: 15)) {
      await player.seek(duration);
    } else {
      await player.seek(position + const Duration(seconds: 15));
    }
  }

  void backward15Seconds() async {
    if (position < const Duration(seconds: 15)) {
      await player.seek(const Duration(seconds: 0));
    } else {
      await player.seek(position - const Duration(seconds: 15));
    }
  }

  String getTimeInFormat(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
