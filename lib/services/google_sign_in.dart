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

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}