import 'package:flutter/material.dart';
import 'package:it008_social_media/screens/main_screen/main_screen.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    double height_variable = MediaQuery.of(context).size.height;
    double width_variable = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: height_variable*0.201,
            left: width_variable*0.256,
            child: Container(
              child: Image(
                image: AssetImage('assets/images/welcom.png'),
                height: height_variable*0.17,
                width: height_variable*0.17,
                color: null
              ),
              width: height_variable*0.225,
              height: height_variable*0.2254,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffDBE9EC),
              )
            ),
          ),
          Positioned(
            top: height_variable*0.565,
            left: width_variable*0.072,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => MainScreen())));
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
                    'Continue',
                    style: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Poppins', fontSize: height_variable*0.022, color: Colors.white),
                  )
                ),
              ),
            )
          ),
          Positioned(
            top: height_variable*0.27,
            left: width_variable*0.181,
            child: Icon(
              Icons.star,
              size: height_variable*0.026,
              color: Color(0xff006175),
            )
          ),
          Positioned(
            top: height_variable*0.202,
            left: width_variable*0.72,
            child: Icon(
              Icons.star,
              size: height_variable*0.026,
              color: Color(0xff006175),
            )
          ),
          Positioned(
            top: height_variable*0.414,
            left: width_variable*0.696,
            child: Icon(
              Icons.star,
              size: height_variable*0.026,
              color: Color(0xff006175),
            )
          ),
          Positioned(
            top: height_variable*0.155,
            left: width_variable*0.181,
            child: Container(
              width: height_variable*0.017,
              height: height_variable*0.017,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff006175),
              )
            )
          ),
          Positioned(
            top: height_variable*0.164,
            left: width_variable*0.368,
            child: Container(
              width: height_variable*0.017,
              height: height_variable*0.017,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff006175),
              )
            )
          ),
          Positioned(
            top: height_variable*0.37,
            left: width_variable*0.147,
            child: Container(
              width: height_variable*0.017,
              height: height_variable*0.017,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff006175),
              )
            )
          ),
          Positioned(
            top: height_variable*0.422,
            left: width_variable*0.28,
            child: Container(
              width: height_variable*0.017,
              height: height_variable*0.017,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff006175),
              )
            )
          ),
          Positioned(
            top: height_variable*0.296,
            left: width_variable*0.819,
            child: Container(
              width: height_variable*0.017,
              height: height_variable*0.017,
              decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff006175),
              )
            )
          ),
          Positioned(
            top: height_variable*0.463,
            left: width_variable*0.37,
            child: Text(
              'Welcome',
              style: TextStyle(fontFamily: 'Poppins-Regular', fontWeight: FontWeight.w600, fontSize: height_variable*0.03)
            )
          )
        ],
      ),
    );
  }
}