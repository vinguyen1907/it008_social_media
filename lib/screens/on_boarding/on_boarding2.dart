import 'package:flutter/material.dart';
import 'on_boarding3.dart';
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
            top: height_variable*0.151,
            left: (width_variable - height_variable*0.209)/2,
            child: Container(
              child: Image(
                image: AssetImage('assets/images/92.png'),
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
                image: AssetImage('assets/images/52.png'),
                height: height_variable*0.023,
                width: height_variable*0.023,
                color: null
              ),
              width: height_variable*0.038,
              height: height_variable*0.038,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff006175),
              )
            ),
          ),
          Positioned(
            top: height_variable*0.313,
            left: width_variable*0.09,
            child: Container(
              child: Image(
                image: AssetImage('assets/images/81.png'),
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
                image: AssetImage('assets/images/83.png'),
                height: height_variable*0.024,
                width: height_variable*0.024,
                color: null
              ),
              width: height_variable*0.038,
              height: height_variable*0.038,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff006175),
              )
            ),
          ),
          Positioned(
            top: height_variable*0.113,
            left: width_variable*0.704,
            child: Container(
              child: Image(
                image: AssetImage('assets/images/53.png'),
                height: height_variable*0.052,
                width: height_variable*0.052,
                color: null
              ),
              width: height_variable*0.06,
              height: height_variable*0.06,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffB3B9C9),
              )
            ),
          ),
          Positioned(
            top: height_variable*0.293,
            left: width_variable*0.826,
            child: Container(
              child: Image(
                image: AssetImage('assets/images/69.png'),
                height: height_variable*0.025,
                width: height_variable*0.025,
                color: null
              ),
              width: height_variable*0.038,
              height: height_variable*0.038,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff006175),
              )
            ),
          ),
          Positioned(
            top: height_variable*0.392,
            left: width_variable*0.696,
            child: Container(
              child: Image(
                image: AssetImage('assets/images/31.png'),
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