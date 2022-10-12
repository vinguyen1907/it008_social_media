import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:it008_social_media/services/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.leanBack); // hide status bar on Android devices
  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Scaffold(
        body: Center(
          child: Text('Hello World'),
        ),
      ),
      onGenerateRoute: appRouter.onGenerateRoute,
    );
  }
}
