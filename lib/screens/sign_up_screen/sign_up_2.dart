import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:it008_social_media/screens/home_screen/home_screen.dart';
import 'package:it008_social_media/screens/main_screen/main_screen.dart';
import 'package:it008_social_media/screens/sign_in_screen/sign_in.dart';
import 'package:it008_social_media/widgets/loading_widget.dart';
import 'package:provider/provider.dart';
import '../../utils/firebase_consts.dart';
import '../../utils/global_methods.dart';
import 'sign_up.dart';
import 'package:it008_social_media/screens/welcome_screen/welcome.dart';

class SignUp2 extends StatefulWidget {
  const SignUp2({super.key});

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  final GlobalKey<FormState> _infoKey = GlobalKey<FormState>();

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _description = TextEditingController();

  OutlineInputBorder _buildborder(Color color) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: color, width: 1));
  }

  DateTime date = DateTime(2022, 10, 16);
  final List<String> Gender = ['Male', 'Female'];
  String _dropDownValue = 'Male';
  bool _isLoading = false;

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
            key: _infoKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height_variable * 0.09,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(FontAwesomeIcons.angleLeft),
                  iconSize: 30,
                ),
                SizedBox(
                  height: height_variable * 0.02,
                ),
                Text(
                  'Personal Information',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: height_variable * 0.025),
                ),
                Text(
                  'Please fill the following',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: height_variable * 0.02),
                ),
                SizedBox(
                  height: height_variable * 0.01,
                ),
                Text(
                  'Full name',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: height_variable * 0.017),
                ),
                TextFormField(
                  validator: (String? inputVal) {
                    if (inputVal!.length < 6) {
                      return 'full name must be at least 6 characters';
                    }
                    return null;
                  },
                  controller: _fullName,
                  decoration: InputDecoration(
                      enabledBorder: _buildborder(Color(0xff006175)),
                      errorBorder: _buildborder(Colors.red),
                      focusedErrorBorder: _buildborder(Colors.red),
                      focusedBorder: _buildborder(Colors.blue),
                      disabledBorder: _buildborder(Color(0xff006175)),
                      hintText: "David James"),
                ),
                SizedBox(
                  height: height_variable * 0.02,
                ),
                Text(
                  'User Name',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: height_variable * 0.017),
                ),
                TextFormField(
                  controller: _userName,
                  validator: (String? inputVal) {
                    if (inputVal!.length < 6) {
                      return 'user name must be at least 6 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      enabledBorder: _buildborder(Color(0xff006175)),
                      errorBorder: _buildborder(Colors.red),
                      focusedErrorBorder: _buildborder(Colors.red),
                      focusedBorder: _buildborder(Colors.blue),
                      disabledBorder: _buildborder(Color(0xff006175)),
                      hintText: "DaJaRanger"),
                ),
                SizedBox(
                  height: height_variable * 0.02,
                ),
                Row(
                  children: [
                    Text(
                      'Date of birth',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: height_variable * 0.017),
                    ),
                    new Spacer(),
                    Text(
                      'Gender',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
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
                        width: width_variable * 0.349,
                        height: height_variable * 0.06,
                        decoration: BoxDecoration(
                            color: Color(0xfff2f2f2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Color(0xff006175))),
                        child: Center(
                            child: Text(
                          '${date.year}/${date.month}/${date.day}',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        )),
                      ),
                    ),
                    new Spacer(),
                    Container(
                      alignment: Alignment.center,
                      width: width_variable * 0.349,
                      height: height_variable * 0.06,
                      decoration: BoxDecoration(
                          color: Color(0xfff2f2f2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xff006175))),
                      child: DropdownButton<String>(
                        value: _dropDownValue,
                        items: Gender.map((String Gender) {
                          return DropdownMenuItem(
                              value: Gender, child: Text(Gender));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _dropDownValue = newValue!;
                          });
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height_variable * 0.02,
                ),
                Text(
                  'About',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  width: width_variable * 0.856,
                  height: height_variable * 0.14,
                  decoration: BoxDecoration(
                      color: Color(0xfff2f2f2),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xff006175))),
                  child: TextFormField(
                    validator: (String? inputVal) {
                      if (inputVal!.length < 1) {
                        return 'description name must be at least 1 characters';
                      }
                      return null;
                    },
                    controller: _description,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  height: height_variable * 0.04,
                ),
                GestureDetector(
                  onTap: () {
                    _submitFormOnRegister();
                    //Navigator.push(context, MaterialPageRoute(builder: ((context) => SignUp3())));
                  },
                  child: Container(
                    height: height_variable * 0.06,
                    width: width_variable * 0.856,
                    decoration: BoxDecoration(
                        color: Color(0xff006175),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      'Next',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontSize: height_variable * 0.022,
                          color: Colors.white),
                    )),
                  ),
                ),
                SizedBox(
                  height: height_variable * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
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
                                builder: ((context) => SignIn())));
                      },
                      child: Text('Sign in',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xff006175))),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void _submitFormOnRegister() async {
    final isValid = _infoKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _infoKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      //Navigator.push(context, MaterialPageRoute(builder: ((context) => SignUp3())));
      try {
        final User? user = authInstance.currentUser;
        final _uid = user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(_uid).update({
          'userName': _userName.text.toLowerCase().trim(),
          'fullName': _fullName.text.toLowerCase().trim(),
          'about': _description.text.toLowerCase().trim(),
          'gender': _dropDownValue,
          'dateOfBirth': date.toString(),
        });

        Provider.of<UserProvider>(context, listen: false).refreshUser();

        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => Welcome())));
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
