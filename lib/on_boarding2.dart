import 'package:flutter/material.dart';
import 'package:sm/sign_up.dart';
import 'on_boarding3.dart';
import 'sign_in.dart';

class OnBoarding2 extends StatefulWidget {
  const OnBoarding2({super.key});

  @override
  State<OnBoarding2> createState() => _OnBoarding2State();
}

class _OnBoarding2State extends State<OnBoarding2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/ONBOARDING02.png'),
                fit: BoxFit.cover
              )
            ),
          ),
          Positioned(
            top: 585,
            left: 27,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => OnBoarding3())));
              },
              child: Container(
                height: 49,
                width: 321,
                decoration: BoxDecoration(
                  color: Color(0xff006175),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text(
                    'Next',
                    style: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Poppins', fontSize: 18, color: Colors.white),
                  )
                ),
              ),
            )
          ),
          Positioned(
            top: 653,
            left: 27,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignUp())));
              },
              child: Container(
                height: 49,
                width: 321,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black, width: 1)
                ),
                child: Center(
                  child: Text(
                    'Skip',
                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black,fontFamily: 'Poppins', fontSize: 18),
                  )
                ),
              ),
            )
          ),
           Positioned(
            top: 728,
            left: 69,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14)
                ),
                SizedBox(width: 2,),
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