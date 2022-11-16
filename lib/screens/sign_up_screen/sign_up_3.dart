import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:it008_social_media/screens/main_screen/main_screen.dart';
import 'sign_up_2.dart';
import 'package:it008_social_media/screens/sign_in_screen/sign_in.dart';
import 'package:it008_social_media/screens/welcome_screen/welcome.dart';

class SignUp3 extends StatefulWidget {
  const SignUp3({super.key});

  @override
  State<SignUp3> createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  @override
  Widget build(BuildContext context) {
    double height_variable = MediaQuery.of(context).size.height;
    double width_variable = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: height_variable*0.09,
            left: width_variable*0.027,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              icon: const Icon(FontAwesomeIcons.angleLeft)
            )
          ),
          Positioned(
            top: height_variable*0.167,
            left: width_variable*0.072,
            child: Text(
              'Select a user name',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: height_variable*0.025),
            ),
          ),
          Positioned(
            top: height_variable*0.211,
            left: width_variable*0.072,
            child: Text(
              'Help secure your account',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: height_variable*0.02),
            ),
          ),
          Positioned(
            top: height_variable*0.266,
            left: width_variable*0.072,
            child: Text(
              'Username',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: height_variable*0.017),
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
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: height_variable*0.017),
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
                  border: InputBorder.none
                ),
              ),
            )
          ),
          Positioned(
            top: height_variable*0.48,
            left: width_variable*0.072,
            child: Text(
              'Confirm Password',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: height_variable*0.017),
            )
          ),
          Positioned(
            top: height_variable*0.512,
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
            top: height_variable*0.791,
            left: width_variable*0.072,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) => Welcome())));
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
                    'Done',
                    style: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Poppins', fontSize: height_variable*0.022, color: Colors.white),
                  )
                ),
              ),
            )
          ),
          Positioned(
            top: height_variable*0.897,
            left: width_variable*0.184,
            child: Row(
              children: [
                Text(
                  'Already have an account?',
                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: height_variable*0.017, color: Colors.black)
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: ((context) => SignIn())));
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: height_variable*0.017, color: Color(0xff006175))
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