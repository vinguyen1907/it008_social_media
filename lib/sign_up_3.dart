import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sm/main_screen.dart';
import 'package:sm/sign_up_2.dart';
import 'sign_in.dart';
import 'welcome.dart';

class SignUp3 extends StatefulWidget {
  const SignUp3({super.key});

  @override
  State<SignUp3> createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 73,
            left: 10,
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignUp2())));
              }, 
              icon: const Icon(FontAwesomeIcons.angleLeft)
            )
          ),
          Positioned(
            top: 136,
            left: 27,
            child: Text(
              'Select a user name',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          Positioned(
            top: 171,
            left: 27,
            child: Text(
              'Help secure your account',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          Positioned(
            top: 216,
            left: 27,
            child: Text(
              'Username',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14),
            )
          ),
          Positioned(
            top: 242,
            left: 27,
            child: Container(
              width: 321,
              height: 49,
              decoration: BoxDecoration(
                color: Color(0xfff2f2f2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xff006175))
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none
                ),
              ),
            )
          ),
          Positioned(
            top: 303,
            left: 27,
            child: Text(
              'Password',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14),
            )
          ),
          Positioned(
            top: 329,
            left: 27,
            child: Container(
              width: 321,
              height: 49,
              decoration: BoxDecoration(
                color: Color(0xfff2f2f2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xff006175))
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none
                ),
              ),
            )
          ),
          Positioned(
            top: 390,
            left: 27,
            child: Text(
              'Confirm Password',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14),
            )
          ),
          Positioned(
            top: 416,
            left: 27,
            child: Container(
              width: 321,
              height: 49,
              decoration: BoxDecoration(
                color: Color(0xfff2f2f2),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xff006175))
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none
                ),
              ),
            )
          ),
          Positioned(
            top: 642,
            left: 27,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => Welcome())));
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
                    'Done',
                    style: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Poppins', fontSize: 18, color: Colors.white),
                  )
                ),
              ),
            )
          ),
          Positioned(
            top: 728,
            left: 69,
            child: Row(
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black)
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignIn())));
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff006175))
                  ),
                )
              ],
            )
          )
        ]
      )
    );
  }
}