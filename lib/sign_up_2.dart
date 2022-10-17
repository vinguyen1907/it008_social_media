import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sm/sign_in.dart';
import 'package:sm/sign_up.dart';
import 'sign_up_3.dart';

class SignUp2 extends StatefulWidget {
  const SignUp2({super.key});

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  DateTime date = DateTime(2022, 10, 16);
  final List<String> Gender = ['Male', 'Female'];
  String _dropDownValue = 'Male';

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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignUp())));
              }, 
              icon: const Icon(FontAwesomeIcons.angleLeft)
            )
          ),
          Positioned(
            top: 136,
            left: 27,
            child: Text(
              'Personal Information',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ),
          Positioned(
            top: 171,
            left: 27,
            child: Text(
              'Please fill the following',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          Positioned(
            top: 216,
            left: 27,
            child: Text(
              'Full name',
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
              'Email Adress',
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
              'Date of birth',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14),
            )
          ),
          Positioned(
            top: 416,
            left: 27,
            child: GestureDetector(
              onTap: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );

                if (newDate == null) return;
                setState(() {
                  date = newDate;
                });
              },
              child: Container(
                width: 131,
                height: 49,
                decoration: BoxDecoration(
                  color: Color(0xfff2f2f2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xff006175))
                ),
                child: Center(child: Text('${date.year}/${date.month}/${date.day}', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14),)),
              ),
            )
          ),
          Positioned(
            top: 390,
            left: 217,
            child: Text(
              'Gender',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14),
            )
          ),
          Positioned(
            top: 416,
            left: 217,
            child: Container(
              alignment: Alignment.center,
              width: 131,
                height: 49,
                decoration: BoxDecoration(
                  color: Color(0xfff2f2f2),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0xff006175))
                ),
              child: DropdownButton<String>(
                value: _dropDownValue,
                items: Gender.map((String Gender){
                  return DropdownMenuItem(
                    value: Gender,
                    child: Text(Gender)
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _dropDownValue = newValue!;
                  });
                },
              ),
            )
          ),
          Positioned(
            top: 477,
            left: 27,
            child: Text(
              'About',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
          Positioned(
            top: 503,
            left: 27,
            child: Container(
              width: 321,
              height: 114,
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignUp3())));
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
        ],
      )
    );
  }
}