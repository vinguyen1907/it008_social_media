import 'package:flutter/material.dart';
import 'package:it008_social_media/screens/sign_up_screen/sign_up.dart';
import 'package:it008_social_media/screens/forgot_password_screen/forgot_password.dart';
import 'package:it008_social_media/screens/main_screen/main_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _obscureT = true;
  @override
  Widget build(BuildContext context) {
    double height_variable = MediaQuery.of(context).size.height;
    double width_variable = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
         children:
          [
            Positioned(
              top: height_variable*0.167,
              left: width_variable*0.072,
              child: Text(
                'Sign in',
                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
              ),
            ),
            Positioned(
              top: height_variable*0.211,
              left: width_variable*0.072,
              child: Text(
                'Enter your credentials',
                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
              ),
            ),
            Positioned(
              top: height_variable*0.266,
              left: width_variable*0.072,
              child: Text(
                'Username',
                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
              )
            ),
            Positioned(
              top: height_variable*0.298,
              left: width_variable*0.072,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                width: width_variable*0.856,
                height: height_variable*0.06,
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
              top: height_variable*0.373,
              left: width_variable*0.072,
              child: Text(
                'Password',
                style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
              )
            ),
            Positioned(
              top: height_variable*0.405,
              left: width_variable*0.072,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                width: width_variable*0.856,
                height: height_variable*0.06,
                decoration: BoxDecoration(
                  color: Color(0xfff2f2f2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xff006175))
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureT = !_obscureT;
                        });
                      },
                      child: Icon(_obscureT ?Icons.visibility :Icons.visibility_off),
                    )
                  ),
                  obscureText: _obscureT,
                ),
              )
            ),
            Positioned(
              top: height_variable*0.48,
              left: width_variable*0.597,
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
              top: height_variable*0.532,
              left: width_variable*0.072,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => MainScreen())));
                },
                child: Container(
                  width: width_variable*0.856,
                  height: height_variable*0.06,
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
              top: height_variable*0.651,
              left: width_variable*0.072,
              child: Row(
                children: [
                  Container(
                    width: width_variable*0.339,
                    height: 1,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                    ),
                  ),
                  SizedBox(width: 27),
                  Text('or', style: TextStyle(fontWeight: FontWeight.w400,fontFamily: 'Poppins', fontSize: 12, color: Colors.black)),
                  SizedBox(width: 27,),
                  Container(
                    width: width_variable*0.339,
                    height: 1,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: height_variable*0.702,
              left: width_variable*0.072,
              child: GestureDetector(
                onTap: () {
                  //Do nothing
                },
                child: Container(
                  width: width_variable*0.856,
                  height: height_variable*0.06,
                  decoration: BoxDecoration(
                    color: Color(0xfffaf6f4),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('assets/images/google.png'),
                        height: height_variable*0.031,
                        width: height_variable*0.031,
                        color: null
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
              top: height_variable*0.897,
              left: width_variable*0.1813,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                ),
              )
            )
          ]
        )
    );
  }
}