import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'on_boarding2.dart';
import 'package:it008_social_media/screens/sign_in_screen/sign_in.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class OnBoarding1 extends StatefulWidget {
  const OnBoarding1({super.key});

  @override
  State<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  @override
  
  Widget build(BuildContext context) {
    double height_variable = MediaQuery.of(context).size.height;
    double width_variable = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: height_variable*0.05,
            left: width_variable*0.0000000001,
            child: Lottie.asset('assets/gifs/family.zip', width: width_variable, height: width_variable),
          ),
          Positioned(
            top: height_variable*0.53,
            left: width_variable*0.072,
            child: Text(
              'Connect with',
              style: TextStyle(fontFamily: 'Poppins-Regular', fontWeight: FontWeight.w600, fontSize: height_variable*0.03),
            ),
          ),
          Positioned(
            top: height_variable*0.497,
            left: width_variable*0.45,
            child: AnimatedTextKit(
              animatedTexts:[
                RotateAnimatedText('Family', textStyle: TextStyle(fontFamily: 'Poppins-Regular', fontWeight: FontWeight.w600, fontSize: height_variable*0.03, color: Color(0xff006175)),),
                RotateAnimatedText('Friends', textStyle: TextStyle(fontFamily: 'Poppins-Regular', fontWeight: FontWeight.w600, fontSize: height_variable*0.03, color: Color(0xff006175)),)
              ],
            )
          ),
          Positioned(
            top: height_variable*0.592,
            left: width_variable*0.072,
            child: Text(
              'Connecting with Family and Friends\nprovides a sense of belonging and\nsecurity',
              style: TextStyle(fontFamily: 'Poppins-Regular', fontWeight: FontWeight.w500, fontSize: height_variable*0.025),
            )
          ),
          Positioned(
            top:height_variable*0.77,
            left: width_variable*0.23,
            child: Text('>> Slide for more >>', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 20, color: Color(0xff006175)) )
          ),
          Positioned(
            top: height_variable*0.897,
            left: (width_variable - width_variable*0.637)/2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14)
                ),
                SizedBox(width: 2),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignIn())));
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff006175)),
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