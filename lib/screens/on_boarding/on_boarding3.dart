import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:it008_social_media/screens/sign_up_screen/sign_up.dart';
import 'package:it008_social_media/screens/sign_in_screen/sign_in.dart';

class OnBoarding3 extends StatefulWidget {
  const OnBoarding3({super.key});

  @override
  State<OnBoarding3> createState() => _OnBoarding3State();
}

class _OnBoarding3State extends State<OnBoarding3> {
  @override
  Widget build(BuildContext context) {
    double height_variable = MediaQuery.of(context).size.height;
    double width_variable = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: height_variable*0.13,
            left: width_variable*0.2,
            child: Lottie.asset('assets/gifs/goldcup.zip', width: width_variable*0.6, height: width_variable*0.6),
          ),
          Positioned(
            top: height_variable*0.51,
            left: width_variable*0.072,
            child: Text(
              'Express yourself to\nthe world',
              style: TextStyle(fontFamily: 'Poppins-Regular', fontWeight: FontWeight.w600, fontSize: height_variable*0.03),
            )
          ),
          Positioned(
            top: height_variable*0.592,
            left: width_variable*0.072,
            child: Text(
              'Let your voice be heard on the internet\nthrough Somedia features on the App\nwithout restrictions',
              style: TextStyle(fontFamily: 'Poppins-Regular', fontWeight: FontWeight.w500, fontSize: height_variable*0.025),
            )
          ),
          Positioned(
            top: height_variable*0.72,
            left: (width_variable - width_variable*0.856)/2,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignUp())));
              },
              child: Container(
                height: height_variable*0.06,
                width: width_variable*0.856,
                decoration: BoxDecoration(
                  color: Color(0xff006175),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Poppins', fontSize: 18, color: Colors.white),
                  )
                ),
              ),
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