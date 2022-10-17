import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sm/sign_in.dart';
import 'sign_up.dart';
import 'welcome_back.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignIn())));
              }, 
              icon: const Icon(FontAwesomeIcons.angleLeft)
            )
          ),
          Positioned(
            top: 136,
            left: 27,
            child: Text(
              'Forgot Password',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black) ,
            )
          ),
          Positioned(
            top: 183,
            left: 27,
            child: Text(
              'Enter your email',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black) ,
            )
          ),
          Positioned(
            top: 209,
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => WelcomeBack())));
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
            left: 68,
            child: Row(
              children: [
                Text(
                  'Do not have an account?',
                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black)
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignUp())));
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff006175))
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}