import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:it008_social_media/screens/main_screen/main_screen.dart';
import '../../utils/firebase_consts.dart';
import '../../models/user_model.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:it008_social_media/screens/sign_up_screen/sign_up_2.dart';


class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin(context) async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    try{
      
      await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = authInstance.currentUser;
        final _uid = user!.uid;

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
            context, MaterialPageRoute(builder: ((context) => SignUp2())));
    } on FirebaseAuthException catch(error) {
      
    }


    
    notifyListeners();
  } 
}