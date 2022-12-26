import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:it008_social_media/change_notifies/image_detector_provider.dart';

import 'package:it008_social_media/screens/main_screen/main_screen.dart';
import 'package:it008_social_media/screens/on_boarding/on_boarind_scroll.dart';
import 'package:it008_social_media/services/router.dart';
import 'package:it008_social_media/utils/firebase_consts.dart';
import 'package:provider/provider.dart';
import 'change_notifies/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SystemChrome.setEnabledSystemUIMode(
  //     SystemUiMode.leanBack); // hide status bar on Android devices

  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ImageDetectionProvider(),
          ),
        ],
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: user != null ? const MainScreen() : const OnBoardingScroll(),
            onGenerateRoute: appRouter.onGenerateRoute,
          );
        });
  }
}
