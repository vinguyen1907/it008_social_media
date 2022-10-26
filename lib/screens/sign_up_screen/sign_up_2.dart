import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:it008_social_media/screens/sign_in_screen/sign_in.dart';
import 'sign_up.dart';
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
    double height_variable = MediaQuery.of(context).size.height;
    double width_variable = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: height_variable*0.09,
            left: width_variable*0.025,
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignUp())));
              }, 
              icon: const Icon(FontAwesomeIcons.angleLeft)
            )
          ),
          Positioned(
            top: height_variable*0.167,
            left: width_variable*0.072,
            child: Text(
              'Personal Information',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: height_variable*0.025),
            ),
          ),
          Positioned(
            top: height_variable*0.211,
            left: width_variable*0.072,
            child: Text(
              'Please fill the following',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: height_variable*0.02),
            ),
          ),
          Positioned(
            top: height_variable*0.266,
            left: width_variable*0.072,
            child: Text(
              'Full name',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: height_variable*0.017),
            )
          ),
          Positioned(
            top: height_variable*0.298,
            left: width_variable*0.072,
            child: Container(
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
              'Email Adress',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: height_variable*0.017),
            )
          ),
          Positioned(
            top: height_variable*0.405,
            left: width_variable*0.072,
            child: Container(
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
              'Date of birth',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: height_variable*0.017),
            )
          ),
          Positioned(
            top: height_variable*0.512,
            left: width_variable*0.072,
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
                width: width_variable*0.349,
                height: height_variable*0.06,
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
            top: height_variable*0.48,
            left: width_variable*0.579,
            child: Text(
              'Gender',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14),
            )
          ),
          Positioned(
            top: height_variable*0.512,
            left: width_variable*0.579,
            child: Container(
              alignment: Alignment.center,
              width: width_variable*0.349,
                height: height_variable*0.06,
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
            top: height_variable*0.587,
            left: width_variable*0.072,
            child: Text(
              'About',
              style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
          Positioned(
            top: height_variable*0.619,
            left: width_variable*0.072,
            child: Container(
              width: width_variable*0.856,
              height: height_variable*0.14,
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
            top: height_variable*0.79,
            left: width_variable*0.072,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignUp3())));
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
                    'Next',
                    style: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Poppins', fontSize: height_variable*0.022, color: Colors.white),
                  )
                ),
              ),
            )
          ),
          Positioned(
            top: height_variable*0.897,
            left: 0.184*width_variable,
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