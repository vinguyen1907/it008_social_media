import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:it008_social_media/screens/home_screen/home_screen.dart';
import 'package:it008_social_media/screens/sign_up_screen/sign_up.dart';
import 'package:it008_social_media/screens/forgot_password_screen/forgot_password.dart';
import 'package:it008_social_media/screens/main_screen/main_screen.dart';
import 'package:it008_social_media/services/auth_service.dart';
import 'package:it008_social_media/services/user_service.dart';
import 'package:it008_social_media/widgets/loading_widget.dart';
import '../../services/utils.dart';
import '../../utils/firebase_consts.dart';
import '../../utils/global_methods.dart';
import 'package:provider/provider.dart';
import 'package:it008_social_media/services/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/user_model.dart' as model;
import 'package:it008_social_media/screens/sign_up_screen/sign_up_2.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  OutlineInputBorder _buildborder(Color color) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: color, width: 1));
  }

  bool onTapLogin = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    double height_variable = MediaQuery.of(context).size.height;
    double width_variable = MediaQuery.of(context).size.width;
    return Form(
        key: _formKey,
        child: LoadingManager(
            isLoading: onTapLogin,
            child: Scaffold(
                body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height_variable * 0.167,
                    ),
                    Text(
                      'Sign in',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: height_variable * 0.006,
                    ),
                    Text(
                      'Enter your credentials',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: height_variable * 0.026,
                    ),
                    Text(
                      'Email',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: height_variable * 0.006,
                    ),
                    TextFormField(
                      validator: (String? inputVal) {
                        if (!emailRegex.hasMatch(inputVal.toString())) {
                          return 'Email format is not matching';
                        }
                        return null;
                      },
                      controller: _email,
                      decoration: InputDecoration(
                        enabledBorder: _buildborder(Color(0xff006175)),
                        errorBorder: _buildborder(Colors.red),
                        focusedErrorBorder: _buildborder(Colors.red),
                        focusedBorder: _buildborder(Colors.blue),
                        disabledBorder: _buildborder(Color(0xff006175)),
                      ),
                    ),
                    SizedBox(
                      height: height_variable * 0.0148,
                    ),
                    Text('Password',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black)),
                    SizedBox(
                      height: height_variable * 0.006,
                    ),
                    TextFormField(
                      validator: (String? inputVal) {
                        if (inputVal!.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      controller: _password,
                      decoration: InputDecoration(
                          enabledBorder: _buildborder(Color(0xff006175)),
                          errorBorder: _buildborder(Colors.red),
                          focusedErrorBorder: _buildborder(Colors.red),
                          focusedBorder: _buildborder(Colors.blue),
                          disabledBorder: _buildborder(Color(0xff006175)),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          )),
                      obscureText: _obscureText,
                    ),
                    SizedBox(
                      height: height_variable * 0.015,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ForgotPassword())));
                        },
                        child: Text(
                          'Forgot password?',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xff006175)),
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: height_variable * 0.026,
                    ),
                    GestureDetector(
                        onTap: () {
                          _submitFormOnLogin();
                        },
                        child: Container(
                          width: width_variable * 0.856,
                          height: height_variable * 0.06,
                          decoration: BoxDecoration(
                              color: Color(0xff006175),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            'Done',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                color: Colors.white),
                          )),
                        )),
                    SizedBox(
                      height: height_variable * 0.048,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width_variable * 0.3,
                          height: 1,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                        ),
                        SizedBox(width: 27),
                        Text('or',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.black)),
                        SizedBox(
                          width: 27,
                        ),
                        Container(
                          width: width_variable * 0.3,
                          height: 1,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height_variable * 0.048,
                    ),
                    GestureDetector(
                        onTap: () {
                          loginGoole();
                        },
                        child: Container(
                            width: width_variable * 0.856,
                            height: height_variable * 0.06,
                            decoration: BoxDecoration(
                                color: Color(0xfffaf6f4),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    image:
                                        AssetImage('assets/images/google.png'),
                                    height: height_variable * 0.031,
                                    width: height_variable * 0.031,
                                    color: null),
                                SizedBox(width: 15),
                                Text(
                                  'Sign in with Google',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: Color(0xff006175)),
                                ),
                              ],
                            ))),
                    SizedBox(
                      height: height_variable * 0.134,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Do not have an account?',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black)),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => SignUp())));
                            },
                            child: Text('Sign up',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Color(0xff006175))),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ))));
  }

  void _submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        onTapLogin = true;
      });
      try {
        await authInstance.signInWithEmailAndPassword(
            email: _email.text.toLowerCase().trim(),
            password: _password.text.trim());

        if (!mounted) return;

        // showDialog(
        //     context: context,
        //     builder: (context) => AlertDialog(
        //           content: Text("Login Successful"),
        //         ));

        AuthService().getUserData(context);

        Navigator.of(context).pushNamed(MainScreen.id).then((value) {
          setState(() {});
        });
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
            subtitle: '${error.message}', context: context);
        setState(() {
          onTapLogin = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: '$error', context: context);
        setState(() {
          onTapLogin = false;
        });
      } finally {
        setState(() {
          onTapLogin = false;
        });
      }
    }
  }

  void loginGoole() async {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    await provider.googleLogin(context);
    final User? user = authInstance.currentUser;
    String? email = user?.email;
    final _uid = user!.uid;
    if (await checkIfEmailInUse(email)) {
      Navigator.of(context).pushNamed(MainScreen.id);
    } else {
      model.Users _user = model.Users(
        id: _uid,
        userName: '',
        email: user.email,
        gender: '',
        dateOfBirth: '',
        about: '',
        avatarImageUrl: '',
        fullName: '',
        following: [],
        followers: [],
        address: "",
        phone: "",
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_uid)
          .set(_user.toJson() as Map<String, dynamic>);
      Navigator.push(
          context, MaterialPageRoute(builder: ((context) => const SignUp2())));
    }
  }

  Future<bool> checkIfEmailInUse(String? emailAddress) async {
    try {
      String email = emailAddress!;
      // Fetch sign-in methods for the email address
      final list =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);

      // In case list is not empty
      if (list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        return true;
      } else {
        // Return false because email adress is not in use
        return false;
      }
    } catch (error) {
      // Handle error
      // ...
      return true;
    }
  }
}
