import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:it008_social_media/change_notifies/user_provider.dart';
import 'package:provider/provider.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  Future<bool> logOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Provider.of<UserProvider>(context, listen: false).refreshUser();
      return true;
    } catch (e) {
      return false;
    }
  }

  void getUserData(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.refreshUser();
  }
}
