import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:it008_social_media/change_notifies/image_detector_provider.dart';

import 'package:it008_social_media/screens/main_screen/main_screen.dart';
import 'package:it008_social_media/screens/on_boarding/on_boarind_scroll.dart';
import 'package:it008_social_media/services/auth_service.dart';
import 'package:it008_social_media/services/google_sign_in.dart';
import 'package:it008_social_media/services/router.dart';
import 'package:provider/provider.dart';
import 'change_notifies/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SystemChrome.setEnabledSystemUIMode(
  //     SystemUiMode.leanBack); // hide status bar on Android devices

  // runApp(MyApp(appRouter: AppRouter()));

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ImageDetectionProvider(),
        ),
        ChangeNotifierProvider(create: ((context) => GoogleSignInProvider()))
      ], child: MyApp(appRouter: AppRouter())));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: widget.appRouter.onGenerateRoute,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: Provider.of<UserProvider>(context).getUser != null
          ? const MainScreen()
          : const OnBoardingScroll(),
    );
  }
}
