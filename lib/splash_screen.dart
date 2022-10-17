import 'package:flutter/material.dart';
import 'on_boarding1.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => OnBoarding1()))));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 121,
                  left: 261,
                  child: Container(
                            width: 49,
                            height: 49,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff006175),
                            )
                  )
                ),
                Positioned(
                  top: 199,
                  left: 83,
                  child: Container(
                            width: 31,
                            height: 31,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff006175),
                            )
                  )
                ),
                Positioned(
                  top: 452,
                  left: 261,
                  child: Container(
                            width: 49,
                            height: 49,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff006175),
                            )
                  )
                ),
                Positioned(
                  top: 547,
                  left: 293,
                  child: Container(
                            width: 31,
                            height: 31,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff006175),
                            )
                  )
                ),
                Positioned(
                  top: 660,
                  left: 83,
                  child: Container(
                            width: 31,
                            height: 31,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff006175),
                            )
                  )
                ),
                Positioned(
                  top: 397,
                  left: 30,
                  child: Container(
                            width: 49,
                            height: 49,
                            decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xff006175),
                            )
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