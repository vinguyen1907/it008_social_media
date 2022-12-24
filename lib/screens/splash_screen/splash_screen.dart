import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:it008_social_media/screens/on_boarding/on_boarind_scroll.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => OnBoardingScroll()))));
  }
  @override
  Widget build(BuildContext context) {
    double height_variable = MediaQuery.of(context).size.height;
    double width_variable = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: height_variable*0.149,
                  left: width_variable*0.696,
                  child: Container(
                            width: height_variable*0.06,
                            height: height_variable*0.06,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff006175),
                            )
                  )
                ),
                Positioned(
                  top: height_variable*0.245,
                  left: width_variable*0.221,
                  child: Container(
                            width: height_variable*0.038,
                            height: height_variable*0.038,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff006175),
                            )
                  )
                ),
                Positioned(
                  top: height_variable*0.556,
                  left: width_variable*0.696,
                  child: Container(
                            width: height_variable*0.06,
                            height: height_variable*0.06,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff006175),
                            )
                  )
                ),
                Positioned(
                  top: height_variable*0.673,
                  left: width_variable*0.781,
                  child: Container(
                            width: height_variable*0.038,
                            height: height_variable*0.038,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff006175),
                            )
                  )
                ),
                Positioned(
                  top: height_variable*0.812,
                  left: width_variable*0.221,
                  child: Container(
                            width: height_variable*0.038,
                            height: height_variable*0.038,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff006175),
                            )
                  )
                ),
                Positioned(
                  top: height_variable*0.488,
                  left: width_variable*0.08,
                  child: Container(
                            width: height_variable*0.06,
                            height: height_variable*0.06,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff006175),
                            )
                  )
                ),
                Positioned(
                  top: height_variable*0.62,
                  left: width_variable*0.432,
                  child: Container(
                    child: SpinKitFadingCube(
                      color: Color(0xff006175),
                      size: 45
                    ),
                  )
                ),
                Center(
                  child: Text(
                    'SOMEDIA',
                    style: TextStyle(
                    fontFamily: 'Sniglet',
                    color: Colors.black,
                    fontSize: 48
                    ),
                  ),
                )
              ],
            ),
          )
        ]
      )
    );
  }
}