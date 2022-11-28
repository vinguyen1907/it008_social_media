import 'package:flutter/material.dart';
import 'package:it008_social_media/screens/add_story_screen/add_story_screen.dart';
import 'package:it008_social_media/screens/comment_screen/comment_screen.dart';
import 'package:it008_social_media/screens/main_screen/main_screen.dart';
import 'package:it008_social_media/screens/notification_screen/notification_screen.dart';
import 'package:it008_social_media/screens/show_story_screen.dart/show_story_screen.dart';
import 'package:it008_social_media/screens/verify_story/verify_story.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case (ExampleScreen1.id):
      //   return MaterialPageRoute(builder: (_) => const ExampleScreen2());
      case (MainScreen.id):
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case (ShowStoryScreen.id):
        return MaterialPageRoute(builder: (_) => const ShowStoryScreen());
      case (NotificationScreen.id):
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      // case (AddStoryScreen.id):
      //   final args = routeSettings.arguments as CameraDescription;
      //   return MaterialPageRoute(
      //       builder: (_) => AddStoryScreen(
      //             camera: args,
      //           ));
      case (CommentScreen.id):
        return MaterialPageRoute(builder: (_) => const CommentScreen());
      case (VerifyStoryScreen.id):
        final args = routeSettings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => VerifyStoryScreen(
                  imagePath: args,
                ));
    }
  }
}

// Note: Tạo static const id = "tên_screen"  trong mỗi screen 

// Khi muốn chuyển screen thì dùng Navigator.of(context).pushNamed(ExampleScreen.id);