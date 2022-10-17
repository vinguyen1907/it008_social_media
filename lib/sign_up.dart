import 'package:flutter/material.dart';
import 'package:sm/sign_up_2.dart';
import 'sign_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 136),
          Center(
            child: Text(
                  'Create your account',
                  style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 22)
            )
          ),
          SizedBox(height: 31, width: 27),
          Container(
              width: 321,
              height: 49,
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
          SizedBox(height: 13, width: 27),
          Container(
              width: 321,
              height: 49,
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
          SizedBox(height: 13, width: 27),
          Container(
              width: 321,
              height: 49,
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
          SizedBox(height: 31, width: 27,),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignUp2())));
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
          ),
          SizedBox(height: 48),
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
          SizedBox(height: 49),
          Container(
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
          SizedBox(height: 125,),
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