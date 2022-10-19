import 'package:flutter/material.dart';
import 'package:sm/sign_up.dart';
import 'forgot_password.dart';
import 'main_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
       children:
        [
          Positioned(
            top: 136,
            left: 27,
            child: Text(
              'Sign in',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
            ),
          ),
          Positioned(
            top: 171,
            left: 27,
            child: Text(
              'Enter your credentials',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
            ),
          ),
          Positioned(
            top: 216,
            left: 27,
            child: Text(
              'Username',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
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
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
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
            left: 224,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => ForgotPassword())));
              },
              child: Text(
                'Forgot password?',
                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff006175)),
              ),
            )
          ),
          Positioned(
            top: 432,
            left: 27,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => MainScreen())));
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
            top: 529,
            left: 27,
            child: Row(
              children: [
                Container(
                  width: 127,
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                  ),
                ),
                SizedBox(width: 27),
                Text('or', style: TextStyle(fontWeight: FontWeight.w400,fontFamily: 'Poppins', fontSize: 12, color: Colors.black)),
                SizedBox(width: 27,),
                Container(
                  width: 127,
                  height: 1,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 570,
            left: 27,
            child: GestureDetector(
              onTap: () {
                //Do nothing
              },
              child: Container(
                height: 49,
                width: 321,
                decoration: BoxDecoration(
                  color: Color(0xfffaf6f4),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                      AssetImage('assets/images/google.png'),
                      size: 20,
                    ),
                    SizedBox(width: 15),
                    Text(
                      'Sign in with Google',
                      style: TextStyle(fontWeight: FontWeight.w500,fontFamily: 'Poppins', fontSize: 14, color: Color(0xff006175)),
                    ),
                  ],
                )
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
        ]
      ),
    );
  }
}