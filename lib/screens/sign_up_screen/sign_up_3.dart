import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:it008_social_media/screens/main_screen/main_screen.dart';
import 'package:validators/validators.dart';
import 'sign_up_2.dart';
import 'package:it008_social_media/screens/sign_in_screen/sign_in.dart';
import 'package:it008_social_media/screens/welcome_screen/welcome.dart';

class SignUp3 extends StatefulWidget {
  const SignUp3({super.key});

  @override
  State<SignUp3> createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  bool isUserNameCorrect = false;
  bool isPasswordCorrect = false;
  String password = "!@#%^";
  bool _obsText = true;
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignUp2())));
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
                border: Border.all(color: isUserNameCorrect == false ?Colors.red :Colors.green)
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    isUserNameCorrect = isAscii(value);
                  });
                },
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
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obsText = !_obsText;
                      });
                    },
                    child: Icon(_obsText ?Icons.visibility :Icons.visibility_off),
                  )
                ),
                obscureText: _obsText,
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
                border: Border.all(color: isPasswordCorrect == false ?Colors.red :Colors.green)
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    if (value == password)
                  {
                    isPasswordCorrect = true;
                  }else{
                    isPasswordCorrect = false;
                  }
                  });   
                },
                decoration: InputDecoration(
                  border: InputBorder.none
                ),
                obscureText: true,
              ),
            )
          ),
          Positioned(
            top: height_variable*0.791,
            left: width_variable*0.072,
            child: GestureDetector(
              onTap: () {
                if (isUserNameCorrect && isPasswordCorrect)
                {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => Welcome())));
                }     
              },
              child: Container(
                height: height_variable*0.06,
                width: width_variable*0.856,
                decoration: BoxDecoration(
                  color: isUserNameCorrect == true && isPasswordCorrect == true ?Color(0xff006175) :Color(0xff006175).withOpacity(0.5),
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignIn())));
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