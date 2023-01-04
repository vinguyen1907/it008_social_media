// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:it008_social_media/models/podcast_model.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/screens/add_new_podcast_screen/add_new_podcast_screen.dart';
import 'package:it008_social_media/screens/comment_screen/comment_screen.dart';
import 'package:it008_social_media/screens/main_screen/main_screen.dart';
import 'package:it008_social_media/screens/notification_screen/notification_screen.dart';
import 'package:it008_social_media/screens/play_podcast_screen/play_podcast_screen.dart';
import 'package:it008_social_media/screens/search_screen/search_screen.dart';
import 'package:it008_social_media/screens/show_all_podcast/show_all_podcast.dart';
import 'package:it008_social_media/screens/verify_story/verify_story.dart';

class PlayPodcastArguments {
  final Podcast podcast;
  final String authorName;
  PlayPodcastArguments({
    required this.podcast,
    required this.authorName,
  });
}

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case (ExampleScreen1.id):
      //   return MaterialPageRoute(builder: (_) => const ExampleScreen2());
      case (MainScreen.id):
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case (NotificationScreen.id):
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case (SearchScreen.id):
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case (CommentScreen.id):
        final args = routeSettings.arguments as Post;
        return MaterialPageRoute(builder: (_) => CommentScreen(post: args));
      case (VerifyStoryScreen.id):
        final args = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => VerifyStoryScreen(
                  imagePath: args,
                ));
      case (AddNewPodcastScreen.id):
        return MaterialPageRoute(builder: (_) => const AddNewPodcastScreen());
      case (PlayPodcastScreen.id):
        final args = routeSettings.arguments as PlayPodcastArguments;
        return MaterialPageRoute(
            builder: (_) => PlayPodcastScreen(
                  podcast: args.podcast,
                  authorName: args.authorName,
                ));
      case (ShowAllPodcastScreen.id):
        final args = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => ShowAllPodcastScreen(
                  authorId: args,
                ));
    }
  }
}

// Note: Tạo static const id = "tên_screen"  trong mỗi screen 

// Khi muốn chuyển screen thì dùng Navigator.of(context).pushNamed(ExampleScreen.id);