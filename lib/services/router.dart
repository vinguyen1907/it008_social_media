import 'package:flutter/material.dart';
import 'package:it008_social_media/screens/add_story_screen/add_story_screen.dart';
import 'package:it008_social_media/screens/comment_screen/comment_screen.dart';
import 'package:it008_social_media/screens/notification_screen/notification_screen.dart';
import 'package:it008_social_media/screens/show_story_screen.dart/show_story_screen.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case (ExampleScreen1.id):
      //   return MaterialPageRoute(builder: (_) => const ExampleScreen2());
      case (ShowStoryScreen.id):
        return MaterialPageRoute(builder: (_) => const ShowStoryScreen());
      case (NotificationScreen.id):
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case (AddStoryScreen.id):
        return MaterialPageRoute(builder: (_) => const AddStoryScreen());
      case (CommentScreen.id):
        return MaterialPageRoute(builder: (_) => const CommentScreen());
    }
  }
}

// Note: Tạo static const id = "tên_screen"  trong mỗi screen 

// Khi muốn chuyển screen thì dùng Navigator.of(context).pushNamed(ExampleScreen.id);