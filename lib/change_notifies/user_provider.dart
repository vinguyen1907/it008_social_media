import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/could_store_method.dart';

class UserProvider with ChangeNotifier {
  Users? _user;
  final CloudStoreDataManagement _authMethods = CloudStoreDataManagement();

  Users get getUser => _user!;

  Future<void> refreshUser() async {
    Users user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}