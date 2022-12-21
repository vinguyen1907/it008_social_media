import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/user_model.dart' as model;
import '../../services/utils.dart';
import '../../utils/firebase_consts.dart';
import '../../utils/firebase_consts.dart';
import '../../utils/global_methods.dart';
import '../../widgets/loading_widget.dart';
import 'sign_up_2.dart';
import 'package:it008_social_media/screens/sign_in_screen/sign_in.dart';
import 'package:validators/validators.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final TextEditingController _conformPwd = TextEditingController();

  OutlineInputBorder _buildborder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: color, width: 1) 
    );
  }

  bool _isLoading = false;
  bool _obscureText1 = true;
  bool _obscureText2 = true;
  @override
  Widget build(BuildContext context) {
    double height_variable = MediaQuery.of(context).size.height;
    double width_variable = MediaQuery.of(context).size.width;
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Form(
              key: _signUpKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height_variable*0.167),
                  Center(
                    child: Text(
                      'Create your account',
                      style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: height_variable*0.027),
                    ),
                  ),
                  SizedBox(height: height_variable*0.038, width: width_variable*0.072),
                  TextFormField(
                    validator: (String? inputVal) {
                      if (!emailRegex.hasMatch(inputVal.toString())) { 
                        return 'Email format not match';
                      } else {
                        return null;
                      }
                    },
                    controller: _email,
                    decoration: InputDecoration(
                      enabledBorder: _buildborder(Color(0xff006175)),
                      errorBorder: _buildborder(Colors.red),
                      focusedErrorBorder: _buildborder(Colors.red),
                      focusedBorder: _buildborder(Colors.blue),
                      disabledBorder: _buildborder(Color(0xff006175)),
                      labelText: 'Email',
                      labelStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12),
                      hintText: 'something@gmail.com',
                      hintStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12),
                      prefixIcon: Icon(Icons.email)                  
                    ),
                  ),
                  SizedBox(height: height_variable*0.016, width: width_variable*0.072),
                  TextFormField(
                    controller: _pwd,
                    validator: (String? inputVal) {
                      if (inputVal!.length < 6) {
                        return 'Password must be at least 6 characters';
                      } else {
                        return null;
                      }     
                    },
                    decoration: InputDecoration(
                      enabledBorder: _buildborder(Color(0xff006175)),
                      errorBorder: _buildborder(Colors.red),
                      focusedErrorBorder: _buildborder(Colors.red),
                      focusedBorder: _buildborder(Colors.blue),
                      disabledBorder: _buildborder(Color(0xff006175)),
                      labelText: 'Password',
                      labelStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12),
                      hintText: 'Password must have at least 6 characters',
                      hintStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText1 = !_obscureText1;
                          });
                        },
                        child: Icon(_obscureText1 ? Icons.visibility : Icons.visibility_off ),
                      )
                    ),
                    obscureText: _obscureText1,
                  ),
                  SizedBox(height: height_variable*0.016, width: width_variable*0.072),
                  TextFormField(
                        controller: _conformPwd,
                        validator: (String? inputVal) {
                          if (inputVal!.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          if (_pwd.text != _conformPwd.text) {
                            return 'Those passwords did not match';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: _buildborder(Color(0xff006175)),
                          errorBorder: _buildborder(Colors.red),
                          focusedErrorBorder: _buildborder(Colors.red),
                          focusedBorder: _buildborder(Colors.blue),
                          disabledBorder: _buildborder(Color(0xff006175)),
                          labelText: 'Confirm password',
                          labelStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12),
                          hintText: 'Those passwords have to be the same',
                          hintStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText2 = !_obscureText2;
                              });
                            },
                            child: Icon(_obscureText2 ? Icons.visibility : Icons.visibility_off ),
                          )
                        ),
                        obscureText: _obscureText2,
                  ),
                  SizedBox(height: height_variable*0.038, width: width_variable*0.072),
                  GestureDetector(
                    onTap: () {
                      _submitFormOnRegister();
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
                          width: width_variable*0.3,
                          height: 1,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)
                          ),
                        ),
                        SizedBox(width: 27),
                        Text('or', style: TextStyle(fontWeight: FontWeight.w400,fontFamily: 'Poppins', fontSize: 12, color: Colors.black)),
                        SizedBox(width: 27,),
                        Container(
                          width: width_variable*0.3,
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
                          image: AssetImage('assets/images/goo.png'),
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
                  SizedBox(height: height_variable*0.15),
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
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => SignIn())));
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff006175)),
                          ),
                        )
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
  void _submitFormOnRegister() async {
    final isValid = _signUpKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {

      _signUpKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      try {
        await authInstance.createUserWithEmailAndPassword(
            email: _email.text.toLowerCase().trim(),
            password: _pwd.text.trim());
        final User? user = authInstance.currentUser;
        final _uid = user!.uid;

        model.User _user = model.User(
          id: _uid,
          userName: '',
          email: _email.text.toLowerCase().trim(),
          gender: '',
          dateOfBirth: '',
          about: '',
          avatarImageUrl: '',
          fullName: '',
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(_uid)
            .set(_user.toJson());
        Navigator.push(context, MaterialPageRoute(builder: ((context) => SignUp2())));
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '${error.message}', context: context);
        setState(() {
          _isLoading = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
    }
  }

