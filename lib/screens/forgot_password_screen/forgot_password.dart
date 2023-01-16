import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:it008_social_media/screens/sign_in_screen/sign_in.dart';
import 'package:it008_social_media/screens/sign_up_screen/sign_up.dart';
import 'package:it008_social_media/screens/welcome_screen/welcome_back.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _email = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future pwreset() async {
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email.text.trim());
      showDialog(context: context, builder: (context) {
        return AlertDialog(content: Text('Please check your email.'));
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(context: context, builder: (context) {
        return AlertDialog(content: Text(e.message.toString()));
      });
    }

  }
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
                controller: _email,
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
                pwreset();
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