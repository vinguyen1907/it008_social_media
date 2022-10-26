import 'package:flutter/material.dart';
import 'sign_up_2.dart';
import 'package:it008_social_media/screens/sign_in_screen/sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    double height_variable = MediaQuery.of(context).size.height;
    double width_variable = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height_variable*0.167),
          Center(
            child: Text(
                  'Create your account',
                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: height_variable*0.027)
            )
          ),
          SizedBox(height: height_variable*0.038, width: width_variable*0.072),
          Container(
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
                  hintText: "Email",
                  hintStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12),
                  prefixIcon: Icon(Icons.email)
                ),
              ),
          ),
          SizedBox(height: height_variable*0.016, width: width_variable*0.072),
          Container(
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
                  hintText: "Password",
                  hintStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12),
                  prefixIcon: Icon(Icons.lock)
                ),
              ),
          ),
          SizedBox(height: height_variable*0.016, width: width_variable*0.072),
          Container(
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
                  hintText: "Confirm your password",
                  hintStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12),
                  prefixIcon: Icon(Icons.lock)
                ),
              ),
          ),
          SizedBox(height: height_variable*0.038, width: width_variable*0.072),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignUp2())));
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
                      'Next',
                      style: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Poppins', fontSize: 18, color: Colors.white),
                    )
                  ),
            ),
          ),
          SizedBox(height: height_variable*0.059),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
          SizedBox(height: height_variable*0.06),
          Container(
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
          SizedBox(height: height_variable*0.154),
          Row(
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
        ],
      )
    );
  }
}