import 'package:flutter/material.dart';
import 'on_boarding3.dart';
import 'package:lottie/lottie.dart';
import 'package:it008_social_media/screens/sign_in_screen/sign_in.dart';

class OnBoarding2 extends StatefulWidget {
  const OnBoarding2({super.key});

  @override
  State<OnBoarding2> createState() => _OnBoarding2State();
}

class _OnBoarding2State extends State<OnBoarding2> {
  @override
  Widget build(BuildContext context) {
    double height_variable = MediaQuery.of(context).size.height;
    double width_variable = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
           Positioned(
            top: height_variable*0.04,
            left: width_variable*0.0001,
            child: Lottie.asset('assets/gifs/friend.zip', width: width_variable, height: width_variable),
          ),
          Positioned(
            top:height_variable*0.77,
            left: width_variable*0.23,
            child: Text('>> Slide for more >>', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 20, color: Color(0xff006175)) )
          ),
          Positioned(
            top: height_variable*0.51,
            left: width_variable*0.072,
            child: Text(
              'Make new Friends\nwith ease',
              style: TextStyle(fontFamily: 'Poppins-Regular', fontWeight: FontWeight.w600, fontSize: height_variable*0.03),
            )
          ),
          Positioned(
            top: height_variable*0.592,
            left: width_variable*0.072,
            child: Text(
              'Allowing you to make new Friends is\nour Number one priority.....',
              style: TextStyle(fontFamily: 'Poppins-Regular', fontWeight: FontWeight.w500, fontSize: height_variable*0.025),
            )
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