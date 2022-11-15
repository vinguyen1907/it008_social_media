import 'package:flutter/material.dart';
import 'on_boarding2.dart';
import 'package:it008_social_media/screens/sign_in_screen/sign_in.dart';

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
            top: height_variable*0.151,
            left: (width_variable - height_variable*0.209)/2,
            child: Container(
              child: Image(
                image: AssetImage('assets/images/73.png'),
                height: height_variable*0.17,
                width: height_variable*0.17,
                color: null
              ),
              width: height_variable*0.209,
              height: height_variable*0.209,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffDBE9EC),
              )
            ),
          ),
          Positioned(
            top: height_variable*0.131,
            left: width_variable*0.09,
            child: Container(
              child: Image(
                image: AssetImage('assets/images/108.png'),
                height: height_variable*0.023,
                width: height_variable*0.023,
                color: null
              ),
              width: height_variable*0.038,
              height: height_variable*0.038,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff006175).withOpacity(0.5),
              )
            ),
          ),
          Positioned(
            top: height_variable*0.313,
            left: width_variable*0.09,
            child: Container(
              child: Image(
                image: AssetImage('assets/images/90.png'),
                height: height_variable*0.047,
                width: height_variable*0.047,
                color: null
              ),
              width: height_variable*0.06,
              height: height_variable*0.06,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff006175),
              )
            ),
          ),
          Positioned(
            top: height_variable*0.432,
            left: width_variable*0.267,
            child: Container(
              child: Image(
                image: AssetImage('assets/images/85.png'),
                height: height_variable*0.024,
                width: height_variable*0.024,
                color: null
              ),
              width: height_variable*0.038,
              height: height_variable*0.038,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff006175).withOpacity(0.33),
              )
            ),
          ),
          Positioned(
            top: height_variable*0.113,
            left: width_variable*0.704,
            child: Container(
              child: Image(
                image: AssetImage('assets/images/65.png'),
                height: height_variable*0.052,
                width: height_variable*0.052,
                color: null
              ),
              width: height_variable*0.06,
              height: height_variable*0.06,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff006175).withOpacity(0.6),
              )
            ),
          ),
          Positioned(
            top: height_variable*0.293,
            left: width_variable*0.826,
            child: Container(
              child: Image(
                image: AssetImage('assets/images/38.png'),
                height: height_variable*0.025,
                width: height_variable*0.025,
                color: null
              ),
              width: height_variable*0.038,
              height: height_variable*0.038,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff006175).withOpacity(0.3),
              )
            ),
          ),
          Positioned(
            top: height_variable*0.392,
            left: width_variable*0.696,
            child: Container(
              child: Image(
                image: AssetImage('assets/images/89.png'),
                height: height_variable*0.047,
                width: height_variable*0.047,
                color: null
              ),
              width: height_variable*0.06,
              height: height_variable*0.06,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff006175).withOpacity(0.14),
              )
            ),
          ),
          Positioned(
            top: height_variable*0.51,
            left: width_variable*0.072,
            child: Text(
              'Connect with Friends\nand Family',
              style: TextStyle(fontFamily: 'Poppins-Regular', fontWeight: FontWeight.w600, fontSize: height_variable*0.03),
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