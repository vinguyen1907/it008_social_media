import 'package:flutter/material.dart';
import 'package:it008_social_media/add_new_podcast_screen/add_new_podcast_screen.dart';
import 'package:it008_social_media/models/post_model.dart';
import 'package:it008_social_media/screens/comment_screen/comment_screen.dart';
import 'package:it008_social_media/screens/main_screen/main_screen.dart';
import 'package:it008_social_media/screens/notification_screen/notification_screen.dart';
import 'package:it008_social_media/screens/search_screen/search_screen.dart';
import 'package:it008_social_media/screens/verify_story/verify_story.dart';

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
    }
  }
}

// Note: Tạo static const id = "tên_screen"  trong mỗi screen 

// Khi muốn chuyển screen thì dùng Navigator.of(context).pushNamed(ExampleScreen.id);