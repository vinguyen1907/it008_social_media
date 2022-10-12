import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case (ExampleScreen1.id):
      //   return MaterialPageRoute(builder: (_) => const ExampleScreen2());
    }
  }
}

// Note: Tạo static const id = "tên_screen"  trong mỗi screen 

// Khi muốn chuyển screen thì dùng Navigator.of(context).pushNamed(ExampleScreen.id);