import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:it008_social_media/constants/app_assets.dart';
import 'package:it008_social_media/constants/app_colors.dart';

enum PodcastBackgroundColorsValue { noBackground, green, red, pink, blue }

const List<Color> podcastBackgroundColors = [
  AppColors.mediumGreyColor,
  Color(0xff5FFF45),
  Color(0xffFF5050),
  Color(0xffFB43FF),
  Color(0xff5DF5FF),
];

List<dynamic> podcastBackgroundImage = [
  AppAssets.emptyImage,
  AppAssets.greenPodcastBackground,
  AppAssets.redPodcastBackground,
  AppAssets.pinkPodcastBackground,
  AppAssets.bluePodcastBackground
];
